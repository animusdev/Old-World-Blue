/*

	Hello and welcome to sprite_accessories: For sprite accessories, such as hair,
	facial hair, and possibly tattoos and stuff somewhere along the line. This file is
	intended to be friendly for people with little to no actual coding experience.
	The process of adding in new hairstyles has been made pain-free and easy to do.
	Enjoy! - Doohl


	Notice: This all gets automatically compiled in a list in dna2.dm, so you do not
	have to define any UI values for sprite accessories manually for hair and facial
	hair. Just add in new hair types and the game will naturally adapt.

	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/

/proc/get_hair_styles_list(var/species, var/gender)
	var/list/species_list = hair_styles_by_species[species]
	if(!species_list || !species_list.len)
		return list("Bald")

	var/list/valid_hairstyles = list()
	for(var/style in species_list)
		var/datum/sprite_accessory/S = hair_styles_list[style]
		if(S.gender != NEUTER && S.gender != gender)
			continue
		valid_hairstyles += style
	return valid_hairstyles

/proc/get_facial_styles_list(var/species, var/gender)
	var/list/species_list = facial_hair_styles_by_species[species]
	if(!species_list || !species_list.len)
		return list("Shaved")

	var/list/valid_hairstyles = list()
	for(var/style in species_list)
		var/datum/sprite_accessory/S = facial_hair_styles_list[style]
		if(S.gender != NEUTER && S.gender != gender)
			continue
		valid_hairstyles += style
	return valid_hairstyles

/datum/sprite_accessory

	var/icon			// the icon file the accessory is located in
	var/icon_state		// the icon_state of the accessory
	var/preview_state	// a custom preview state for whatever reason

	var/name			// the preview name of the accessory. Try to capatilize it please~

	// Determines if the accessory will be skipped or included in random hair generations
	var/gender = NEUTER

	// Restrict some styles to specific species
	var/list/species_allowed = list("Human")

	// Whether or not the accessory can be affected by colouration
	var/do_colouration = 1


/*
////////////////////////////
/  =--------------------=  /
/  == Hair Definitions ==  /
/  =--------------------=  /
////////////////////////////
*/

