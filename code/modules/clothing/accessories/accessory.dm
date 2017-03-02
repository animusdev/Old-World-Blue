/obj/item/clothing/accessory
	name = "tie"
	desc = "A neosilk clip-on tie."
	icon = 'icons/inv_slots/acessories/icon.dmi'
	icon_state = "bluetie"
	item_state = ""	//no inhands
	slot_flags = SLOT_TIE
	w_class = 1
	var/slot = "decor"
	var/obj/item/clothing/has_suit = null		//the suit the tie may be attached to
	var/image/inv_overlay = null	//overlay used when attached to clothing.


/obj/item/clothing/accessory/Destroy()
	on_removed()
	return ..()

//when user attached an accessory to S
/obj/item/clothing/accessory/proc/on_attached(var/obj/item/clothing/S, var/mob/user)
	if(!istype(S))
		return
	has_suit = S
	loc = has_suit
	if(!inv_overlay)
		inv_overlay = image('icons/inv_slots/acessories/mob.dmi', icon_state)
	has_suit.overlays += inv_overlay

	if(user)
		user << "<span class='notice'>You attach \the [src] to \the [has_suit].</span>"
		add_fingerprint(user)

/obj/item/clothing/accessory/proc/on_removed(var/mob/user)
	if(!has_suit)
		return
	has_suit.overlays -= inv_overlay
	has_suit = null
	if(user)
		usr.put_in_hands(src)
		add_fingerprint(user)
	else
		forceMove(get_turf(src))

//default attackby behaviour
/obj/item/clothing/accessory/attackby(obj/item/I, mob/user)
	..()

//default attack_hand behaviour
/obj/item/clothing/accessory/attack_hand(mob/user as mob)
	if(has_suit)
		return	//we aren't an object on the ground so don't call parent
	..()

/obj/item/clothing/accessory/blue
	name = "blue tie"
	icon_state = "bluetie"

/obj/item/clothing/accessory/red
	name = "red tie"
	icon_state = "redtie"

/obj/item/clothing/accessory/blue_clip
	name = "blue tie with a clip"
	icon_state = "bluecliptie"

/obj/item/clothing/accessory/blue_long
	name = "blue long tie"
	icon_state = "bluelongtie"

/obj/item/clothing/accessory/red_clip
	name = "red tie with a clip"
	icon_state = "redcliptie"

/obj/item/clothing/accessory/red_long
	name = "red long tie"
	icon_state = "redlongtie"

/obj/item/clothing/accessory/black
	name = "black tie"
	icon_state = "blacktie"

/obj/item/clothing/accessory/darkgreen
	name = "dark green tie"
	icon_state = "dgreentie"

/obj/item/clothing/accessory/yellow
	name = "yellow tie"
	icon_state = "yellowtie"

/obj/item/clothing/accessory/navy
	name = "navy tie"
	icon_state = "navytie"

/obj/item/clothing/accessory/white
	name = "white tie"
	icon_state = "whitetie"

/obj/item/clothing/accessory/horrible
	name = "horrible tie"
	desc = "A neosilk clip-on tie. This one is disgusting."
	icon_state = "horribletie"

/obj/item/clothing/accessory/stethoscope
	name = "stethoscope"
	desc = "An outdated medical apparatus for listening to the sounds of the human body. It also makes you look like you know what you're doing."
	icon_state = "stethoscope"
	w_class = 2

/obj/item/clothing/accessory/stethoscope/do_surgery(mob/living/carbon/human/M, mob/living/user)
	if(user.a_intent != I_HELP) //in case it is ever used as a surgery tool
		return ..()
	attack(M, user) //default surgery behaviour is just to scan as usual
	return 1

/obj/item/clothing/accessory/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && isliving(user))
		if(user.a_intent == I_HELP)
			var/body_part = parse_zone(user.zone_sel.selecting)
			if(body_part)
				var/their = "their"
				switch(M.gender)
					if(MALE)	their = "his"
					if(FEMALE)	their = "her"

				var/sound = "heartbeat"
				var/sound_strength = "cannot hear"
				var/heartbeat = 0
				if(M.species && M.species.has_organ[O_HEART])
					var/obj/item/organ/internal/heart/heart = M.internal_organs_by_name[O_HEART]
					if(heart && !heart.robotic)
						heartbeat = 1
				if(M.stat == DEAD || (M.status_flags&FAKEDEATH))
					sound_strength = "cannot hear"
					sound = "anything"
				else
					switch(body_part)
						if(BP_CHEST)
							sound_strength = "hear"
							sound = "no heartbeat"
							if(heartbeat)
								var/obj/item/organ/internal/heart/heart = M.internal_organs_by_name[O_HEART]
								if(heart.is_bruised() || M.getOxyLoss() > 50)
									sound = "[pick ("odd noises", "spasmodic")] heartbeat"
								else if(heart.is_hurt())
									sound = "gurgling in heartbeat"
								else if(heart.is_damaged())
									sound = "weak noises in heartbeat"
								else
									sound = "healthy heartbeat"

							var/obj/item/organ/internal/heart/L = M.internal_organs_by_name[O_LUNGS]
							if(!L || M.losebreath)
								sound += " and no respiration"
							else if(M.is_lung_ruptured() || M.getOxyLoss() > 50)
								sound += " and [pick("wheezing","gurgling")] sounds"
							else if(M.is_lung_ruptured())
								sound += " and sizzling sounds"
							else
								sound += " and healthy respiration"
						if(O_EYES,O_MOUTH)
							sound_strength = "cannot hear"
							sound = "anything"
						else
							if(heartbeat)
								sound_strength = "hear a weak"
								sound = "pulse"

				user.visible_message("[user] places [src] against [M]'s [body_part] and listens attentively.", "You place [src] against [their] [body_part]. You [sound_strength] [sound].")
				return
	return ..(M,user)


