var/global/list/chameleons = list(
	"under" = list(),
	"head" = list(),
	"suit" = list(),
	"shoes" = list(),
	"backpack" = list(),
	"gloves" = list(),
	"mask" = list(),
	"glasses" = list(),
	"projectile" = list()
)

/obj/item/proc/initialize_chameleon_list(var/style_list = "", var/basic_type, var/list/blocked = list())
	var/list/check = chameleons[style_list]
	if(check && check.len) return
	src.permeability_coefficient = 0.90
	chameleons[style_list] = list("protect")
	var/list/styles = list()
	for(var/T in typesof(basic_type) - blocked - type)
		var/obj/O = T
		styles[initial(O.name)] = T
	chameleons[style_list] = styles
	return

/obj/item/proc/change_item_appearance(var/obj/item/new_type)
	if(!new_type) return
	desc = initial(new_type.desc)
	name = initial(new_type.name)
	icon = initial(new_type.icon)
	icon_state = initial(new_type.icon_state)
	item_state = initial(new_type.item_state)
	item_state_slots = initial(new_type.item_state_slots)
	body_parts_covered = initial(new_type.body_parts_covered)
	//flags = initial(new_type.flags)
	flags_inv = initial(new_type.flags_inv)
	description_info = initial(new_type.description_info)
	//slot_flags = initial(new_type.slot_flags)
	if (ismob(loc))
		var/mob/M = loc
		M.update_inv_obj(src, 1)


//*****************
//**Cham Jumpsuit**
//*****************

/obj/item/clothing/under/chameleon
//starts off as black
	name = "black jumpsuit"
	icon_state = "black"
	item_state = "bl_suit"
	desc = "It's a plain jumpsuit. It seems to have a small dial on the wrist."
	origin_tech = "syndicate=3"
	var/style_list = "under"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type, list(/obj/item/clothing/under/gimmick))

/obj/item/clothing/under/chameleon/emp_act(severity)
	name = "psychedelic"
	desc = "Groovy!"
	icon_state = "psyche"
	item_state_slots[slot_w_uniform_str] = "psyche"
	update_icon()
	update_clothing_icon()

/obj/item/clothing/under/chameleon/verb/change()
	set name = "Change Jumpsuit Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select jumpsuit to change it to", "Chameleon Jumpsuit")as null|anything in chameleons[style_list]
	if(!picked)
		return

	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)

//*****************
//**Chameleon Hat**
//*****************

/obj/item/clothing/head/chameleon
	name = "grey cap"
	icon_state = "greysoft"
	item_state = "greysoft"
	desc = "It looks like a plain hat, but upon closer inspection, there's an advanced holographic array installed inside. It seems to have a small dial inside."
	origin_tech = "syndicate=3"
	body_parts_covered = 0
	var/style_list = "head"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type, list(/obj/item/clothing/head/justice))

/obj/item/clothing/head/chameleon/emp_act(severity) //Because we don't have psych for all slots right now but still want a downside to EMP.  In this case your cover's blown.
	name = "grey cap"
	desc = "It's a baseball hat in a tasteful grey colour."
	icon_state = "greysoft"
	update_icon()
	update_clothing_icon()

/obj/item/clothing/head/chameleon/verb/change()
	set name = "Change Hat/Helmet Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select headwear to change it to", "Chameleon Hat")as null|anything in chameleons[style_list]
	if(!picked)
		return
	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)


//******************
//**Chameleon Suit**
//******************

/obj/item/clothing/suit/chameleon
	name = "armor"
	icon_state = "armor"
	item_state = "armor"
	desc = "It appears to be a vest of standard armor, except this is embedded with a hidden holographic cloaker, allowing it to change it's appearance, but offering no protection.. It seems to have a small dial inside."
	origin_tech = "syndicate=3"
	var/style_list = "suit"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type, list(/obj/item/clothing/suit/cyborg_suit,\
									/obj/item/clothing/suit/justice, /obj/item/clothing/suit/storage/greatcoat))

/obj/item/clothing/suit/chameleon/emp_act(severity) //Because we don't have psych for all slots right now but still want a downside to EMP.  In this case your cover's blown.
	name = "armor"
	desc = "An armored vest that protects against some damage."
	icon_state = "armor"
	update_icon()
	update_clothing_icon()

/obj/item/clothing/suit/chameleon/verb/change()
	set name = "Change Exosuit Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select exosuit to change it to", "Chameleon Exosuit")as null|anything in chameleons[style_list]
	if(!picked)
		return
	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)

//*******************
//**Chameleon Shoes**
//*******************
/obj/item/clothing/shoes/chameleon
	name = "black shoes"
	icon_state = "black"
	item_state = "black"
	desc = "They're comfy black shoes, with clever cloaking technology built in. It seems to have a small dial on the back of each shoe."
	origin_tech = "syndicate=3"
	var/style_list = "shoes"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type,\
			list(/obj/item/clothing/shoes/syndigaloshes, /obj/item/clothing/shoes/cyborg))

