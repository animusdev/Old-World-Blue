/datum/appearance
	var/name = "Unknown"
	var/age = 30
	var/list/slots = new

/datum/appearance/sync_to_human(var/mob/living/carbon/human/H)
	name = H.name
	age = H.age
	var/obj/item/equipped = null
	for(var/slot in slot_equipment_priority)
		equipped = H.get_equipped_item(slot)
		if(equipped)
			slots[slot] = list(type = equipped.type, blooded = equipped.blooded)


/mob/living/carbon/human
	var/obj/shapeshifter/shapeshifter

/mob/living/carbon/human/on_examine(atom/A)
	..()

	if(shapeshifter)
		shapeshifter.on_examine(A)

/obj/shapeshifter/proc/on_examine(mob/living/carbon/human/H)
	if(istype(H))
		src << "Shapeshifter: \[<a href='byond://?src=\ref[src];save=\ref[H]>save appearance</a>]"
		if(!H.species.name in known_species)
			known_species += H.species.name
			src << SPAN_NOTE("You have remember new species - [H.species.name]")

/obj/shapeshifter/Topic(href, href_list)
	if(usr != owner)
		return
	if(href_list["save"])
		var/mob/living/carbon/human/H = href_list["save"]
		if(!H in view(world.view, owner))
			return
		save_appearance(H)

/obj/shapeshifter/proc/save_appearance(mob/living/carbon/human/H)
	if(!H return)