//Medals
/obj/item/clothing/accessory/medal
	name = "bronze medal"
	desc = "A bronze medal."
	icon_state = "bronze"

/obj/item/clothing/accessory/medal/conduct
	name = "distinguished conduct medal"
	desc = "A bronze medal awarded for distinguished conduct. Whilst a great honor, this is most basic award on offer. It is often awarded by a captain to a member of their crew."

/obj/item/clothing/accessory/medal/bronze_heart
	name = "bronze heart medal"
	desc = "A bronze heart-shaped medal awarded for sacrifice. It is often awarded posthumously or for severe injury in the line of duty."
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/nobel_science
	name = "nobel sciences award"
	desc = "A bronze medal which represents significant contributions to the field of science or engineering."

/obj/item/clothing/accessory/medal/silver
	name = "silver medal"
	desc = "A silver medal."
	icon_state = "silver"

/obj/item/clothing/accessory/medal/silver/valor
	name = "medal of valor"
	desc = "A silver medal awarded for acts of exceptional valor."

/obj/item/clothing/accessory/medal/silver/security
	name = "robust security award"
	desc = "An award for distinguished combat and sacrifice in defence of corporate commercial interests. Often awarded to security staff."

/obj/item/clothing/accessory/medal/gold
	name = "gold medal"
	desc = "A prestigious golden medal."
	icon_state = "gold"

/obj/item/clothing/accessory/medal/gold/captain
	name = "medal of captaincy"
	desc = "A golden medal awarded exclusively to those promoted to the rank of captain. It signifies the codified responsibilities of a captain, and their undisputable authority over their crew."

/obj/item/clothing/accessory/medal/gold/heroism
	name = "medal of exceptional heroism"
	desc = "An extremely rare golden medal awarded only by high ranking officials. To recieve such a medal is the highest honor and as such, very few exist. This medal is almost never awarded to anybody but distinguished veteran staff."

//Scarves

/obj/item/clothing/accessory/scarf
	name = "scarf"
	desc = "A stylish scarf. The perfect winter accessory for those with a keen fashion sense, and those who just can't handle a cold breeze on their necks."
	w_class = 2

/obj/item/clothing/accessory/scarf/red
	name = "red scarf"
	icon_state = "redscarf"

/obj/item/clothing/accessory/scarf/green
	name = "green scarf"
	icon_state = "greenscarf"

/obj/item/clothing/accessory/scarf/darkblue
	name = "dark blue scarf"
	icon_state = "darkbluescarf"

/obj/item/clothing/accessory/scarf/purple
	name = "purple scarf"
	icon_state = "purplescarf"

/obj/item/clothing/accessory/scarf/yellow
	name = "yellow scarf"
	icon_state = "yellowscarf"

/obj/item/clothing/accessory/scarf/orange
	name = "orange scarf"
	icon_state = "orangescarf"

/obj/item/clothing/accessory/scarf/lightblue
	name = "light blue scarf"
	icon_state = "lightbluescarf"

/obj/item/clothing/accessory/scarf/white
	name = "white scarf"
	icon_state = "whitescarf"

/obj/item/clothing/accessory/scarf/black
	name = "black scarf"
	icon_state = "blackscarf"

/obj/item/clothing/accessory/scarf/zebra
	name = "zebra scarf"
	icon_state = "zebrascarf"

/obj/item/clothing/accessory/scarf/christmas
	name = "christmas scarf"
	icon_state = "christmasscarf"

/obj/item/clothing/accessory/amulet
	slot_flags = SLOT_TIE|SLOT_MASK
	desc = "An ancient amulet adorned with pictures"

/obj/item/clothing/accessory/amulet/dogtag
	name = "dog tag"
	desc = "Identification tags worn by military personnel."
	var/owner_name = ""
	var/owner_rank = ""
	var/owner_blood = ""
	icon_state = "dogtag"

/obj/item/clothing/accessory/amulet/dogtag/examine(user, return_dist = 1)
	. = ..()
	if(.<3)
		user << "Current owner data:"
		user << " Name: [owner_name]"
		user << " Rank: [owner_rank]"
		user << " Blood type: [owner_blood]"

/obj/item/clothing/accessory/amulet/dogtag/New(new_loc)
	..()
	set_owner(new_loc)

/obj/item/clothing/accessory/amulet/dogtag/proc/set_owner(var/mob/living/carbon/human/user)
	if(!istype(user))
		return

	owner_name = user.real_name
	if (user.job == "Assistant")
		switch(user.age)
			if(0 to 30)
				owner_rank = "Recruit"
			if (30 to 50)
				owner_rank = "Demobilized"
			else
				owner_rank = "Veteran"
	else
		owner_rank = user.job

	if (user.dna)
		owner_blood = user.b_type

/obj/item/clothing/accessory/amulet/aquila
	name = "aquila"
	desc = "You can see the Emperor smiling in the reflection."
	icon_state = "aquila"
/*
/obj/item/clothing/accessory/amulet/khorne
	name = "khorne amulet"
	icon_state = "khorne_amulet"

/obj/item/clothing/accessory/amulet/nurgle
	name = "nurgle amulet"
	icon_state = "nurgle_amulet"

/obj/item/clothing/accessory/amulet/slaanesh
	name = "slaanesh amulet"
	icon_state = "slaanesh_amulet"

/obj/item/clothing/accessory/amulet/tzeench
	name = "tzeench amulet"
	icon_state = "tzeentch_amulet"

/obj/item/clothing/accessory/amulet/chaos
	name = "chaos undivided amulet"
	icon_state = "chaos_amulet"
*/