/datum/sprite_accessory/hair

	icon = 'icons/mob/hair.dmi'	  // default icon for all hairs

	bald
		name = "Bald"
		icon_state = "bald"
		gender = MALE
		species_allowed = list("Human","Unathi")


	afro
		name = "Afro"
		icon_state = "afro"

	afro_large
		name = "Big Afro"
		icon_state = "bigafro"
		gender = MALE

	afro2
		name = "Afro 2"
		icon_state = "afro2"

	test
		name = "Asymmetrical Bob"
		icon_state = "asymmbob"
		gender = FEMALE

	balding
		name = "Balding Hair"
		icon_state = "balding"
		gender = MALE

	bedhead
		name = "Bedhead"
		icon_state = "bedhead"

	bedhead2
		name = "Bedhead 2"
		icon_state = "bedheadv2"

	bedhead3
		name = "Bedhead 3"
		icon_state = "bedheadv3"

	beehive
		name = "Beehive"
		icon_state = "beehive"
		gender = FEMALE

	beehive2
		name = "Beehive 2"
		icon_state = "beehive2"
		gender = FEMALE

	birdnest
		name = "Birdnest"
		icon_state = "birdnest"

	birdnest2
		name = "Birdnest 2"
		icon_state = "birdnest2"

	blackswordsman
		name = "Mercenary"
		icon_state = "blackswordsman"

	bob
		name = "Bob"
		icon_state = "bobcut"
		gender = FEMALE
		species_allowed = list("Human","Unathi")

	bobcurl
		name = "Bobcurl"
		icon_state = "bobcurl"
		gender = FEMALE
		species_allowed = list("Human","Unathi")

	bowl
		name = "Bowl"
		icon_state = "bowlcut"
		gender = MALE

	braid
		name = "Floorlength Braid"
		icon_state = "braid"
		gender = FEMALE

	braid2
		name = "Long Braid"
		icon_state = "hbraid"
		gender = FEMALE

	buisness
		name = "Buisness Hair"
		icon_state = "business"

	buisness2
		name = "Buisness Hair 2"
		icon_state = "business2"

	buisness3
		name = "Buisness Hair 3"
		icon_state = "business3"

	buisness4
		name = "Buisness Hair 4"
		icon_state = "business4"

	bun
		name = "Bun"
		icon_state = "bun"

	bun_casual
		name = "Casual Bun"
		icon_state = "bunalt"

	bun2
		name = "Bun 2"
		icon_state = "bun2"

	bun3
		name = "Bun 3"
		icon_state = "bun3"

	buzz
		name = "Buzzcut"
		icon_state = "buzzcut"
		gender = MALE
		species_allowed = list("Human","Unathi")

	chop
		name = "Chop"
		icon_state = "chop"

	cia
		name = "CIA"
		icon_state = "cia"

	combover
		name = "Combover"
		icon_state = "combover"
		gender = MALE

	crew
		name = "Crewcut"
		icon_state = "crewcut"
		gender = MALE

	crono
		name = "Chrono"
		icon_state = "toriyama"

	curls
		name = "Curls"
		icon_state = "curls"

	cut
		name = "Cut Hair"
		icon_state = "cuthair"

	dandypomp
		name = "Dandy Pompadour"
		icon_state = "dandypompadour"

	devillock
		name = "Devil Lock"
		icon_state = "devilock"
		gender = MALE

	doublebun
		name = "Double-Bun"
		icon_state = "doublebun"

	dreadlocks
		name = "Dreadlocks"
		icon_state = "dreads"

	eighties
		name = "80's"
		icon_state = "80s"

	emo
		name = "Emo"
		icon_state = "emo"

	fag
		name = "Flow Hair"
		icon_state = "flowhair"

	familyman
		name = "The Family Man"
		icon_state = "thefamilyman"
		gender = MALE

	father
		name = "Father"
		icon_state = "father"
		gender = MALE

	feather
		name = "Feather"
		icon_state = "feather"

	femcut
		name = "Cut Hair Alt"
		icon_state = "femc"

	flair
		name = "Flaired Hair"
		icon_state = "flair"

	fringeemo
		name = "Emo Fringe"
		icon_state = "emofringe"

	fringetail
		name = "Fringetail"
		icon_state = "fringetail"

	gelled
		name = "Gelled Back"
		icon_state = "gelled"

	gentle
		name = "Gentle"
		icon_state = "gentle"

	halfbang
		name = "Half-banged Hair"
		icon_state = "halfbang"

	halfbangalt
		name = "Half-banged Hair Alt"
		icon_state = "halfbang_alt"

	halfshaved
		name = "Half-Shaved Emo"
		icon_state = "halfshaved"

	hamasaki
		name = "Hamaski Hair"
		icon_state = "hamasaki"

	hbangs
		name = "Combed Hair"
		icon_state = "hbangs"

	hbangsalt
		name = "Combed Hair Alt"
		icon_state = "hbangs_alt"

	highpony
		name = "High Ponytail"
		icon_state = "highponytail"
		gender = FEMALE

	himecut
		name = "Hime Cut"
		icon_state = "himecut"

	himecutalt
		name = "Hime Cut Alt"
		icon_state = "himecut_alt"
		gender = FEMALE

	hitop
		name = "Hitop"
		icon_state = "hitop"
		gender = MALE

	jensen
		name = "Adam Jensen Hair"
		icon_state = "jensen"
		gender = MALE

	joestar
		name = "Joestar"
		icon_state = "joestar"
		gender = MALE

	kagami
		name = "Pigtails"
		icon_state = "kagami"
		gender = FEMALE

	kare
		name = "Kare"
		icon_state = "kare"

	kusangi
		name = "Kusanagi Hair"
		icon_state = "kusanagi"

	ladylike
		name = "Ladylike"
		icon_state = "ladylike"
		gender = FEMALE

	ladylike2
		name = "Ladylike alt"
		icon_state = "ladylike2"
		gender = FEMALE

	longemo
		name = "Long Emo"
		icon_state = "emolong"
		gender = FEMALE

	longer
		name = "Long Hair"
		icon_state = "vlong"

	longeralt2
		name = "Long Hair Alt"
		icon_state = "longeralt2"

	longest
		name = "Very Long Hair"
		icon_state = "longest"

	longestalt
		name = "Longer Fringe"
		icon_state = "vlongfringe"

	longfringe
		name = "Long Fringe"
		icon_state = "longfringe"

	longovereye
		name = "Overeye Long"
		icon_state = "longovereye"

	mahdrills
		name = "Drillruru"
		icon_state = "drillruru"

	mbraid
		name = "Medium Braid"
		icon_state = "shortbraid"

	mbraidalt
		name = "Medium Braid Alt"
		icon_state = "mediumbraid"
		gender = FEMALE

	messy_bun
		name = "Messy Bun"
		icon_state = "messybun"
		gender = FEMALE

	modern
		name = "Modern"
		icon_state = "modern"

	mohawk
		name = "Mohawk"
		icon_state = "mohawk"
		species_allowed = list("Human","Unathi")

	mulder
		name = "Mulder"
		icon_state = "mulder"

	nia
		name = "Nia"
		icon_state = "nia"

	nitori
		name = "Nitori"
		icon_state = "nitori"
		gender = FEMALE

	odango
		name = "Odango"
		icon_state = "odango"
		gender = FEMALE

	ombre
		name = "Ombre"
		icon_state = "ombre"

	oxton
		name = "Oxton"
		icon_state = "oxton"

	parted
		name = "Parted"
		icon_state = "parted"

	pixie
		name = "Pixie"
		icon_state = "pixie"
		gender = FEMALE

	pompadour
		name = "Pompadour"
		icon_state = "pompadour"
		gender = MALE

	ponytail1
		name = "Ponytail 1"
		icon_state = "ponytail"

	ponytail2
		name = "Ponytail 2"
		icon_state = "ponytail2"
		gender = FEMALE

	ponytail3
		name = "Ponytail 3"
		icon_state = "ponytail3"

	ponytail4
		name = "Ponytail 4"
		icon_state = "ponytail4"
		gender = FEMALE

	ponytail5
		name = "Ponytail 5"
		icon_state = "ponytail5"

	ponytail6
		name = "Ponytail 6"
		icon_state = "ponytail6"

	ponytail7
		name = "Ponytail 7"
		icon_state = "ponytail7"

	poofy
		name = "Poofy"
		icon_state = "poofy"

	poofy2
		name = "Poofy Alt"
		icon_state = "poofy2"

	quiff
		name = "Quiff"
		icon_state = "quiff"
		gender = MALE

	ramona
		name = "Ramona"
		icon_state = "ramona"

	reversemohawk
		name = "Reverse Mohawk"
		icon_state = "reversemohawk"
		gender = MALE

	rows
		name = "Rows"
		icon_state = "rows1"

	rows2
		name = "Rows Alt"
		icon_state = "rows2"

	sargeant
		name = "Flat Top"
		icon_state = "sargeant"
		gender = MALE

	scully
		name = "Scully"
		icon_state = "scully"
		gender = FEMALE

	short
		name = "Short Hair"
		icon_state = "short"

	short2
		name = "Short Hair 2"
		icon_state = "short2"

	short3
		name = "Short Hair 3"
		icon_state = "short3"

	shortbangs
		name = "Short Bangs"
		icon_state = "shortbangs"

	shortovereye
		name = "Overeye Short"
		icon_state = "shortovereye"

	shoulderlength
		name = "Shoulder-length Hair"
		icon_state = "shoulderlen"

	sidepart
		name = "Sidepart Hair"
		icon_state = "sidepart"

	sideponytail
		name = "Side Ponytail"
		icon_state = "stail"
		gender = FEMALE

	sideponytail2
		name = "One Shoulder"
		icon_state = "oneshoulder"

	sideponytail3
		name = "Tress Shoulder"
		icon_state = "tressshoulder"

	sideponytail4
		name = "Side Ponytail 2"
		icon_state = "ponytailf"

	sideswept
		name = "Side Swipe"
		icon_state = "sideswipe"

	skinhead
		name = "Skinhead"
		icon_state = "skinhead"

	smessy
		name = "Messy Hair"
		icon_state = "smessy"

	sleeze
		name = "Sleeze"
		icon_state = "sleeze"

	spiky
		name = "Spiky"
		icon_state = "spikey"
		species_allowed = list("Human","Unathi")

	stylo
		name = "Stylo"
		icon_state = "stylo"

	spikyponytail
		name = "Spiky Ponytail"
		icon_state = "spikyponytail"

	unkept
		name = "Unkept"
		icon_state = "unkept"

	updo
		name = "Updo"
		icon_state = "updo"
		gender = FEMALE

	vegeta
		name = "Vegeta"
		icon_state = "toriyama2"
		gender = MALE

	veryshortovereye
		name = "Overeye Very Short"
		icon_state = "veryshortovereye"

	veryshortovereyealternate
		name = "Overeye Very Short, Alternate"
		icon_state = "veryshortovereyealternate"

	volaju
		name = "Volaju"
		icon_state = "volaju"

	wisp
		name = "Wisp"
		icon_state = "wisp"
		gender = FEMALE

	zieglertail
		name = "Zieglertail"
		icon_state = "ziegler"

	zone
		name = "Zone Braid"
		icon_state = "zone"
		gender = FEMALE


	ipc
		species_allowed = list("Machine")
		icon = 'icons/mob/hair_alien.dmi'

		icp_pc_console
			name = "console IPC screen"
			icon_state = "ipc_console"

		icp_screen_blue
			name = "blue IPC screen"
			icon_state = "ipc_blue"

		icp_screen_breakout
			name = "breakout IPC screen"
			icon_state = "ipc_breakout"

		icp_screen_eight
			name = "eight IPC screen"
			icon_state = "ipc_eight"

		icp_screen_go_glider
			name = "glider IPC screen"
			icon_state = "ipc_gol_glider"

		icp_screen_goggles
			name = "goggles IPC screen"
			icon_state = "ipc_goggles"

		icp_screen_green
			name = "green IPC screen"
			icon_state = "ipc_green"

		icp_screen_heart
			name = "heart IPC screen"
			icon_state = "ipc_heart"

		icp_screen_kitty
			name = "kitty IPC screen"
			icon_state = "ipc_kitty"

		icp_screen_monoeye
			name = "monoeye IPC screen"
			icon_state = "ipc_monoeye"

		icp_screen_nature
			name = "nature IPC screen"
			icon_state = "ipc_nature"

		icp_screen_orange
			name = "orange IPC screen"
			icon_state = "ipc_orange"

		icp_screen_pink
			name = "pink IPC screen"
			icon_state = "ipc_pink"

		icp_screen_purple
			name = "purple IPC screen"
			icon_state = "ipc_purple"

		icp_screen_rainbow
			name = "rainbow IPC screen"
			icon_state = "ipc_rainbow"

		icp_screen_red
			name = "red IPC screen"
			icon_state = "ipc_red"

		icp_screen_rgb
			name = "RGB IPC screen"
			icon_state = "ipc_rgb"

		icp_screen_shower
			name = "shower IPC screen"
			icon_state = "ipc_shower"

		icp_screen_static
			name = "static IPC screen"
			icon_state = "ipc_static"

		icp_screen_yellow
			name = "yellow IPC screen"
			icon_state = "ipc_yellow"

		icp_scroll
			name = "scroll IPC screen"
			icon_state = "ipc_scroll"


