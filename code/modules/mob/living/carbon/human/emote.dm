/mob/living/carbon/human/emote(var/act,var/m_type=1,var/message = null)

	for (var/obj/item/weapon/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)

	..()

/mob/living/carbon/human/get_possible_emotes()
	var/list/tmp_emotes = human_emotes_list.Copy()
	if(species.emotes)
		for(var/emote in species.emotes)
			tmp_emotes[emote] = species.emotes[emote]
	if(isSynthetic())
		for(var/emote in robot_emotes_list)
			tmp_emotes[emote] = robot_emotes_list[emote]
	return tmp_emotes

/mob/living/carbon/human/verb/pose()
	set name = "Set Pose"
	set desc = "Sets a description which will be shown when someone examines you."
	set category = "IC"

	pose =  sanitize(input(usr, "This is [src]. \He is...", "Pose", null)  as text)

/mob/living/carbon/human/verb/set_flavor()
	set name = "Set Flavour Text"
	set desc = "Sets an extended description of your character's features."
	set category = "IC"

	var/HTML = "<body>"
	HTML += "<tt><center>"
	HTML += "<b>Update Flavour Text</b> <hr />"
	HTML += "<br></center>"
	for( var/flavor in flavs_list )
		HTML += "<a href='?src=\ref[src];flavor_change=[flavor]'>[flavs_list[flavor]]</a>: \
		[TextPreview(flavor_texts[flavor])]<br>"
	HTML += "<br>"
	HTML += "<hr />"
	HTML +="<a href='?src=\ref[src];flavor_change=done'>\[Done\]</a>"
	HTML += "<tt>"
	src << browse(HTML, "window=flavor_changes;size=430x300")
