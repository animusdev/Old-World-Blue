/obj/item/organ/internal/eyes
	name = "eyeballs"
	icon_state = "eyes"
	gender = PLURAL
	organ_tag = O_EYES
	parent_organ = BP_HEAD
	var/eye_color = ""
	var/robo_color = "#000000"
	var/icon/mob_icon = null
	var/datum/species/species = null
	var/body_build = null

/obj/item/organ/internal/eyes/install(mob/living/carbon/human/H)
	if(..()) return 1
	// Apply our eye color to the target.
	if(eye_color)
		owner.eyes_color = eye_color
	sync_to_owner()
	owner.update_eyes()

/obj/item/organ/internal/eyes/sync_to_owner()
	if(!owner)
		return
	species = owner.species
	body_build = owner.body_build.index
	eye_color = owner.eyes_color ? owner.eyes_color : "#000000"

/obj/item/organ/internal/eyes/get_icon()
	mob_icon = new/icon(species.icobase, "eyes[body_build]")
	if(robotic >= ORGAN_ROBOT)
		mob_icon.Blend(robo_color, ICON_ADD)
	else
		mob_icon.Blend(eye_color, ICON_ADD)
	return mob_icon

/obj/item/organ/internal/eyes/get_icon_key()
	return "eyes[eye_color]"

/obj/item/organ/internal/eyes/take_damage(amount, var/silent=0)
	var/oldbroken = is_broken()
	..()
	if(is_broken() && !oldbroken && owner && !owner.stat)
		owner << "<span class='danger'>You go blind!</span>"

/obj/item/organ/internal/eyes/process() //Eye damage replaces the old eye_stat var.
	..()
	if(!owner)
		return
	if(is_bruised())
		owner.eye_blurry = 20
	if(is_broken())
		owner.eye_blind = 20


//// One eye ////

/obj/item/organ/internal/eyes/oneeye
	get_icon()
		mob_icon = icon(species.icobase, "left_eye[body_build]")
		mob_icon.Blend(eye_color, ICON_ADD)
		return mob_icon

/obj/item/organ/internal/eyes/oneeye/get_icon_key()
	return "eyes_left[eye_color]"

/obj/item/organ/internal/eyes/oneeye/right
	get_icon()
		mob_icon = icon(species.icobase, "right_eye[body_build]")
		mob_icon.Blend(eye_color, ICON_ADD)
		return mob_icon

/obj/item/organ/internal/eyes/oneeye/right/get_icon_key()
	return "eyes_right[eye_color]"

//// Heterohromia ////

/obj/item/organ/internal/eyes/heterohromia
	var/second_color = "#000000"
	get_icon()
		..()
		var/icon/one_eye = icon(species.icobase, "left_eye[body_build]")
		one_eye.Blend(second_color, ICON_ADD)
		mob_icon.Blend(one_eye, ICON_OVERLAY)
		return mob_icon

/obj/item/organ/internal/eyes/heterohromia/get_icon_key()
	return "eyes_hetero[eye_color]&[second_color]"

//// Eye-camera ////

/obj/item/eye_camera
	name = "eye camera"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "eye-cam"

/obj/item/eye_camera/attack_self(user)
	put_in_socket(user, user)

/obj/item/eye_camera/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(user.zone_sel.selecting == O_EYES)
		put_in_socket(user, M)
	else
		..()

/obj/item/eye_camera/proc/put_in_socket(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)
	if(target.eyecheck())
		user << "<span class='warning'>You can't access[user == target ? "" : " [target]'s"] eye-socket.</span>"
		return
	var/obj/item/organ/internal/eyes/mechanic/cam/eyes = target.internal_organs_by_name[O_EYES]
	if(eyes && istype(eyes))
		eyes.attackby(src, user)

/obj/item/organ/internal/eyes/mechanic
	robotic = ORGAN_ROBOT