/*
///////////////////////////////////
/  =---------------------------=  /
/  == Facial Hair Definitions ==  /
/  =---------------------------=  /
///////////////////////////////////
*/

/datum/sprite_accessory/facial_hair

	icon = 'icons/mob/hair_facial.dmi'
	gender = MALE // barf (unless you're a dorf, dorfs dig chix /w beards :P)

	shaved
		name = "Shaved"
		icon_state = "shaved"
		gender = NEUTER
		species_allowed = list("Human","Unathi","Tajara","Skrell","Vox","Machine")

		New()
			..()
			species_allowed = list()
			for(var/S in all_species)
				species_allowed += S

	abe
		name = "Abraham Lincoln Beard"
		icon_state = "abe"

	chaplin
		name = "Square Mustache"
		icon_state = "chaplin"

	chinstrap
		name = "Chinstrap"
		icon_state = "chin"

	dwarf
		name = "Dwarf Beard"
		icon_state = "dwarf"

	elvis
		name = "Elvis Sideburns"
		icon_state = "elvis"
		species_allowed = list("Human","Unathi")

	fiveoclock
		name = "Five o Clock Shadow"
		icon_state = "fiveoclock"

	fullbeard
		name = "Full Beard"
		icon_state = "fullbeard"

	gt
		name = "Goatee"
		icon_state = "gt"

	hip
		name = "Hipster Beard"
		icon_state = "hip"

	hogan
		name = "Hulk Hogan Mustache"
		icon_state = "hogan" //-Neek

	jensen
		name = "Adam Jensen Beard"
		icon_state = "jensen"

	longbeard
		name = "Long Beard"
		icon_state = "longbeard"

	neckbeard
		name = "Neckbeard"
		icon_state = "neckbeard"

	selleck
		name = "Selleck Mustache"
		icon_state = "selleck"

	vandyke
		name = "Van Dyke Mustache"
		icon_state = "vandyke"

	vlongbeard
		name = "Very Long Beard"
		icon_state = "wise"

	volaju
		name = "Volaju"
		icon_state = "volaju"

	watson
		name = "Watson Mustache"
		icon_state = "watson"


