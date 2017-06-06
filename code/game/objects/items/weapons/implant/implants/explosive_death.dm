/obj/item/weapon/implantcase/dexplosive
	name = "glass case - 'explosive'"
	desc = "A case containing an explosive."
	imp = new /obj/item/weapon/implant/dexplosive


/obj/item/weapon/implant/dexplosive
	name = "explosive"
	desc = "And boom goes the weasel."
	icon_state = "implant_evil"
	implant_color = "r"

	get_data()
		var/dat = {"
			<b>Implant Specifications:</b><BR>
			<b>Name:</b> Robust Corp RX-78 Employee Management Implant<BR>
			<b>Life:</b> Activates upon death.<BR>
			<b>Important Notes:</b> Explodes<BR>
			<HR>
			<b>Implant Details:</b><BR>
			<b>Function:</b> Contains a compact, electrically detonated explosive that detonates upon receiving a specially encoded signal or upon host death.<BR>
			<b>Special Features:</b> Explodes<BR>
			<b>Integrity:</b> Implant will occasionally be degraded by the body's immune system and thus will occasionally malfunction."}
		return dat


	trigger(emote, mob/living/source)
		if(emote == "deathgasp")
			src.activate("death")
		return


	activate(var/cause)
		if(!cause || !src.imp_in)
			return
		explosion(src, -1, 0, 2, 3, 0)//This might be a bit much, dono will have to see.
		if(src.imp_in)
			src.imp_in.gib()

	islegal()
		return FALSE

