/obj/item/weapon/implant/compressed
	name = "compressed matter implant"
	desc = "Based on compressed matter technology, can store a single item."
	icon_state = "implant_evil"
	var/activation_emote = "sigh"
	var/obj/item/scanned = null

	get_data()
		var/dat = {"
			<b>Implant Specifications:</b><BR>
			<b>Name:</b> NanoTrasen \"Profit Margin\" Class Employee Lifesign Sensor<BR>
			<b>Life:</b> Activates upon death.<BR>
			<b>Important Notes:</b> Alerts crew to crewmember death.<BR>
			<HR>
			<b>Implant Details:</b><BR>
			<b>Function:</b> Contains a compact radio signaler that triggers when the host's lifesigns cease.<BR>
			<b>Special Features:</b> Alerts crew to crewmember death.<BR>
			<b>Integrity:</b> Implant will occasionally be degraded by the body's immune system and thus will occasionally malfunction."}
		return dat

	trigger(emote, mob/living/source)
		if (src.scanned == null)
			return

		if (emote == src.activation_emote)
			source << "The air glows as \the [src.scanned.name] uncompresses."
			activate()

	activate()
		if (imp_in)
			imp_in.put_in_hands(scanned)
		else
			scanned.forceMove(get_turf(src))
		qdel(src)

	on_implanted(mob/living/source)
		src.activation_emote = input("Choose activation emote:") in list("blink", "blink_r", "eyebrow", "chuckle", "twitch_s", "frown", "nod", "blush", "giggle", "grin", "groan", "shrug", "smile", "pale", "sniff", "whimper", "wink")
		if (source.mind)
			source.mind.store_memory("Compressed matter implant can be activated by using the [src.activation_emote] emote, <B>say *[src.activation_emote]</B> to attempt to activate.", 0, 0)
		source << "The implanted compressed matter implant can be activated by using the [src.activation_emote] emote, <B>say *[src.activation_emote]</B> to attempt to activate."

	islegal()
		return FALSE