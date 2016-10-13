/mob/living/carbon/human
	//Hair colour and style
	var/hair_color = "#000000"
	var/h_style = "Bald"

	//Facial hair color and style
	var/facial_color = "#000000"
	var/f_style = "Shaved"

	//Eyes color
	var/eyes_color = "#000000"

	var/s_tone = 0	//Skin tone

	//Skin colour
	var/skin_color = "#000000"

	var/size_multiplier = 1 //multiplier for the mob's icon size
	var/damage_multiplier = 1 //multiplies melee combat damage
	var/icon_update = 1 //whether icon updating shall take place

	var/datum/body_build/body_build = null

	var/lip_color

	var/age = 30		//Player's age (pure fluff)
	var/b_type = "A+"	//Player's bloodtype
	var/synthetic		//If they are a synthetic (aka synthetic torso)

	var/backbag = 2		//Which backpack type the player has chosen. Nothing, Satchel or Backpack.

	// General information
	var/home_system = ""
	var/citizenship = ""
	var/personal_faction = ""
	var/religion = ""

	//Equipment slots
	var/obj/item/wear_suit = null
	var/obj/item/w_uniform = null
	var/obj/item/shoes = null
	var/obj/item/belt = null
	var/obj/item/gloves = null
	var/obj/item/glasses = null
	var/obj/item/head = null
	var/obj/item/l_ear = null
	var/obj/item/r_ear = null
	var/obj/item/wear_id = null
	var/obj/item/r_store = null
	var/obj/item/l_store = null
	var/obj/item/s_store = null
	var/obj/item/h_underwear = null
	var/obj/item/h_socks = null
	var/obj/item/h_undershirt = null
//	var/obj/item/h_neck = null

	var/icon/stand_icon = null
	var/icon/lying_icon = null

	var/speech_problem_flag = 0

	var/miming = null //Toggle for the mime's abilities.
	var/special_voice = "" // For changing our voice. Used by a symptom.

	var/last_dam = -1	//Used for determining if we need to process all organs or just some or even none.
	var/list/bad_external_organs = list()// organs we check until they are good.

	var/xylophone = 0 //For the spoooooooky xylophone cooldown

	var/mob/remoteview_target = null
	var/hand_blood_color

	var/list/flavor_texts = list()
	var/gunshot_residue

	mob_bump_flag = HUMAN
	mob_push_flags = ~HEAVY
	mob_swap_flags = ~HEAVY