/*
///////////////////////////////////
/  =---------------------------=  /
/  == Alien Style Definitions ==  /
/  =---------------------------=  /
///////////////////////////////////
*/

/datum/sprite_accessory/hair
	skrell
		icon = 'icons/mob/hair_alien.dmi'
		species_allowed = list("Skrell")

		tentacle_f
			name = "Skrell Female Tentacles"
			icon_state = "skrell_female"
			gender = FEMALE

		tentacle_f_alt
			name = "Skrell Female Tentacles Alt"
			icon_state = "skrell_female_alt"
			gender = FEMALE

		tentacle_f_old
			name = "Skrell Female Tentacles (old)"
			icon_state = "skrell_female_old"
			gender = FEMALE

		tentacle_f_wide
			name = "Skrell Female Tentacles Wide"
			icon_state = "skrell_female_wide"
			gender = FEMALE

		tentacle_m
			name = "Skrell Male Tentacles"
			icon_state = "skrell_male"
			gender = MALE

	tajara
		icon = 'icons/mob/hair_alien.dmi'
		species_allowed = list("Tajara")
		ears
			name = "Tajaran Ears"
			icon_state = "ears_plain"

		bangs
			name = "Tajara Bangs"
			icon_state = "bangs"

		bob
			name = "Tajara Bob"
			icon_state = "tbob"

		braid
			name = "Tajara Braid"
			icon_state = "tbraid"

		chalma
			name = "Tajara Chalma"
			icon_state = "chalma"

		clean
			name = "Tajara Clean"
			icon_state = "clean"

		curly
			name = "Tajaran Curly"
			icon_state = "curly"

		fingercurl
			name = "Tajara Finger Curls"
			icon_state = "fingerwave"

		long
			name = "Tajara Long"
			icon_state = "long"

		messy
			name = "Tajara Messy"
			icon_state = "messy"

		mohawk
			name = "Tajaran Mohawk"
			icon_state = "mohawk"

		plait
			name = "Tajara Plait"
			icon_state = "plait"

		rattail
			name = "Tajara Rat Tail"
			icon_state = "rattail"

		shaggy
			name = "Tajara Shaggy"
			icon_state = "shaggy"

		spiky
			name = "Tajara Spiky"
			icon_state = "tajspiky"

		straight
			name = "Tajara Straight"
			icon_state = "straight"

		victory
			name = "Tajara Victory Curls"
			icon_state = "victory"
			gender = FEMALE

		wife
			name = "Tajara Housewife"
			icon_state = "wife"
			gender = FEMALE

		shorttail
			name = "Tajara Short Tail"
			icon_state = "shorttail"
			gender = FEMALE

	unathi
		icon = 'icons/mob/hair_alien.dmi'
		species_allowed = list("Unathi")

		frills_long
			name = "Long Unathi Frills"
			icon_state = "longfrills"

		frills_short
			name = "Short Unathi Frills"
			icon_state = "shortfrills"

		horns
			name = "Unathi Horns"
			icon_state = "horns"

		horns_ram
			name = "Unathi Ram Horns"
			icon_state = "ramhorns"

		horns_curled
			name = "Unathi Curled Horns"
			icon_state = "curledhorns"

		spines_long
			name = "Long Unathi Spines"
			icon_state = "longspines"

		spines_short
			name = "Short Unathi Spines"
			icon_state = "shortspines"

	vox_quills_short
		name = "Short Vox Quills"
		icon = 'icons/mob/hair_alien.dmi'
		icon_state = "vox_shortquills"
		species_allowed = list("Vox")



/datum/sprite_accessory/facial_hair
	tajara
		icon = 'icons/mob/hair_alien.dmi'
		species_allowed = list("Tajara")

		goatee
			name = "Tajara Goatee"
			icon_state = "goatee"

		moustache
			name = "Tajara Moustache"
			icon_state = "moustache"

		mutton
			name = "Tajara Mutton"
			icon_state = "mutton"

		pencilstache
			name = "Tajara Pencilstache"
			icon_state = "pencilstache"

		sideburns
			name = "Tajara Sideburns"
			icon_state = "sideburns"

		smallstache
			name = "Tajara Smallsatche"
			icon_state = "smallstache"
