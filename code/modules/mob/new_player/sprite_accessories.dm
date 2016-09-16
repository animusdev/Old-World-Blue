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

	icon = 'icons/mob/Human_face.dmi'	  // default icon for all hairs

	afro
		name = "Afro"
		icon_state = "hair_afro"

	afro_large
		name = "Big Afro"
		icon_state = "hair_bigafro"
		gender = MALE

	afro2
		name = "Afro 2"
		icon_state = "hair_afro2"

	bald
		name = "Bald"
		icon_state = "bald"
		gender = MALE
		species_allowed = list("Human","Unathi")

	balding
		name = "Balding Hair"
		icon_state = "hair_e"
		gender = MALE // turnoff!

	bedhead
		name = "Bedhead"
		icon_state = "hair_bedhead"

	bedhead2
		name = "Bedhead 2"
		icon_state = "hair_bedheadv2"

	bedhead3
		name = "Bedhead 3"
		icon_state = "hair_bedheadv3"

	beehive
		name = "Beehive"
		icon_state = "hair_beehive"
		gender = FEMALE

	beehive2
		name = "Beehive 2"
		icon_state = "hair_beehive2"
		gender = FEMALE

	blackswordsman
		name = "Mercenary"
		icon_state = "hair_blackswordsman"

	bob
		name = "Bob"
		icon_state = "hair_bobcut"
		gender = FEMALE
		species_allowed = list("Human","Unathi")

	bobcurl
		name = "Bobcurl"
		icon_state = "hair_bobcurl"
		gender = FEMALE
		species_allowed = list("Human","Unathi")

	bowl
		name = "Bowl"
		icon_state = "hair_bowlcut"
		gender = MALE

	braid
		name = "Floorlength Braid"
		icon_state = "hair_braid"
		gender = FEMALE

	braid2
		name = "Long Braid"
		icon_state = "hair_hbraid"
		gender = FEMALE

	bun
		name = "Bun"
		icon_state = "hair_bun"

	bunalt
		name = "Bun Alt"
		icon_state = "hair_bunalt"
		gender = FEMALE

	buzz
		name = "Buzzcut"
		icon_state = "hair_buzzcut"
		gender = MALE
		species_allowed = list("Human","Unathi")

	chop
		name = "Chop"
		icon_state = "hair_chop"

	cia
		name = "CIA"
		icon_state = "hair_cia"

	combover
		name = "Combover"
		icon_state = "hair_combover"
		gender = MALE

	crew
		name = "Crewcut"
		icon_state = "hair_crewcut"
		gender = MALE

	crono
		name = "Chrono"
		icon_state = "hair_toriyama"
		gender = MALE

	curls
		name = "Curls"
		icon_state = "hair_curls"

	cut
		name = "Cut Hair"
		icon_state = "hair_c"

	dandypomp
		name = "Dandy Pompadour"
		icon_state = "hair_dandypompadour"
		gender = MALE

	devillock
		name = "Devil Lock"
		icon_state = "hair_devilock"

	doublebun
		name = "Double-Bun"
		icon_state = "hair_doublebun"

	dreadlocks
		name = "Dreadlocks"
		icon_state = "hair_dreads"

	emo
		name = "Emo"
		icon_state = "hair_emo"

	fag
		name = "Flow Hair"
		icon_state = "hair_f"

	familyman
		name = "The Family Man"
		icon_state = "hair_thefamilyman"
		gender = MALE

	father
		name = "Father"
		icon_state = "hair_father"
		gender = MALE

	feather
		name = "Feather"
		icon_state = "hair_feather"

	femcut
		name = "Cut Hair Alt"
		icon_state = "hair_femc"

	flair
		name = "Flaired Hair"
		icon_state = "hair_flair"

	gelled
		name = "Gelled Back"
		icon_state = "hair_gelled"
		gender = FEMALE

	gentle
		name = "Gentle"
		icon_state = "hair_gentle"
		gender = FEMALE

	halfbang
		name = "Half-banged Hair"
		icon_state = "hair_halfbang"

	halfbangalt
		name = "Half-banged Hair Alt"
		icon_state = "hair_halfbang_alt"

	halfshaved
		name = "Half-Shaved Emo"
		icon_state = "hair_halfshaved"

	hamasaki
		name = "Hamaski Hair"
		icon_state = "hair_hamasaki"
		gender = FEMALE

	hbangs
		name = "Combed Hair"
		icon_state = "hair_hbangs"

	hbangsalt
		name = "Combed Hair Alt"
		icon_state = "hair_hbangs_alt"

	highpony
		name = "High Ponytail"
		icon_state = "hair_highponytail"
		gender = FEMALE

	himecut
		name = "Hime Cut"
		icon_state = "hair_himecut"
		gender = FEMALE

	himecutalt
		name = "Hime Cut Alt"
		icon_state = "hair_himecut_alt"
		gender = FEMALE

	hitop
		name = "Hitop"
		icon_state = "hair_hitop"
		gender = MALE

	jensen
		name = "Adam Jensen Hair"
		icon_state = "hair_jensen"
		gender = MALE

	joestar
		name = "Joestar"
		icon_state = "hair_joestar"
		gender = MALE

	kagami
		name = "Pigtails"
		icon_state = "hair_kagami"
		gender = FEMALE

	kusangi
		name = "Kusanagi Hair"
		icon_state = "hair_kusanagi"

	kusangialt
		name = "Kusanagi Hair Alt"
		icon_state = "hair_kusanagialt"

	ladylike
		name = "Ladylike"
		icon_state = "hair_ladylike"
		gender = FEMALE

	ladylike2
		name = "Ladylike alt"
		icon_state = "hair_levb"
		gender = FEMALE

	long
		name = "Shoulder-length Hair"
		icon_state = "hair_b"

	longalt
		name = "Shoulder-length Hair Alt"
		icon_state = "hair_longfringe"

	longemo
		name = "Long Emo"
		icon_state = "hair_emolong"
		gender = FEMALE

	longer
		name = "Long Hair"
		icon_state = "hair_vlong"

	longeralt
		name = "Long Hair Alt"
		icon_state = "hair_vlongfringe"

	longeralt2
		name = "Long Hair Alt 2"
		icon_state = "hair_longeralt2"

	longest
		name = "Very Long Hair"
		icon_state = "hair_longest"

	longfringe
		name = "Long Fringe"
		icon_state = "hair_longfringe"

	longish
		name = "Longer Hair"
		icon_state = "hair_b2"

	longovereye
		name = "Overeye Long"
		icon_state = "hair_longovereye"

	mahdrills
		name = "Drillruru"
		icon_state = "hair_drillruru"
		gender = FEMALE

	mbraid
		name = "Medium Braid"
		icon_state = "hair_shortbraid"
		gender = FEMALE

	mbraidalt
		name = "Medium Braid Alt"
		icon_state = "hair_mediumbraid"
		gender = FEMALE

	messy_bun
		name = "Messy Bun"
		icon_state = "hair_messybun"
		gender = FEMALE

	mohawk
		name = "Mohawk"
		icon_state = "hair_d"
		species_allowed = list("Human","Unathi")

	mulder
		name = "Mulder"
		icon_state = "hair_mulder"

	nitori
		name = "Nitori"
		icon_state = "hair_nitori"
		gender = FEMALE

	odango
		name = "Odango"
		icon_state = "hair_odango"
		gender = FEMALE

	ombre
		name = "Ombre"
		icon_state = "hair_ombre"
		gender = FEMALE

	parted
		name = "Parted"
		icon_state = "hair_parted"

	pixie
		name = "Pixie"
		icon_state = "hair_pixie"
		gender = FEMALE

	pompadour
		name = "Pompadour"
		icon_state = "hair_pompadour"
		gender = MALE

	ponytail1
		name = "Ponytail 1"
		icon_state = "hair_ponytail"

	ponytail2
		name = "Ponytail 2"
		icon_state = "hair_pa"
		gender = FEMALE

	ponytail3
		name = "Ponytail 3"
		icon_state = "hair_ponytail3"

	ponytail4
		name = "Ponytail 4"
		icon_state = "hair_ponytail4"
		gender = FEMALE

	ponytail5
		name = "Ponytail 5"
		icon_state = "hair_ponytail5"

	ponytail6
		name = "Ponytail 6"
		icon_state = "hair_ponytail6"

	poofy
		name = "Poofy"
		icon_state = "hair_poofy"
		gender = FEMALE

	quiff
		name = "Quiff"
		icon_state = "hair_quiff"
		gender = MALE

	ramona
		name = "Ramona"
		icon_state = "hair_ramona"

	reversemohawk
		name = "Reverse Mohawk"
		icon_state = "hair_reversemohawk"
		gender = MALE

	rows
		name = "Rows"
		icon_state = "hair_rows"
		gender = MALE

	sargeant
		name = "Flat Top"
		icon_state = "hair_sargeant"
		gender = MALE

	scully
		name = "Scully"
		icon_state = "hair_scully"
		gender = FEMALE

	short
		name = "Short Hair"
		icon_state = "hair_a"

	shortalt
		name = "Short Hair Alt"
		icon_state = "hair_short_alt"

	shortbangs
		name = "Short Bangs"
		icon_state = "hair_shortbangs"

	shortovereye
		name = "Overeye Short"
		icon_state = "hair_shortovereye"

	sidepart
		name = "Sidepart Hair"
		icon_state = "hair_sidepart"

	sideponytail
		name = "Side Ponytail"
		icon_state = "hair_stail"
		gender = FEMALE

	skinhead
		name = "Skinhead"
		icon_state = "hair_skinhead"

	smessy
		name = "Messy Hair"
		icon_state = "hair_smessy"

	spiky
		name = "Spiky"
		icon_state = "hair_spikey"
		species_allowed = list("Human","Unathi")

	stylo
		name = "Stylo"
		icon_state = "hair_stylo"

	test
		name = "Test Hair"
		icon_state = "hair_test2"
		gender = FEMALE

	updo
		name = "Updo"
		icon_state = "hair_updo"
		gender = FEMALE

	vegeta
		name = "Vegeta"
		icon_state = "hair_toriyama2"
		gender = MALE

	wisp
		name = "Wisp"
		icon_state = "hair_wisp"
		gender = FEMALE

	zone
		name = "Zone Braid"
		icon_state = "hair_zone"
		gender = FEMALE

	ipc
		species_allowed = list("Machine")

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

	icon = 'icons/mob/Human_face.dmi'
	gender = MALE // barf (unless you're a dorf, dorfs dig chix /w beards :P)

	abe
		name = "Abraham Lincoln Beard"
		icon_state = "facial_abe"

	chaplin
		name = "Square Mustache"
		icon_state = "facial_chaplin"

	chinstrap
		name = "Chinstrap"
		icon_state = "facial_chin"

	dwarf
		name = "Dwarf Beard"
		icon_state = "facial_dwarf"

	elvis
		name = "Elvis Sideburns"
		icon_state = "facial_elvis"
		species_allowed = list("Human","Unathi")

	fullbeard
		name = "Full Beard"
		icon_state = "facial_fullbeard"

	gt
		name = "Goatee"
		icon_state = "facial_gt"

	hip
		name = "Hipster Beard"
		icon_state = "facial_hip"

	hogan
		name = "Hulk Hogan Mustache"
		icon_state = "facial_hogan" //-Neek

	jensen
		name = "Adam Jensen Beard"
		icon_state = "facial_jensen"

	longbeard
		name = "Long Beard"
		icon_state = "facial_longbeard"

	neckbeard
		name = "Neckbeard"
		icon_state = "facial_neckbeard"

	selleck
		name = "Selleck Mustache"
		icon_state = "facial_selleck"

	shaved
		name = "Shaved"
		icon_state = "bald"
		gender = NEUTER
		species_allowed = list("Human","Unathi","Tajara","Skrell","Vox","Machine")

	vandyke
		name = "Van Dyke Mustache"
		icon_state = "facial_vandyke"

	vlongbeard
		name = "Very Long Beard"
		icon_state = "facial_wise"

	watson
		name = "Watson Mustache"
		icon_state = "facial_watson"



