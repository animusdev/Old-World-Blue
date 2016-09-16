// Noise "language", for audible emotes.
/datum/language/noise
	name = "Noise"
	desc = "Noises"
	key = ""
	flags = NONGLOBAL|INNATE|NO_TALK_MSG|NO_STUTTER

/datum/language/noise/format_message(message, verb)
	return "<span class='message'><span class='[colour]'>[message]</span></span>"

/datum/language/noise/format_message_plain(message, verb)
	return message

/datum/language/noise/format_message_radio(message, verb)
	return "<span class='[colour]'>[message]</span>"

/datum/language/noise/get_talkinto_msg_range(message)
	// if you make a loud noise (screams etc), you'll be heard from 4 tiles over instead of two
	return (copytext(message, length(message)) == "!") ? 4 : 2

// 'basic' language; spoken by default.
/datum/language/common
	name = "Galactic Common"
	desc = "The common galactic tongue."
	speech_verb = "says"
	whisper_verb = "whispers"
	key = "0"
	flags = COMMON_VERBS
	syllables = list("blah","blah","blah","bleh","meh","neh","nah","wah")

//TODO flag certain languages to use the mob-type specific say_quote and then get rid of these.
/datum/language/common/get_spoken_verb(var/msg_end)
	switch(msg_end)
		if("!")
			return pick("exclaims","shouts","yells") //TODO: make the basic proc handle lists of verbs.
		if("?")
			return ask_verb
	return speech_verb

// Galactic common languages (systemwide accepted standards).
/datum/language/trader
	name = "Tradeband"
	desc = "Maintained by the various trading cartels in major systems, this elegant, structured language is used for bartering and bargaining."
	speech_verb = "enunciates"
	colour = "say_quote"
	key = "2"
	flags = PUBLIC
	space_chance = 100
	syllables = list("lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
					 "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore",
					 "magna", "aliqua", "ut", "enim", "ad", "minim", "veniam", "quis", "nostrud",
					 "exercitation", "ullamco", "laboris", "nisi", "ut", "aliquip", "ex", "ea", "commodo",
					 "consequat", "duis", "aute", "irure", "dolor", "in", "reprehenderit", "in",
					 "voluptate", "velit", "esse", "cillum", "dolore", "eu", "fugiat", "nulla",
					 "pariatur", "excepteur", "sint", "occaecat", "cupidatat", "non", "proident", "sunt",
					 "in", "culpa", "qui", "officia", "deserunt", "mollit", "anim", "id", "est", "laborum")

/datum/language/m_tajaran
	name = "Siik'maas"
	desc = "The traditionally employed tongue that is in common use in Ahdomai, it tends to be spoken as a common language in the same way English is."
	speech_verb = "mrowls"
	ask_verb = "mrowls"
	exclaim_verb = "yowls"
	colour = "tajaran_mas"
	key = "z"
	flags = PUBLIC
	syllables = list("mrr","rr","tajr","kir","raj","kii","mir","kra","ahk","nal","vah","khaz","jri","ran","darr",
				 	 "mi","jri","dynh","manq","rhe","zar","rrhaz","kal","chur","eech","thaa","dra","jurl","mah","sanu","dra","ii'r",
					 "ka","aasi","far","wa","baq","ara","qara","zir","sam","mak","hrar","nja","rir","khan","jun","dar","rik","kah",
					 "hal","ket","jurl","mah","tul","cresh","azu","ragh","mro","mra","mrro","mrra")

//Russian Language
/datum/language/slav
	name = "Surzhyk"
	desc = "A very old slavanian language. Refers to a range of mixed sociolects of Ukrainian and Russian languages used in certain colonies"
	speech_verb = "says"
	colour = "slav"
	key = "r"
	flags = PUBLIC
	space_chance = 100
	syllables = list("pjat", "strimjatsa", "virast", "mjezdu", "tjolstoj", "blyat",
					 "suka", "sol", "vodka", "eb", "hui",
					 "samoj", "vadit", "mat", "prareb", "budet", "ty", "igrje", "pindosi", "salo", "gorilka", "da", "nyet",
					 "horosho", "pjos", "vsjo", "je", "stobi", "reptiloidi", "amerikosi", "pidor", "skalen", "sut", "takov",
					 "eki", "pravo", "moskal", "krop", "zmii", "bliny", "ushanka", "beru", "idi", "na", "v", "poshel", "na", "edin",
					 "sel", "vosem", "ruki", "memi", "chto", "on", "it", "iv", "ov",
					 "vsjo", "sot", "holodno", "moja", "li", "mertvi",
					 "hotet", "vidat", "vosjem", "ya", "uzje", "stancia", "vi")

// Criminal language.
/datum/language/gutter
	name = "Gutter"
	desc = "Much like Standard, this crude pidgin tongue descended from numerous languages and serves as Tradeband for criminal elements."
	speech_verb = "growls"
	colour = "rough"
	key = "3"
	flags = PUBLIC
	syllables = list ("gra","ba","ba","breh","bra","rah","dur","ra","ro","gro","go","ber","bar","geh","heh", "gra")

/*
// Soldier language
/datum/language/kellai
	name = "Kellai"
	desc = "Maintained by the various trading cartels in major systems, this elegant, structured language is used for bartering and bargaining."
	speech_verb = "rapped"
	colour = "say_quote"
	key = "4"
	flags = PUBLIC
	syllables = list("lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
					 "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore",
					 "magna", "aliqua", "ut", "enim", "ad", "minim", "veniam", "quis", "nostrud",
					 "exercitation", "ullamco", "laboris", "nisi", "ut", "aliquip", "ex", "ea", "commodo",
					 "consequat", "duis", "aute", "irure", "dolor", "in", "reprehenderit", "in",
					 "voluptate", "velit", "esse", "cillum", "dolore", "eu", "fugiat", "nulla",
					 "pariatur", "excepteur", "sint", "occaecat", "cupidatat", "non", "proident", "sunt",
					 "in", "culpa", "qui", "officia", "deserunt", "mollit", "anim", "id", "est", "laborum")
*/