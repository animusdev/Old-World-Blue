#define EMOTE_VISIBLE  1
#define EMOTE_HEARABLE 2

// Emotes
var/global/list/emotes_list = list()

/hook/startup/proc/populate_emotes()
	var/paths = typesof(/datum/emote)
	. = length(paths)
	for(var/T in paths)
		var/datum/emote/E = new T
		if(!E.key)
			del(E)
			continue
		emotes_list[E.key] = E


/datum/emote
	var/key = ""
	var/message = ""
	var/r_message =  ""
	var/m_type = EMOTE_VISIBLE

/datum/emote/proc/act(var/mob/living/carbon/human/H)
	var/russified = H.client && (H.client.prefs.toggles & RUS_AUTOEMOTES)
	if(russified)
		return H.custom_emote(m_type, r_message)
	else
		return H.custom_emote(m_type, message)

/datum/emote/select
	var/target_message = ""
	var/r_target_message = ""
	var/range = null

	proc/get_target(var/mob/living/carbon/human/H)
		var/list/targets = list()
		for(var/mob/living/L in view(H, range ? range : world.view))
			targets += L
		return input(H) as null|mob in targets

	act(var/mob/living/carbon/human/H)
		var/russified = H.client && (H.client.prefs.toggles & RUS_AUTOEMOTES)
		var/mob/living/carbon/human/target = get_target(H)
		if(!target || target==H)
			if(message)
				return ..()
			else
				return null
		else if(target in view(H, range ? range : world.view))
			if(russified)
				return H.custom_emote(m_type, replacetext(r_target_message,"@target", target))
			else
				return H.custom_emote(m_type, replacetext(target_message,"@target", target))

/datum/emote/select/local
	range = 1

/*
/datum/emote/select/ask
	range = 1
	var/ask_msg = ""

	act(var/mob/living/carbon/human/H)
		var/russified = H.client && (H.client.prefs.toggles & RUS_AUTOEMOTES)
		var/mob/living/carbon/human/target = get_target(H)
		if(!target || target==H)
			if(message)
				return ..()
			else
				return null
		else
			if(russified)
				return H.custom_emote(m_type, replacetext(r_target_message,"@target", target))
			else
				return H.custom_emote(m_type, replacetext(target_message,"@target", target))
*/

////EMOTES////

/datum/emote/airguitar
	key = "airguitar"
	message = "is strumming the air and headbanging like a safari chimp."
	r_message = "играет на воображаемой гитаре и тр&#255;сЄт головой в такт."
	act(var/mob/living/carbon/human/H)
		if(!H.restrained())
			return ..()
		return null

/datum/emote/blink
	key = "blink"
	message = "blinks."
	r_message = "моргает."

/datum/emote/blink_r
	key = "blink_r"
	message = "blinks rapidly."
	r_message = "часто моргает."

/datum/emote/blush
	key = "blush"
	message = "blushes."
	r_message = "краснеет."

/datum/emote/choke
	key = "choke"
	message = "chokes!"
	r_message = "задыхаетс&#255;!"
	m_type = EMOTE_HEARABLE

/datum/emote/chuckle
	key = "chuckle"
	message = "chuckles."
	r_message = "посмеиваетс&#255;."
	m_type = EMOTE_HEARABLE

/datum/emote/clap
	key = "clap"
	message = "claps."
	r_message = "хлопает в ладоши."
	m_type = EMOTE_HEARABLE
	act(var/mob/living/carbon/human/H)
		if (!H.restrained())
			return ..()

/datum/emote/clear
	key = "clear"
	message = "clears /his throat"
	r_message = "прочищает свое горло."
	m_type = EMOTE_HEARABLE

/datum/emote/collapse
	key = "collapse"
	message = "collapses!"
	r_message = "падает!"
	m_type = EMOTE_HEARABLE
	act(var/mob/living/carbon/human/H)
		H.Paralyse(2)
		return ..()

/datum/emote/cough
	key = "cough"
	message = "coughs!"
	r_message = "кашл&#255;ет!"
	m_type = EMOTE_HEARABLE

/datum/emote/cry
	key = "cry"
	message = "cries."
	r_message = "плачет."
	m_type = EMOTE_HEARABLE

/datum/emote/deathgasp
	key = "deathgasp"
	m_type = EMOTE_HEARABLE
	act(var/mob/living/carbon/human/H)
		return H.custom_emote(EMOTE_VISIBLE, H.species.death_message)

/datum/emote/drool
	key = "drool"
	message = "drools."
	r_message = "пускает слюни."

/datum/emote/eyebrow
	key = "eyebrow"
	message = "raises an eyebrow."
	r_message = "вопросительно поднимает бровь."

/datum/emote/faint
	key = "faint"
	message = "faints."
	r_message = "падает в обморок."
	act(var/mob/living/carbon/human/H)
		if(!H.sleeping)
			. = ..()
			H.sleeping += 10 //Short-short nap

