/obj/item/weapon/implantcase/loyalty
	name = "glass case - 'loyalty'"
	desc = "A case containing a loyalty implant."
	imp = /obj/item/weapon/implant/loyalty

/obj/item/weapon/implant/loyalty
	name = "loyalty implant"
	desc = "Makes you loyal or such."
	implant_color = "r"

	get_data()
		var/dat = {"
			<b>Implant Specifications:</b><BR>
			<b>Name:</b> Nanotrasen Employee Management Implant<BR>
			<b>Life:</b> Ten years.<BR>
			<b>Important Notes:</b> Personnel injected with this device tend to be much more loyal to the company.<BR>
			<HR>
			<b>Implant Details:</b><BR>
			<b>Function:</b> Contains a small pod of nanobots that manipulate the host's mental functions.<BR>
			<b>Special Features:</b> Will prevent and cure most forms of brainwashing.<BR>
			<b>Integrity:</b> Implant will last so long as the nanobots are inside the bloodstream."}
		return dat

	implanted(var/mob/living/carbon/human/H, var/obj/item/organ/external/affected)
		if(!istype(H))
			return FALSE
		var/datum/antagonist/antag_data = get_antag_data(H.mind.special_role)
		if(antag_data && (antag_data.flags & ANTAG_IMPLANT_IMMUNE))
			H.visible_message(
				"[H] seems to resist the implant!",
				"You feel the corporate tendrils of Nanotrasen try to invade your mind!"
			)
			return FALSE
		return ..()

	on_implanted(var/mob/living/carbon/human/H)
		clear_antag_roles(H.mind, 1)
		H << "<span class='notice'>You feel a surge of loyalty towards Nanotrasen.</span>"
