/datum/power/changeling/arm_blade
	name = "Arm Blade"
	desc = "We reform one of our arms into a deadly blade."
	helptext = "We may retract our armblade by dropping it.  It can deflect projectiles."
	enhancedtext = "The blade will have armor peneratration."
	genomecost = 2
	verbpath = /mob/living/proc/changeling_arm_blade

//Grows a scary, and powerful arm blade.
/mob/living/proc/changeling_arm_blade()
	set category = "Changeling"
	set name = "Arm Blade (20)"
/*
	if(src.mind.changeling.recursive_enhancement)
		if(changeling_generic_weapon(/obj/item/weapon/melee/arm_blade/greater))
			src << "<span class='notice'>We prepare an extra sharp blade.</span>"
			src.mind.changeling.recursive_enhancement = 0
			return 1

	else
		if(changeling_generic_weapon(/obj/item/weapon/melee/arm_blade))
			return 1
		return 0
*/
	if(changeling_generic_weapon(/obj/item/weapon/melee/arm_blade))
		visible_message(
			"<span class='warning'>A grotesque blade forms around [src]\'s arm!</span>",
			"<span class='warning'>Our arm twists and mutates, transforming it into a deadly blade.</span>",
			"<span class='italics'>You hear organic matter ripping and tearing!</span>"
		)
		return 1
	return 0

/obj/item/weapon/melee/arm_blade
	name = "arm blade"
	desc = "A grotesque blade made out of bone and flesh that cleaves through people as a hot knife through butter."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "arm_blade"
	item_state = "arm_blade"
	w_class = 5.0
	force = 40
	sharp = 1
	edge = 1
	pry = 1
	abstract = 1
	canremove = 0
	anchored = 1
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
/*
/obj/item/weapon/melee/arm_blade/greater
	name = "arm greatblade"
	desc = "A grotesque blade made out of bone and flesh that cleaves through people and armor as a hot knife through butter."
	armor_penetration = 30
*/

/obj/item/weapon/melee/arm_blade/attack_self(var/mob/user)
	user.drop_from_inventory(src)

/obj/item/weapon/melee/arm_blade/dropped(var/mob/user)
	user.visible_message(
		"<span class='warning'>With a sickening crunch, [user] reforms their arm blade into an arm!</span>",
		"<span class='notice'>We assimilate the weapon back into our body.</span>",
		"<span class='italics'>You hear organic matter ripping and tearing!</span>"
	)
	playsound(src, 'sound/effects/blobattack.ogg', 30, 1)
	qdel(src)