/datum/emote/flap
	key= "flap"
	message = "flaps wings."
	r_message = "хлопает крыль&#255;ми."
	m_type = EMOTE_HEARABLE
	act(var/mob/living/carbon/human/H)
		if (!H.restrained())
			return ..()

/datum/emote/flap_a
	key = "flap_a"
	message = "flaps wings ANGRILY!"
	r_message = "”√–ќ∆јёў≈ хлопает крыль&#255;ми!"
	m_type = EMOTE_HEARABLE
	act(var/mob/living/carbon/human/H)
		if (!H.restrained())
			return ..()

/datum/emote/frown
	key = "frown"
	message = "frowns."
	r_message = "хмуритс&#255;."

/datum/emote/gasp
	key = "gasp"
	message = "gasps!"
	r_message = "пытаетс&#255; вдохнуть!"
	m_type = EMOTE_HEARABLE

/datum/emote/giggle
	key = "giggle"
	message = "giggles."
	r_message = "хихикает."
	m_type = EMOTE_HEARABLE

/datum/emote/grin
	key = "grin"
	message = "grins."
	r_message = "ухмыл&#255;етс&#255;."

/datum/emote/groan
	key = "groan"
	message = "groans!"
	r_message = "отчаено стонет!"
	m_type = EMOTE_HEARABLE

/datum/emote/grumble
	key = "grumble"
	message = "grumbles!"
	r_message = "ворчит!"
	m_type = EMOTE_HEARABLE

/datum/emote/hem
	key = "hem"
	message = "hems"
	r_message = "хмыкает."
	m_type = EMOTE_HEARABLE

/datum/emote/hum
	key = "hum"
	message = "hums."
	r_message = "напевает себе под нос."
	m_type = EMOTE_HEARABLE

/datum/emote/laugh
	key = "laugh"
	message = "laughs."
	r_message = "смеЄтс&#255;."
	m_type = EMOTE_HEARABLE

/datum/emote/moan
	key = "moan"
	message = "moans!"
	r_message = "стонет!"
	m_type = EMOTE_HEARABLE

/datum/emote/mumble
	key = "mumble"
	message = "mumbles!"
	r_message = "бормочет что-то невн&#255;тное."
	m_type = EMOTE_HEARABLE

/datum/emote/nod
	key = "nod"
	message = "nods."
	r_message = "кивает."

/datum/emote/pale
	key = "pale"
	message = "goes pale for a second."
	r_message = "бледнеет."

/datum/emote/raise
	key = "raise"
	message = "raises a hand."
	r_message = "поднимает руку вверх."
	act(var/mob/living/carbon/human/H)
		if (!H.restrained())
			return ..()

/datum/emote/scream
	key = "scream"
	message = "screams!"
	r_message = "кричит!"
	m_type = EMOTE_HEARABLE

/datum/emote/shake
	key = "shake"
	message = "shakes head."
	r_message = "покачивает головой."

/datum/emote/shiver
	key = "shiver"
	message = "shivers."
	r_message = "дрожит."

/datum/emote/shrug
	key = "shrug"
	message = "shrugs."
	r_message = "пожимает плечами."

/datum/emote/sigh
	key = "sigh"
	message = "sighs."
	r_message = "вздыхает."
	m_type = EMOTE_HEARABLE

/datum/emote/smile
	key = "smile"
	message = "smiles."
	r_message = "улыбаетс&#255;."

/datum/emote/sneeze
	key = "sneeze"
	message = "sneezes."
	r_message = "чихает."
	m_type = EMOTE_HEARABLE

/datum/emote/sniff
	key = "sniff"
	message = "sniffs."
	r_message = "шмыгает носом."
	m_type = EMOTE_HEARABLE

/datum/emote/snore
	key = "snore"
	message = "snores."
	r_message = "сопит."
	m_type = EMOTE_HEARABLE

/datum/emote/tremble
	key = "tremble"
	message = "trembles in fear!"
	r_message = "дрожит от ужаса!"

/datum/emote/twitch
	key = "twitch"
	message = "twitches violently."
	r_message = "резко дергаетс&#255;."

/datum/emote/twitch_s
	key = "twitch_s"
	message = "twitches."
	r_message = "дергаетс&#255;."

/datum/emote/wave
	key = "wave"
	message = "waves."
	r_message = "машет рукой."

/datum/emote/whimper
	key = "whimper"
	message = "whimpers."
	r_message = "всхлипывает."
	m_type = EMOTE_HEARABLE

/datum/emote/whistle
	key = "whistle"
	message = "whistles!"
	r_message = "свистит!"
	m_type = EMOTE_HEARABLE

/datum/emote/wink
	key = "wink"
	message = "winks."
	r_message = "подмигивает."

