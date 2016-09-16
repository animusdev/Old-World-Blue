#define PROCESS_ACCURACY 10

/obj/item/organ/internal
	var/organ_tag = "organ"

/obj/item/organ/internal/install(mob/living/carbon/human/H)
	if(..()) return 1
	H.internal_organs += src
	var/obj/item/organ/internal/outdated = H.internal_organs_by_name[organ_tag]
	if(outdated)
		outdated.removed()
	H.internal_organs_by_name[organ_tag] = src
	var/obj/item/organ/external/E = H.organs_by_name[src.parent_organ]
	if(E)
		E.internal_organs |= src
	if(robotic)
		status |= ORGAN_ROBOT

/obj/item/organ/internal/Destroy()
	if(parent)
		parent.internal_organs -= src
		parent = null
	return ..()

/obj/item/organ/internal/removed(mob/living/user)
	if(!istype(owner)) return

	owner.internal_organs_by_name[organ_tag] = null
	owner.internal_organs -= src

	var/datum/reagent/blood/transplant_blood = locate(/datum/reagent/blood) in reagents.reagent_list
	transplant_data = list()
	if(!transplant_blood)
		transplant_data["species"] =    owner.species.name
		transplant_data["blood_type"] = owner.dna.b_type
		transplant_data["blood_DNA"] =  owner.dna.unique_enzymes
	else
		transplant_data["species"] =    transplant_blood.data["species"]
		transplant_data["blood_type"] = transplant_blood.data["blood_type"]
		transplant_data["blood_DNA"] =  transplant_blood.data["blood_DNA"]

	..()

/****************************************************
				INTERNAL ORGANS DEFINES
****************************************************/

// Brain is defined in brain_item.dm.
/obj/item/organ/internal/heart
	name = "heart"
	icon_state = "heart-on"
	organ_tag = "heart"
	parent_organ = "chest"
	dead_icon = "heart-off"

/obj/item/organ/internal/lungs
	name = "lungs"
	icon_state = "lungs"
	gender = PLURAL
	organ_tag = "lungs"
	parent_organ = "chest"

/obj/item/organ/internal/lungs/process()
	..()

	if(!owner)
		return

	if (germ_level > INFECTION_LEVEL_ONE)
		if(prob(5))
			owner.emote("cough")		//respitory tract infection

	if(is_bruised())
		if(prob(2))
			spawn owner.emote("me", 1, "coughs up blood!")
			owner.drip(10)
		if(prob(4))
			spawn owner.custom_emote("gasps for air!")
			owner.losebreath += 15

/obj/item/organ/internal/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	gender = PLURAL
	organ_tag = "kidneys"
	parent_organ = "groin"

/obj/item/organ/internal/kidneys/process()
	..()
	if(!owner)
		return

	// Coffee is really bad for you with busted kidneys.
	// This should probably be expanded in some way, but fucked if I know
	// what else kidneys can process in our reagent list.
	var/datum/reagent/coffee = locate(/datum/reagent/drink/coffee) in owner.reagents.reagent_list
	if(coffee)
		if(is_broken())
			owner.adjustToxLoss(0.3 * PROCESS_ACCURACY)
		else if(is_bruised())
			owner.adjustToxLoss(0.1 * PROCESS_ACCURACY)


/obj/item/organ/internal/eyes
	name = "eyeballs"
	icon_state = "eyes"
	gender = PLURAL
	organ_tag = "eyes"
	parent_organ = "head"
	var/eye_colour = ""

/obj/item/organ/internal/eyes/install(mob/living/carbon/human/H)
	if(..()) return 1
	// Apply our eye colour to the target.
	if(eye_colour)
		owner.eyes_color = eye_colour
	else
		update_colour()
	owner.update_eyes()

/obj/item/organ/internal/eyes/proc/get_icon()
	var/icon/eyes_icon = new/icon(owner.species.icobase, "eyes_[owner.body_build]")
	eyes_icon.Blend(eye_colour, ICON_ADD)
	return eyes_icon

/obj/item/organ/internal/eyes/proc/update_colour()
	if(!owner)
		return
	eye_colour = owner.eyes_color ? owner.eyes_color : "#000000"

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

/obj/item/eye_camera
	name = "eye camera"
	var/colour = "#ffffff"

/obj/item/eye_camera/attack_self(user)
	put_in_socket(user, user)

/obj/item/eye_camera/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(user.zone_sel.selecting == "eyes")
		put_in_socket(user, M)
	else
		..()

/obj/item/eye_camera/proc/put_in_socket(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)
	if(target.eyecheck())
		user << "<span class='warning'>You can't access[user == target ? "" : " [target]'s"] eye-socket.</span>"
		return
	var/obj/item/organ/internal/eyes/mechanic/cam/eyes = target.internal_organs_by_name["eyes"]
	if(eyes && istype(eyes))
		eyes.attackby(src, user)


