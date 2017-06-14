/obj/item/weapon/implantcase/adrenalin
	name = "glass case - 'adrenalin'"
	desc = "A case containing an adrenalin implant."
	imp = /obj/item/weapon/implant/adrenalin

/obj/item/weapon/implant/adrenalin
	name = "adrenalin"
	desc = "Removes all stuns and knockdowns."
	var/uses

	get_data()
		var/dat = {"
			<b>Implant Specifications:</b><BR>
			<b>Name:</b> Cybersun Industries Adrenalin Implant<BR>
			<b>Life:</b> Five days.<BR>
			<b>Important Notes:</b> <font color='red'>Illegal</font><BR>
			<HR>
			<b>Implant Details:</b>.<BR>
			<b>Function:</b> Contains nanobots to stimulate body to mass-produce Adrenalin.<BR>
			<b>Special Features:</b> Subjects injected with implant can activate a massive injection of adrenalin<BR>
			<b>Integrity:</b> Implant can only be used three times before the nanobots are depleted."}
		return dat


	trigger(emote, mob/living/source)
		if (src.uses < 1)
			return
		if (emote == "pale")
			src.uses--
			source << SPAN_NOTE("You feel a sudden surge of energy!")
			source.SetStunned(0)
			source.SetWeakened(0)
			source.SetParalysis(0)

	on_implanted(mob/living/source)
		source.mind.store_memory("A implant can be activated by using the pale emote, <B>say *pale</B> to attempt to activate.", 0, 0)
		source << "The implanted freedom implant can be activated by using the pale emote, <B>say *pale</B> to attempt to activate."