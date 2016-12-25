var/list/clients = list()							//list of all clients
var/list/admins = list()							//list of all clients whom are admins
var/list/directory = list()							//list of all ckeys with associated client

//Since it didn't really belong in any other category, I'm putting this here
//This is for procs to replace all the goddamn 'in world's that are chilling around the code

var/global/list/player_list = list()				//List of all mobs **with clients attached**. Excludes /mob/new_player
var/global/list/mob_list = list()					//List of all mobs, including clientless
var/global/list/human_mob_list = list()				//List of all human mobs and sub-types, including clientless
var/global/list/silicon_mob_list = list()			//List of all silicon mobs, including clientless
var/global/list/living_mob_list = list()			//List of all alive mobs, including clientless. Excludes /mob/new_player
var/global/list/dead_mob_list = list()				//List of all dead mobs, including clientless. Excludes /mob/new_player

var/global/list/cable_list = list()					//Index for all cables, so that powernets don't have to look through the entire world all the time
var/global/list/chemical_reactions_list				//list of all /datum/chemical_reaction datums. Used during chemical reactions
var/global/list/chemical_reagents_list				//list of all /datum/reagent datums indexed by reagent id. Used by chemistry stuff
var/global/list/landmarks_list = list()				//list of all landmarks created
var/global/list/surgery_steps = list()				//list of all surgery steps  |BS12
var/global/list/side_effects = list()				//list of all medical sideeffects types by thier names |BS12
var/global/list/mechas_list = list()				//list of all mechs. Used by hostile mobs target tracking.
var/global/list/joblist = list()					//list of all jobstypes, minus borg and AI

var/global/list/turfs = list()						//list of all turfs

//Languages/species/whitelist.
var/global/list/all_species[0]
var/global/list/all_languages[0]
var/global/list/whitelisted_species = list("Human") // Species that require a whitelist check.
var/global/list/playable_species = list("Human")    // A list of ALL playable species, whitelisted, latejoin or otherwise.

// Posters
var/global/list/poster_designs = list()

// AI icons
var/global/list/AI_icons = list(
	"Rainbow" = "ai-clown", "Monochrome" = "ai-mono", "Inverted" = "ai-u",
	"Firewall" = "ai-magma", "Green" = "ai-wierd", "Red" = "ai-red", "Static" = "ai-static",
	"Text" = "ai-text", "Smiley" = "ai-smiley", "Matrix" = "ai-matrix", "Angry" = "ai-angryface",
	"Dorf"  = "ai-dorf", "Bliss" = "ai-bliss", "Triumvirate" = "ai-triumvirate",
	"Triumvirate Static" = "ai-triumvirate-malf", "Soviet" = "ai-redoctober", "Trapped" = "ai-hades",
	"Heartline" = "ai-heartline", "Chatterbox" = "ai-president", "Helios" = "ai-helios", "Goon" = "ai-goon",
	"Dug Too Deep" = "ai-toodeep", "Database" = "ai-database", "Glitchman" = "ai-glitchman",
	"Lonestar" = "ai-lonestar", "Nanotrasen" = "ai-nanotrasen", "Whale" = "ai-whale", "Zone AI" = "ai-zone",
	"House" = "ai-rhouse", "Yuki" = "ai-yuki", "Xeno" = "ai-xeno", "Sparkles" = "ai-sparkles"
)

// Uplinks
var/list/obj/item/device/uplink/world_uplinks = list()

//Preferences stuff
	//Hairstyles
var/global/list/hair_styles_list = list()			//stores /datum/sprite_accessory/hair indexed by name
var/global/list/hair_styles_by_species = list()
var/global/list/facial_hair_styles_list = list()	//stores /datum/sprite_accessory/facial_hair indexed by name
var/global/list/facial_hair_styles_by_species = list()

	// Hidden slots
var/global/list/all_underwears = list("None")
var/global/list/all_undershirts = list("None")
var/global/list/all_socks = list("None")

	//Backpacks
var/global/list/backbaglist = list("None", "Backpack", "Satchel", "Satchel Job", "Dufflebag", "Messenger")
var/global/list/exclude_jobs = list(/datum/job/ai,/datum/job/cyborg)

	//Tattoo
var/global/list/tattoo_list = list(
	BP_CHEST  = list("Abstract" = "abstract", "Venom" = "venom"),
	"chest2"  = list("Abstract" = "abstract", "Cross" = "cross", "Skull" = "scull", "Spades" = "diamonds", "Venom" = "venom"),
	BP_HEAD   = list("Abstract" = "abstract", "Over left eye scar" = "scar", "Over right eye scar" = "scar2"),
	BP_GROIN  = list("Abstract" = "abstract"),
	BP_L_ARM  = list("Abstract" = "abstract", "Venom" = "venom"),
	BP_L_HAND = list("Abstract" = "abstract"),
	BP_R_ARM  = list("Abstract" = "abstract", "Stripes" = "stripes", "Venom" = "venom"),
	BP_R_HAND = list("Abstract" = "abstract"),
	BP_L_LEG  = list("Abstract" = "abstract", "Venom" = "venom"),
	BP_L_FOOT = list("Abstract" = "abstract"),
	BP_R_LEG  = list("Abstract" = "abstract", "Venom" = "venom"),
	BP_R_FOOT = list("Abstract" = "abstract")
)

var/global/list/flavs_list = list("general"="General", "torso"="Body", "head"="Head", "face"="Face", "eyes"="Eyes",\
				"arms"="Arms", "hands"="Hands", "legs"="Legs", "feet"="Feet")