/obj/item/organ/internal/eyes/mechanic/cam
	name = "mechanic eyes"
	var/obj/item/eye_camera/camera
	var/obj/item/eye_camera/linked_camera

/obj/item/organ/internal/eyes/mechanic/cam/New(holder, install, var/color = "#ffffff")
	..(holder, install)
	camera = new()
	linked_camera = camera

/obj/item/organ/internal/eyes/mechanic/cam/install()
	if(..()) return 1
	verbs += /obj/item/organ/internal/eyes/mechanic/cam/proc/switch_view

/obj/item/organ/internal/eyes/mechanic/cam/update_icon()
	if(owner)
		owner.update_eyes()

/obj/item/organ/internal/eyes/mechanic/cam/get_icon()
	..() //basic eyes + color
	var/icon/socket = icon(species.icobase, "left_eye[body_build]")
	if(camera)
		socket.Blend("#C0C0C0", ICON_ADD)
	mob_icon.Blend(socket, ICON_OVERLAY)
	return mob_icon

/obj/item/organ/internal/eyes/mechanic/cam/get_icon_key()
	return "eyes_[eye_color]&[camera?"full":"empty"]"

/obj/item/organ/internal/eyes/mechanic/cam/proc/switch_view()
	set name = "Toggle eye-cam view"
	set category = "IC"

	if(!owner)
		verbs -= /obj/item/organ/internal/eyes/mechanic/cam/proc/switch_view
		return

	if(owner.client.eye == linked_camera || (linked_camera in src))
		owner.reset_view()
		owner.visible_message(
			"<span class='notice'>You can hear something beeps in [owner] head.</span>",
			"<span class='notice'>You successfuly enable eye-cam remote view</span>",
			"<span class='warning'>You can hear long BEEP.</span>"
		)
	else
		owner.visible_message(
			"<span class='notice'>You can hear something beeps in [owner] head.</span>",
			"<span class='notice'>You successfuly disable eye-cam remote view</span>",
			"<span class='warning'>You can hear long BEEP.</span>"
		)
		owner.machine = src
		owner.reset_view(linked_camera)

/obj/item/organ/internal/eyes/mechanic/cam/check_eye(mob/living/carbon/human/H)
	if(H == owner)
		return 0
	else
		return ..()


/obj/item/organ/internal/eyes/mechanic/cam/verb/eject_cam()
	set name = "Eject eye-cam"
	set category = "IC"

	if(!camera || !camera in src) return
	owner.put_in_hands(camera)
	camera = null
	update_icon()

/obj/item/organ/internal/eyes/mechanic/cam/attackby(var/obj/item/eye_camera/C, mob/user)
	if(!istype(C))
		..()

	if(camera)
		user << "<span class='warning'>Eye-socket is not empty.</span>"
		return

	if(!owner)
		user << "<span class='notece'>You insert [C] into eye-socket.</span>"
	else if(user == owner)
		user.visible_message(
			"<span class='warning'>[user] start inserting [C] into eye-socket!</span>",
			"<span class='notice'>You start inserting [C] into your eye-socket</span>"
		)
		sleep(5)
		if(usr.get_active_hand() != C)
			user << "<span class='warning'>You need to keep [C] in active hand!</span>"
			return
		if(camera)
			user << "<span class='warning'>Your eye socket is not empty!</span>"
			return
	else
		user.visible_message(
			"<span class='warning'>[user] try to insert [C] into [owner]'s eye-socket</span>",
			"<span class='notice'>You try to insert [C] into [owner]'s eye-socket</span>"
		)
		if(do_mob(user, owner, 15))
			if(camera)
				user << "<span class='warning'>Eye-socket is not empty.</span>"
				return
			user.visible_message(
				"<span class='warning'>[user] insert [C] into [owner]'s eye-socket</span>",
				"<span class='warning'>You insert [src] into [owner]'s eye-socket</span>"
			)
	user.drop_from_inventory(C, src)
	camera = C
	update_icon()
	if(owner && camera == linked_camera)
		owner.reset_view()