/*
///////////////////////////////////
/  =---------------------------=  /
/  == Alien Style Definitions ==  /
/  =---------------------------=  /
///////////////////////////////////
*/

/datum/sprite_accessory/hair
	skr_tentacle_f
		name = "Skrell Female Tentacles"
		icon_state = "skrell_hair_f"
		species_allowed = list("Skrell")
		gender = FEMALE

	skr_tentacle_f_alt
		name = "Skrell Female Tentacles Alt"
		icon_state = "skrell_hair_f_alt"
		species_allowed = list("Skrell")
		gender = FEMALE

	skr_tentacle_f_old
		name = "Skrell Female Tentacles (old)"
		icon_state = "skrell_hair_f_old"
		species_allowed = list("Skrell")
		gender = FEMALE

	skr_tentacle_f_wide
		name = "Skrell Female Tentacles Wide"
		icon_state = "skrell_hair_f_wide"
		species_allowed = list("Skrell")
		gender = FEMALE

	skr_tentacle_m
		name = "Skrell Male Tentacles"
		icon_state = "skrell_hair_m"
		species_allowed = list("Skrell")
		gender = MALE

	taj_ears
		name = "Tajaran Ears"
		icon_state = "ears_plain"
		species_allowed = list("Tajara")

	taj_ears_bangs
		name = "Tajara Bangs"
		icon_state = "hair_bangs"
		species_allowed = list("Tajara")

	taj_ears_braid
		name = "Tajara Braid"
		icon_state = "hair_tbraid"
		species_allowed = list("Tajara")

	taj_ears_chalma
		name = "Tajara Chalma"
		icon_state = "hair_chalma"
		species_allowed = list("Tajara")

	taj_ears_clean
		name = "Tajara Clean"
		icon_state = "hair_clean"
		species_allowed = list("Tajara")

	taj_ears_long
		name = "Tajara Long"
		icon_state = "hair_long"
		species_allowed = list("Tajara")

	taj_ears_messy
		name = "Tajara Messy"
		icon_state = "hair_messy"
		species_allowed = list("Tajara")

	taj_ears_mohawk
		name = "Tajaran Mohawk"
		icon_state = "hair_mohawk"
		species_allowed = list("Tajara")

	taj_ears_curly
		name = "Tajaran Curly"
		icon_state = "hair_curly"
		species_allowed = list("Tajara")

	taj_ears_plait
		name = "Tajara Plait"
		icon_state = "hair_plait"
		species_allowed = list("Tajara")

	taj_ears_rattail
		name = "Tajara Rat Tail"
		icon_state = "hair_rattail"
		species_allowed = list("Tajara")

	taj_ears_shaggy
		name = "Tajara Shaggy"
		icon_state = "hair_shaggy"
		species_allowed = list("Tajara")

	taj_ears_spiky
		name = "Tajara Spiky"
		icon_state = "hair_tajspiky"
		species_allowed = list("Tajara")

	taj_ears_straight
		name = "Tajara Straight"
		icon_state = "hair_straight"
		species_allowed = list("Tajara")

	taj_ears_victory
		name = "Tajara Victory Curls"
		icon_state = "hair_victory"
		gender = FEMALE
		species_allowed = list("Tajara")

	taj_ears_wife
		name = "Tajara Housewife"
		icon_state = "hair_wife"
		gender = FEMALE
		species_allowed = list("Tajara")

	taj_ears_bob
		name = "Tajara Bob"
		icon_state = "hair_tbob"
		species_allowed = list("Tajara")

	taj_ears_fingercurl
		name = "Tajara Finger Curls"
		icon_state = "hair_fingerwave"
		species_allowed = list("Tajara")

	una_frills_long
		name = "Long Unathi Frills"
		icon_state = "soghun_longfrills"
		species_allowed = list("Unathi")

	una_frills_short
		name = "Short Unathi Frills"
		icon_state = "soghun_shortfrills"
		species_allowed = list("Unathi")

	una_horns
		name = "Unathi Horns"
		icon_state = "soghun_horns"
		species_allowed = list("Unathi")

	una_horns_ram
		name = "Unathi Ram Horns"
		icon_state = "soghun_ramhorns"
		species_allowed = list("Unathi")

	una_horns_curled
		name = "Unathi Curled Horns"
		icon_state = "soghun_curledhorns"
		species_allowed = list("Unathi")

	una_spines_long
		name = "Long Unathi Spines"
		icon_state = "soghun_longspines"
		species_allowed = list("Unathi")

	una_spines_short
		name = "Short Unathi Spines"
		icon_state = "soghun_shortspines"
		species_allowed = list("Unathi")

	vox_quills_short
		name = "Short Vox Quills"
		icon_state = "vox_shortquills"
		species_allowed = list("Vox")