/obj/item/organ/internal/eyes/mechanic/cam
	name = "mechanic eyes"
	var/obj/item/eye_camera/camera
	var/obj/item/eye_camera/linked_camera

/obj/item/organ/internal/eyes/mechanic/cam/New(holder, install, var/color = "#ffffff")
	..(holder, install)
	camera = new()
	linked_camera = camera
	camera.colour = color

/obj/item/organ/internal/eyes/mechanic/cam/verb/eject_cam()
	if(!owner || usr!=owner) return
	if(!camera || !camera in src) return
	owner.put_in_hands(camera)
	camera = null
	verbs -= /obj/item/organ/internal/eyes/mechanic/cam/verb/eject_cam

/obj/item/organ/internal/eyes/mechanic/cam/attackby(var/obj/item/eye_camera/C, mob/user)
	if(!istype(C))
		..()

	if(camera)
		user << "<span class='warning'>Eye-socket is not empty.</span>"
		return

	if(!owner)
		user << "<span class='notece'>You insert [C] into eye-socket.</span>"
	else if(user == owner)
		user.visible_message("<span class='warning'>[user] start inserting [C] into eye-socket!</span>",\
					"<span class='notice'>You start inserting [C] into your eye-socket</span>")
		sleep(5)
		if(usr.get_active_hand() != C)
			user << "<span class='warning'>You need to keep [C] in active hand!</span>"
			return
		if(camera)
			user << "<span class='warning'>Your eye socket is not empty!</span>"
			return
		verbs |= /obj/item/organ/internal/eyes/mechanic/cam/verb/eject_cam
	else
		user.visible_message("<span class='warning'>[user] try to insert [C] into [owner]'s eye-socket</span>",\
						"<span class='notice'>You try to insert [C] into [owner]'s eye-socket</span>")
		if(do_mob(user, owner, 15))
			if(camera)
				user << "<span class='warning'>Eye-socket is not empty.</span>"
				return
			user.visible_message("<span class='warning'>[user] insert [C] into [owner]'s eye-socket</span>",\
							"<span class='warning'>You insert [src] into [owner]'s eye-socket</span>")
			verbs |= /obj/item/organ/internal/eyes/mechanic/cam/verb/eject_cam
	user.drop_from_inventory(C, src)
	camera = C


/obj/item/organ/internal/liver
	name = "liver"
	icon_state = "liver"
	organ_tag = "liver"
	parent_organ = "groin"

/obj/item/organ/internal/liver/process()

	..()

	if(!owner)
		return

	if (germ_level > INFECTION_LEVEL_ONE)
		if(prob(1))
			owner << "\red Your skin itches."
	if (germ_level > INFECTION_LEVEL_TWO)
		if(prob(1))
			spawn owner.vomit()

	if(owner.life_tick % PROCESS_ACCURACY == 0)

		//High toxins levels are dangerous
		if(owner.getToxLoss() >= 60 && !owner.reagents.has_reagent("anti_toxin"))
			//Healthy liver suffers on its own
			if (src.damage < min_broken_damage)
				src.damage += 0.2 * PROCESS_ACCURACY
			//Damaged one shares the fun
			else
				var/obj/item/organ/internal/O = pick(owner.internal_organs)
				if(O)
					O.damage += 0.2  * PROCESS_ACCURACY

		//Detox can heal small amounts of damage
		if (src.damage && src.damage < src.min_bruised_damage && owner.reagents.has_reagent("anti_toxin"))
			src.damage -= 0.2 * PROCESS_ACCURACY

		if(src.damage < 0)
			src.damage = 0

		// Get the effectiveness of the liver.
		var/filter_effect = 3
		if(is_bruised())
			filter_effect -= 1
		if(is_broken())
			filter_effect -= 2

		// Do some reagent processing.
		if(owner.chem_effects[CE_ALCOHOL_TOXIC])
			if(filter_effect < 3)
				owner.adjustToxLoss(owner.chem_effects[CE_ALCOHOL_TOXIC] * 0.1 * PROCESS_ACCURACY)
			else
				take_damage(owner.chem_effects[CE_ALCOHOL_TOXIC] * 0.1 * PROCESS_ACCURACY, prob(1)) // Chance to warn them

/obj/item/organ/internal/appendix
	name = "appendix"
	icon_state = "appendix"
	parent_organ = "groin"
	organ_tag = "appendix"

/obj/item/organ/internal/appendix/removed()
	if(owner)
		var/inflamed = 0
		for(var/datum/disease/appendicitis/appendicitis in owner.viruses)
			inflamed = 1
			appendicitis.cure()
			owner.resistances += appendicitis
		if(inflamed)
			icon_state = "appendixinflamed"
			name = "inflamed appendix"
	..()
