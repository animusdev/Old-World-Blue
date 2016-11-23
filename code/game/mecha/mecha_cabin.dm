/obj/cabin
	name = "pilot"
	density = 1
	opacity = 1
	anchored = 1
	unacidable = 1 //and no deleting hoomans inside
	var/obj/mecha/chasis = null
	var/mob/living/carbon/occupant = null
	var/dna	//dna-locking the mech


/obj/cabin/New(var/obj/mecha/M)
	..()
	if(!istype(M))
		qdel(src)
		return
	chasis = M

