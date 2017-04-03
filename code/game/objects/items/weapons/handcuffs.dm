/obj/item/weapon/handcuffs
	name = "handcuffs"
	desc = "Use this to keep prisoners in line."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "handcuff"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 5
	w_class = 2.0
	throw_speed = 2
	throw_range = 5
	origin_tech = list(TECH_MATERIAL = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 500)
	var/dispensed_type = 0
	var/breakouttime = 1200 //Deciseconds = 120s = 2 minutes
	var/cuff_sound = 'sound/weapons/handcuffs.ogg'
	var/cuff_type = "handcuffs"

/obj/item/weapon/legcuffs
	name = "legcuffs"
	desc = "Use this to keep prisoners in line."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "handcuff"
	flags = CONDUCT
	throwforce = 0
	w_class = 3.0
	origin_tech = list(TECH_MATERIAL = 1)
	var/breakouttime = 300	//Deciseconds = 30s = 0.5 minute

/obj/item/weapon/handcuffs/attack(var/mob/living/carbon/C, var/mob/living/user)

	if(!user.IsAdvancedToolUser())
		return

	//TODO: DNA3 clown_block
	/*
	if ((CLUMSY in user.mutations) && prob(50))
		user << "<span class='warning'>Uh ... how do those things work?!</span>"
		place_handcuffs(user, user)
		return
	*/

	if(!C.handcuffed)
		if (C == user)
			place_handcuffs(user, user)
			return

		//check for an aggressive grab (or robutts)
		var/can_place
		if(istype(user, /mob/living/silicon/robot))
			can_place = 1
		else
			for (var/obj/item/weapon/grab/G in C.grabbed_by)
				if (G.loc == user && G.state >= GRAB_AGGRESSIVE)
					can_place = 1
					break

		if(can_place)
			place_handcuffs(C, user)
		else
			user << "<span class='danger'>You need to have a firm grip on [C] before you can put \the [src] on!</span>"

/obj/item/weapon/handcuffs/proc/place_handcuffs(var/mob/living/carbon/target, var/mob/user)
	playsound(src.loc, cuff_sound, 30, 1, -2)

	var/mob/living/carbon/human/H = target
	if(!istype(H))
		return

	if (!H.has_organ_for_slot(slot_handcuffed))
		user << "<span class='danger'>\The [H] needs at least two wrists before you can cuff them together!</span>"
		return

	if(istype(H.gloves,/obj/item/clothing/gloves/rig)) // Can't cuff someone who's in a deployed hardsuit.
		user << "<span class='danger'>The cuffs won't fit around \the [H.gloves]!</span>"
		return

	user.visible_message("<span class='danger'>\The [user] is attempting to put [cuff_type] on \the [H]!</span>")

	if(!do_mob(user, target, 30))
		return

	admin_attack_log(user, H,
		"Attempted to handcuff [H.name] ([H.ckey])",
		"Has been handcuffed (attempt) by [user.name] ([user.ckey])",
		"attempted to handcuff"
	)

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	user.do_attack_animation(H)

	user.visible_message("<span class='danger'>\The [user] has put [cuff_type] on \the [H]!</span>")

	// Apply cuffs.
	var/obj/item/weapon/handcuffs/cuffs = src
	if(dispensed_type)
		cuffs = new dispensed_type(get_turf(user))
	else
		user.drop_from_inventory(cuffs)
	cuffs.loc = target
	target.handcuffed = cuffs
	target.update_inv_handcuffed()
	return

/mob/living/carbon/human
	var/last_chew = 0

/mob/living/carbon/human/RestrainedClickOn(var/atom/A)
	if (A != src) return ..()
	if (last_chew + 26 > world.time) return

	var/mob/living/carbon/human/H = A
	if (!H.handcuffed) return
	if (H.a_intent != I_HURT) return
	if (H.zone_sel.selecting != O_MOUTH) return
	if (H.wear_mask) return
	if (istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket)) return

	var/obj/item/organ/external/O = H.get_organ( H.hand ? BP_L_HAND : BP_R_HAND)
	if (!O) return

	if(O.take_damage(3,0,1,1,"teeth marks"))
		H.UpdateDamageIcon()

	self_attack_log(H, "chews on his/her [O.name]!")
	H.visible_message("[H] chews on \his [O.name]!", "\red You chew on your [O.name]!")

	last_chew = world.time

/obj/item/weapon/handcuffs/cable
	name = "cable restraints"
	desc = "Looks like some cables tied together. Could be used to tie something up."
	icon_state = "cuff_white"
	breakouttime = 300 //Deciseconds = 30s
	cuff_sound = 'sound/weapons/cablecuff.ogg'
	cuff_type = "cable restraints"

/obj/item/weapon/handcuffs/cable/red
	color = "#DD0000"

/obj/item/weapon/handcuffs/cable/yellow
	color = "#DDDD00"

/obj/item/weapon/handcuffs/cable/blue
	color = "#0000DD"

/obj/item/weapon/handcuffs/cable/green
	color = "#00DD00"

/obj/item/weapon/handcuffs/cable/pink
	color = "#DD00DD"

/obj/item/weapon/handcuffs/cable/orange
	color = "#DD8800"

/obj/item/weapon/handcuffs/cable/cyan
	color = "#00DDDD"

/obj/item/weapon/handcuffs/cable/white
	color = "#FFFFFF"

/obj/item/weapon/handcuffs/cable/attackby(var/obj/item/I, mob/user as mob)
	..()
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		if (R.use(1))
			var/obj/item/weapon/material/wirerod/W = new(get_turf(user))
			user.put_in_hands(W)
			user << "<span class='notice'>You wrap the cable restraint around the top of the rod.</span>"
			qdel(src)
			update_icon(user)

/obj/item/weapon/handcuffs/tape
	name = "tape restraints"
	desc = "A few pieces of tape glued together. It looks unreliable."
	icon_state = "tapecuffs"
	breakouttime = 300

/obj/item/weapon/handcuffs/tape/dropped()
	new/obj/item/weapon/tape_piece(src.loc)
	qdel(src)

/*
/obj/item/weapon/handcuffs/tape_dispenser
	name = "tape restraints"
	cuff_sound = 'sound/weapons/tapecuff.wav'
	desc = "A few pieces of tape glued together. It looks unreliable."
	icon_state = "tapecuffs"
	dispensed_type = /obj/item/weapon/handcuffs/tape
*/

/obj/item/weapon/handcuffs/cyborg
	dispensed_type = /obj/item/weapon/handcuffs