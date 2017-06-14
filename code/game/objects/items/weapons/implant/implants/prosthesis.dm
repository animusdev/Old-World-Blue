/obj/item/weapon/implant/prosthesis_inhibition
	name = "prosthesis inhibition implant"
	desc = "Prevent embed electronics from being activated."

	get_data()
		var/dat = {"
			<b>Implant Specifications:</b><BR>
			<b>Name:</b> NanoTrasen \"Prosthesis Restrict\" implant<BR>
			<b>Life:</b> Up to three days.<BR>
			<HR>
			<b>Implant Details:</b><BR>
			<b>Function:</b> deactivate and lock prosthesis special functionality including embed modules.<BR>
			<b>Integrity:</b> Implant will occasionally be degraded by the body's immune system."}
		return dat

	on_implanted(mob/living/carbon/human/source)
		if(malfunction)
			return

		for(var/obj/item/organ/external/E in source.organs)
			if(istype(E, /obj/item/organ/external/robotic))
				var/obj/item/organ/external/robotic/R = E
				R.deactivate()
				source << SPAN_WARN("Your [E] automaticly deactivated and locked!")
			if(istype(E.module, /obj/item/organ_module/active))
				var/obj/item/organ_module/active/M = E.module
				M.deactivate(source, E)
				source << SPAN_WARN("[M] in your [E] automaticly deactivated and locked!")