var/global/list/organ_structure = list(
	chest = list(name= "Chest", children=list()),
	groin = list(name= "Groin",     parent=BP_CHEST, children=list()),
	head  = list(name= "Head",      parent=BP_CHEST, children=list()),
	r_arm = list(name= "Right arm", parent=BP_CHEST, children=list()),
	l_arm = list(name= "Left arm",  parent=BP_CHEST, children=list()),
	r_leg = list(name= "Right leg", parent=BP_GROIN, children=list()),
	l_leg = list(name= "Left leg",  parent=BP_GROIN, children=list()),
	r_hand= list(name= "Right hand",parent=BP_R_ARM, children=list()),
	l_hand= list(name= "Left hand", parent=BP_L_ARM, children=list()),
	r_foot= list(name= "Right foot",parent=BP_R_LEG, children=list()),
	l_foot= list(name= "Left foot", parent=BP_L_LEG, children=list()),
	)

var/global/list/organ_tag_to_name = list(
	head  = "Head", r_arm = "Right arm",r_hand = "Right hand",
	chest = "Body", r_leg = "Right Leg",r_foot = "Right foot",
	eyes  = "Eyes", l_arm = "Left arm", l_hand = "Left hand",
	groin = "Groin",l_leg = "Left Leg", l_foot = "Left foot",
	chest2= "Back", heart = "Heart",    lungs  = "Lungs",
	liver = "Liver"
	)

// Visual nets
var/list/datum/visualnet/visual_nets = list()
var/datum/visualnet/camera/cameranet = new()
var/datum/visualnet/cult/cultnet = new()

// Runes
var/global/list/rune_list = new()
var/global/list/escape_list = list()
var/global/list/endgame_exits = list()
var/global/list/endgame_safespawns = list()
//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/makeDatumRefLists()
	var/list/paths

	var/rkey = 0
	paths = typesof(/datum/species)-/datum/species
	for(var/T in paths)
		rkey++
		var/datum/species/S = new T
		S.race_key = rkey //Used in mob icon caching.
		all_species[S.name] = S

		if(!(S.flags & IS_RESTRICTED))
			playable_species |= S.name
		if(S.flags & IS_WHITELISTED)
			whitelisted_species += S.name

	//Hair - Initialise all /datum/sprite_accessory/hair into an list indexed by hair-style name
	paths = typesof(/datum/sprite_accessory/hair) - /datum/sprite_accessory/hair
	for(var/path in paths)
		var/datum/sprite_accessory/hair/H = new path()
		if(!H.name)// if name empty then delete (for base type)
			del(H)
			continue
		hair_styles_list[H.name] = H
		for(var/species in H.species_allowed)
			if(!hair_styles_by_species[species])
				hair_styles_by_species[species] = list()
			hair_styles_by_species[species] += H.name

	//Facial Hair - Initialise all /datum/sprite_accessory/facial_hair into an list indexed by facialhair-style name
	paths = typesof(/datum/sprite_accessory/facial_hair) - /datum/sprite_accessory/facial_hair
	for(var/path in paths)
		var/datum/sprite_accessory/facial_hair/H = new path()
		if(!H.name) // if name empty then delete (for base type)
			del(H)
			continue
		facial_hair_styles_list[H.name] = H
		for(var/species in H.species_allowed)
			if(!facial_hair_styles_by_species[species])
				facial_hair_styles_by_species[species] = list()
			facial_hair_styles_by_species[species] += H.name

	// Undershirt list
	paths = typesof(/obj/item/clothing/hidden/undershirt) - /obj/item/clothing/hidden/undershirt
	for(var/path in paths)
		var/obj/item/clothing/hidden/H = path
		all_undershirts[initial(H.name)] = path

	// Underwear list
	paths = typesof(/obj/item/clothing/hidden/underwear) - /obj/item/clothing/hidden/underwear
	for(var/path in paths)
		var/obj/item/clothing/hidden/H = path
		all_underwears[initial(H.name)] = path

	// Socks list
	paths = typesof(/obj/item/clothing/hidden/socks) - /obj/item/clothing/hidden/socks
	for(var/path in paths)
		var/obj/item/clothing/hidden/H = path
		all_socks[initial(H.name)] = path

	//Surgery Steps - Initialize all /datum/surgery_step into a list
	paths = typesof(/datum/surgery_step)-/datum/surgery_step
	for(var/T in paths)
		var/datum/surgery_step/S = new T
		surgery_steps += S
	sort_surgeries()

	//List of job. I can't believe this was calculated multiple times per tick!
	paths = typesof(/datum/job)-/datum/job
	paths -= exclude_jobs
	for(var/T in paths)
		var/datum/job/J = new T
		joblist[J.title] = J

	//Languages and species.
	paths = typesof(/datum/language)-/datum/language
	for(var/T in paths)
		var/datum/language/L = new T
		all_languages[L.name] = L

	for(var/organ in organ_structure)
		var/list/organ_data = organ_structure[organ]
		if(organ_data["parent"])
			var/list/parent = organ_structure[organ_data["parent"]]
			parent["children"] += organ

	//Posters
	paths = typesof(/datum/poster) - /datum/poster - /datum/poster/wanted
	for(var/T in paths)
		var/datum/poster/P = new T
		poster_designs += P

	return 1

/* // Uncomment to debug chemical reaction list.
/client/verb/debug_chemical_list()

	for (var/reaction in chemical_reactions_list)
		. += "chemical_reactions_list\[\"[reaction]\"\] = \"[chemical_reactions_list[reaction]]\"\n"
		if(islist(chemical_reactions_list[reaction]))
			var/list/L = chemical_reactions_list[reaction]
			for(var/t in L)
				. += "    has: [t]\n"
	world << .
*/
