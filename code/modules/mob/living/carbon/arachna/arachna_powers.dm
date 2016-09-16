/datum/arachna
	var/purchasedpowers = list()

/datum/arachna/New(var/gender=FEMALE)
	..()



/mob/proc/arachna_power(var/needweb=0, var/needfood=0)
	var/mob/living/carbon/human/M = src
	var/obj/item/organ/internal/arachna/silk_gland/P = M.internal_organs_by_name["silk_gland"]
	if(!P)
		src << "<span class='warning'>Problem witch silk gland.</span>"
		return 0
	else if (P.silk < needweb)
		src << "<span class='warning'>Need more silk.</span>"
		return 0
	P.silk -= needweb
	src << "[src] you pass!"
	return 1

/mob/proc/silk_net()
	set category = "Abilities"
	set name = "Net"

	if(!arachna_power(25))
		return

	var/mob/living/M = src

	if(M.l_hand && M.r_hand)
		M << "<span class='danger'>Your hands are full.</span>"
		return

	var/obj/item/weapon/energy_net/arachna_net/net = new(M)
	//net.creator = M
	M.put_in_hands(net)

/mob/proc/jump()
	src << "Not work right now!"
	return 0