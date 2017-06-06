/obj/item/weapon/implantcase/wizard
	name = "glass case - 'wizard'"
	desc = "A case containing wizard emulation implant."
	imp = /obj/item/weapon/implant/wizard

/obj/item/weapon/implant/wizard
	name = "magic power emulation implant"
	desc = "Radiate wizard waves what allow bypassing magic protect."

	get_data()
		var/dat = {"
			<b>Implant Specifications:</b><BR>
			<b>Name:</b> Experemental magic power emulation implant<BR>
			<b>Life:</b> Undefined.<BR>
			<HR>
			<b>Implant Details:</b><BR>
			<b>Function:</b> radiate special waves similar to natural.<BR>
		"}
		return dat

	on_implanted(mob/living/carbon/human/source)
		source.show_message("You feel how magic power fill your body.")