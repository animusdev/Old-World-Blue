/obj/item/weapon/implantcase/explosive
	name = "glass case - 'explosive'"
	desc = "A case containing an explosive implant."
	imp = new /obj/item/weapon/implant/explosive

//BS12 Explosive
/obj/item/weapon/implant/explosive
	name = "explosive implant"
	desc = "A military grade micro bio-explosive. Highly dangerous."
	var/elevel = "Localized Limb"
	var/phrase = "supercalifragilisticexpialidocious"
	icon_state = "implant_evil"
	implant_color = "r"

	get_data()
		var/dat = {"
			<b>Implant Specifications:</b><BR>
			<b>Name:</b> Robust Corp RX-78 Intimidation Class Implant<BR>
			<b>Life:</b> Activates upon codephrase.<BR>
			<b>Important Notes:</b> Explodes<BR>
			<HR>
			<b>Implant Details:</b><BR>
			<b>Function:</b> Contains a compact, electrically detonated explosive that detonates upon receiving a specially encoded signal or upon host death.<BR>
			<b>Special Features:</b> Explodes<BR>
			<b>Integrity:</b> Implant will occasionally be degraded by the body's immune system and thus will occasionally malfunction."}
		return dat

	hear_talk(mob/M, msg)
		hear(msg)
		return

	hear(var/msg)
		var/list/replacechars = list("'" = "","\"" = "",">" = "","<" = "","(" = "",")" = "")
		msg = replace_characters(msg, replacechars)
		if(findtext(msg,phrase))
			activate()
			qdel(src)

	activate()
		if (malfunction == MALFUNCTION_PERMANENT)
			return

		var/need_gib = null
		if(istype(imp_in, /mob/))
			var/mob/T = imp_in
			log_game("Explosive implant triggered in [key_name(T)].", T)
			need_gib = 1

			if(ishuman(imp_in))
				if (elevel == "Localized Limb")
					if(part) //For some reason, small_boom() didn't work. So have this bit of working copypaste.
						imp_in.visible_message("\red Something beeps inside [imp_in][part ? "'s [part.name]" : ""]!")
						playsound(loc, 'sound/items/countdown.ogg', 75, 1, -3)
						sleep(25)
						if (part.organ_tag in list(BP_CHEST, BP_HEAD, BP_GROIN))
							part.createwound(BRUISE, 60)	//mangle them instead
							explosion(get_turf(imp_in), -1, -1, 2, 3)
							qdel(src)
						else
							explosion(get_turf(imp_in), -1, -1, 2, 3)
							part.droplimb(0,DROPLIMB_BLUNT)
							qdel(src)
				if (elevel == "Destroy Body")
					explosion(get_turf(T), -1, 0, 1, 6)
					T.gib()
				if (elevel == "Full Explosion")
					explosion(get_turf(T), 0, 1, 3, 6)
					T.gib()

			else
				explosion(get_turf(imp_in), 0, 1, 3, 6)

		if(need_gib)
			imp_in.gib()

		var/turf/t = get_turf(imp_in)

		if(t)
			t.hotspot_expose(3500,125)

	on_implanted(mob/living/source)
		elevel = alert("What sort of explosion would you prefer?", "Implant Intent", "Localized Limb", "Destroy Body", "Full Explosion")
		phrase = input("Choose activation phrase:") as text
		var/list/replacechars = list("'" = "","\"" = "",">" = "","<" = "","(" = "",")" = "")
		phrase = replace_characters(phrase, replacechars)
		usr.mind.store_memory("Explosive implant in [source] can be activated by saying something containing the phrase ''[src.phrase]'', <B>say [src.phrase]</B> to attempt to activate.", 0, 0)
		usr << "The implanted explosive implant in [source] can be activated by saying something containing the phrase ''[src.phrase]'', <B>say [src.phrase]</B> to attempt to activate."

	emp_act(severity)
		if (malfunction)
			return
		malfunction = MALFUNCTION_TEMPORARY
		switch (severity)
			if (2.0)	//Weak EMP will make implant tear limbs off.
				if (prob(50))
					small_boom()
			if (1.0)	//strong EMP will melt implant either making it go off, or disarming it
				if (prob(70))
					if (prob(50))
						small_boom()
					else
						if (prob(50))
							activate()		//50% chance of bye bye
						else
							meltdown()		//50% chance of implant disarming
		spawn (20)
			malfunction--

	islegal()
		return FALSE

	proc/small_boom()
		if (ishuman(imp_in) && part)
			imp_in.visible_message("\red Something beeps inside [imp_in][part ? "'s [part.name]" : ""]!")
			playsound(loc, 'sound/items/countdown.ogg', 75, 1, -3)
			spawn(25)
				if (ishuman(imp_in) && part)
					//No tearing off these parts since it's pretty much killing
					//and you can't replace groins
					if (part.organ_tag in list(BP_CHEST, BP_GROIN, BP_HEAD))
						part.createwound(BRUISE, 60)	//mangle them instead
					else
						part.droplimb(0,DROPLIMB_BLUNT)
				explosion(get_turf(imp_in), -1, -1, 2, 3)
				qdel(src)