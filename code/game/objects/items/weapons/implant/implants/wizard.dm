/obj/item/weapon/implantcase/wizard
	name = "glass case - 'wizard'"
	desc = "A case containing wizard emulation implant."
	imp = /obj/item/weapon/implant/wizard

/obj/item/weapon/implant/wizard
	name = "magic power emulation implant"
	desc = "Emitates special wizard brainwaves that allows bypassing protection of magical stuff."

	get_data()
		var/dat = {"
			<b>Implant Specifications:</b><BR>
			<b>Name:</b> Experimental implant, emulating wizard's magic field.<BR>
			<b>Life:</b> Undefined.<BR>
			<HR>
			<b>Implant Details:</b><BR>
			<b>Function:</b> radiate special waves similar to natural.<BR>
		"}
		return dat

	on_implanted(mob/living/carbon/human/source)
		source.show_message("You feel wizardier.")