/datum/sprite_accessory/facial_hair
	taj_goatee
		name = "Tajara Goatee"
		icon_state = "facial_goatee"
		species_allowed = list("Tajara")

	taj_moustache
		name = "Tajara Moustache"
		icon_state = "facial_moustache"
		species_allowed = list("Tajara")

	taj_mutton
		name = "Tajara Mutton"
		icon_state = "facial_mutton"
		species_allowed = list("Tajara")

	taj_pencilstache
		name = "Tajara Pencilstache"
		icon_state = "facial_pencilstache"
		species_allowed = list("Tajara")

	taj_sideburns
		name = "Tajara Sideburns"
		icon_state = "facial_sideburns"
		species_allowed = list("Tajara")

	taj_smallstache
		name = "Tajara Smallsatche"
		icon_state = "facial_smallstache"
		species_allowed = list("Tajara")


//skin styles - WIP
//going to have to re-integrate this with surgery
//let the icon_state hold an icon preview for now
/datum/sprite_accessory/skin
	icon = 'icons/mob/human_races/r_human.dmi'

	human
		name = "Default human skin"
		icon_state = "default"
		species_allowed = list("Human")

	human_tatt01
		name = "Tatt01 human skin"
		icon_state = "tatt1"
		species_allowed = list("Human")

	tajaran
		name = "Default tajaran skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_tajaran.dmi'
		species_allowed = list("Tajara")

	unathi
		name = "Default Unathi skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_lizard.dmi'
		species_allowed = list("Unathi")

	skrell
		name = "Default skrell skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_skrell.dmi'
		species_allowed = list("Skrell")