/datum/emote/yawn
	key = "yawn"
	message = "yawns."
	r_message = "зевает."
	m_type = EMOTE_HEARABLE
	act(var/mob/living/carbon/human/H)
		if (!istype(H.wear_mask, /obj/item/clothing/mask/muzzle))
			return ..()

////SELECT////

/datum/emote/select/airkiss
	key = "airkiss"
	message = "blowing a kiss."
	r_message = "отправл&#255;ет воздушный поцелуй."
	target_message = "blowing a kiss to @target."
	r_target_message = "отправл&#255;ет воздушный поцелуй @target."
	act(var/mob/living/carbon/human/H)
		if(!H.handcuffed)
			return ..()

/datum/emote/select/bow
	key = "bow"
	message = "bows."
	r_message = "клан&#255;етс&#255;."
	target_message = "bows to @target."
	r_target_message = "клан&#255;етс&#255; @target."
	act(var/mob/living/carbon/human/H)
		if(!H.buckled)
			return ..()

/datum/emote/select/glare
	key = "glare"
	message = "glares."
	r_message = "злобно смотрит."
	target_message = "glares at @target."
	r_target_message = "смотрит на @target со злобой."

/datum/emote/select/look
	key = "look"
	message = "looks."
	r_message = "осматриваетс&#255;."
	target_message = "looks at @target."
	r_target_message = "смотрит на†@target."

/datum/emote/select/salute
	key = "salute"
	message = "salutes."
	r_message = "отдает честь."
	target_message = "salutes to @target."
	r_target_message = "отдает честь @target."
	act(var/mob/living/carbon/human/H)
		if(!H.handcuffed)
			return ..()

/datum/emote/select/stare
	key = "stare"
	message = "stares."
	r_message = "внимательно смотрит на происход&#255;щее."
	target_message = "stares at @target."
	r_target_message = "п&#255;литс&#255; на @target."

////SELECT LOCAL////

/datum/emote/select/local/cuddle
	key = "cuddle"
	target_message = "cuddles @target."
	r_target_message = "прижимаетс&#255; к @target."
	act(var/mob/living/carbon/human/H)
		if(!H.restrained())
			..()

/datum/emote/select/local/dap
	key = "dap"
	message = "sadly can't find anybody to give daps to, and daps himself. Shameful."
	r_message = "не найд&#255; никого р&#255;дом с собой, делает  брофист сам с собой.  ∆алкое зрелище."
	target_message = "gives daps to @target."
	r_target_message = "делает брофист с @target."
	act(var/mob/living/carbon/human/H)
		if(!H.restrained())
			..()

/datum/emote/select/local/handshake
	key = "handshake"
	target_message = "shakes hands with @target."
	r_target_message = "жмет руки с @target."

/datum/emote/select/local/highfive
	key = "five"
	message = "can't find anybody to give high five to."
	r_message = "не находит никого, кому можно было бы дать п&#255;ть."
	target_message = "gives hihg five to @target."
	r_target_message = "дает п&#255;ть @target"

/datum/emote/select/local/hug
	key = "hug"
	message = "hugs itself."
	r_message = "обнимает себ&#255;."
	target_message = "hugs @target."
	r_target_message = "обнимает @target."

/datum/emote/select/local/kiss
	key = "kiss"
	target_message = "kisses @target."
	r_target_message = "целует @target."

/datum/emote/select/local/snuggle
	key = "snuggle"
	target_message = "snuggles @target."
	r_target_message = "прижимает @target к себе."

////Special////

/datum/emote/signal
	key = "signal"
	m_type = EMOTE_VISIBLE

	act(var/mob/living/carbon/human/H)
		var/russified = H.client && (H.client.prefs.toggles & RUS_AUTOEMOTES)
		var/t1 = input("How many fingers will you raise?", "Ammount", 2) as num
		if (isnum(t1))
			if (t1 <= 0) return
			switch(t1)
				if (1 to 5)
					if((H.r_hand || !H.get_organ("r_hand")) && (H.l_hand  || !H.get_organ("l_hand")))
						H << "<span class='warning'>Your need at least one free hand for this</span>"
						return
					if(!russified)
						return H.custom_emote(m_type, "raises [t1] finger\s.")
					else
						var/emote = "поднимает [t1] пальцев"
						switch(t1)
							if(1)   emote = "поднимает [t1] палец."
							if(2 to 4) emote = "поднимает [t1] палеца."
							if(5)   emote = "поднимает [t1] пальцев."
						return H.custom_emote(m_type, emote)
				if (6 to 10)
					if((H.r_hand || !H.get_organ("r_hand")) || (H.l_hand  || !H.get_organ("l_hand")))
						H << "<span class='warning'>Your need at least two free hands for this</span>"
						return
					if(russified)
						return H.custom_emote(m_type, "поднимает [t1] пальцев.")
					else
						return H.custom_emote(m_type, "raises [t1] fingers.")

#undef EMOTE_VISIBLE
#undef EMOTE_HEARABLE