/obj/item/clothing/shoes/chameleon/emp_act(severity) //Because we don't have psych for all slots right now but still want a downside to EMP.  In this case your cover's blown.
	name = "black shoes"
	desc = "A pair of black shoes."
	icon_state = "black"
	item_state = "black"
	update_icon()
	update_clothing_icon()

/obj/item/clothing/shoes/chameleon/verb/change()
	set name = "Change Footwear Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select shoes to change it to", "Chameleon Shoes")as null|anything in chameleons[style_list]
	if(!picked)
		return
	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)

//**********************
//**Chameleon Backpack**
//**********************
/obj/item/weapon/storage/backpack/chameleon
	name = "backpack"
	icon_state = "backpack"
	item_state = "backpack"
	desc = "A backpack outfitted with cloaking tech. It seems to have a small dial inside, kept away from the storage."
	origin_tech = "syndicate=3"
	var/style_list = "backpack"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type,\
			list(/obj/item/weapon/storage/backpack/satchel/withwallet))

/obj/item/weapon/storage/backpack/chameleon/emp_act(severity) //Because we don't have psych for all slots right now but still want a downside to EMP.  In this case your cover's blown.
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	icon_state = "backpack"
	item_state = "backpack"
	update_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_back()

/obj/item/weapon/storage/backpack/chameleon/verb/change()
	set name = "Change Backpack Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select backpack to change it to", "Chameleon Backpack")as null|anything in chameleons[style_list]
	if(!picked)
		return
	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)

//********************
//**Chameleon Gloves**
//********************

/obj/item/clothing/gloves/chameleon
	name = "black gloves"
	icon_state = "black"
	item_state = "bgloves"
	desc = "It looks like a pair of gloves, but it seems to have a small dial inside."
	origin_tech = "syndicate=3"
	var/style_list = "gloves"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type)

/obj/item/clothing/gloves/chameleon/emp_act(severity) //Because we don't have psych for all slots right now but still want a downside to EMP.  In this case your cover's blown.
	name = "black gloves"
	desc = "It looks like a pair of gloves, but it seems to have a small dial inside."
	icon_state = "black"
	update_icon()
	update_clothing_icon()

/obj/item/clothing/gloves/chameleon/verb/change()
	set name = "Change Gloves Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select gloves to change it to", "Chameleon Gloves")as null|anything in chameleons[style_list]
	if(!picked)
		return
	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)

//******************
//**Chameleon Mask**
//******************

/obj/item/clothing/mask/chameleon
	name = "gas mask"
	icon_state = "gas_alt"
	item_state = "gas_alt"
	desc = "It looks like a plain gask mask, but on closer inspection, it seems to have a small dial inside."
	origin_tech = "syndicate=3"
	var/style_list = "mask"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type)

/obj/item/clothing/mask/chameleon/emp_act(severity) //Because we don't have psych for all slots right now but still want a downside to EMP.  In this case your cover's blown.
	name = "gas mask"
	desc = "It's a gas mask."
	icon_state = "gas_alt"
	update_icon()
	update_clothing_icon()

/obj/item/clothing/mask/chameleon/verb/change()
	set name = "Change Mask Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select mask to change it to", "Chameleon Mask")as null|anything in chameleons[style_list]
	if(!picked)
		return
	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)

//*********************
//**Chameleon Glasses**
//*********************

/obj/item/clothing/glasses/chameleon
	name = "Optical Meson Scanner"
	icon_state = "meson"
	item_state = "glasses"
	desc = "It looks like a plain set of mesons, but on closer inspection, it seems to have a small dial inside."
	origin_tech = "syndicate=3"
	var/style_list = "glasses"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type)

/obj/item/clothing/glasses/chameleon/emp_act(severity) //Because we don't have psych for all slots right now but still want a downside to EMP.  In this case your cover's blown.
	name = "Optical Meson Scanner"
	desc = "It's a set of mesons."
	icon_state = "meson"
	update_icon()
	update_clothing_icon()

/obj/item/clothing/glasses/chameleon/verb/change()
	set name = "Change Glasses Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select glasses to change it to", "Chameleon Glasses")as null|anything in chameleons[style_list]
	if(!picked)
		return
	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)

//*****************
//**Chameleon Gun**
//*****************
/obj/item/weapon/gun/projectile/chameleon
	name = "desert eagle"
	desc = "A fake Desert Eagle with a dial on the side to change the gun's disguise."
	icon_state = "deagle"
	w_class = 3.0
	max_shells = 7
	caliber = ".45"
	origin_tech = "combat=2;materials=2;syndicate=8"
	ammo_type = "/obj/item/ammo_casing/chameleon"
	matter = list()
	var/style_list = "projectile"
	New()
		..()
		initialize_chameleon_list(style_list, parent_type)

/obj/item/weapon/gun/projectile/chameleon/emp_act(severity)
	name = "desert eagle"
	desc = "It's a desert eagle."
	icon_state = "deagle"
	update_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_r_hand()
		M.update_inv_l_hand()

/obj/item/weapon/gun/projectile/chameleon/verb/change()
	set name = "Change Gun Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select backpack to change it to", "Chameleon Backpack")as null|anything in chameleons[style_list]
	var/newtype = chameleons[style_list][picked]
	change_item_appearance(newtype)
