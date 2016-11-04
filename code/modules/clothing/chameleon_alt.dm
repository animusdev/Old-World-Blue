var/global/list/chameleons_categories = list(
	"uniform" = list(),
	"hat" = list(),
	"suit" = list(),
	"shoes" = list(),
	"backpack" = list(),
	"gloves" = list(),
	"mask" = list(),
	"glasses" = list()
)

/hook/startup/proc/populate_chameleons_lists()
	initialize_chameleon_list("uniform", /obj/item/clothing/under, list(/obj/item/clothing/under/gimmick))
	initialize_chameleon_list("hat", /obj/item/clothing/head)
	initialize_chameleon_list("suit", /obj/item/clothing/suit,list(
		/obj/item/clothing/suit/cyborg_suit,
		/obj/item/clothing/suit/justice,
		/obj/item/clothing/suit/storage/greatcoat)
	)
	initialize_chameleon_list("shoes", /obj/item/clothing/shoes, list(
		/obj/item/clothing/shoes/syndigaloshes,
		/obj/item/clothing/shoes/cyborg)
	)
	initialize_chameleon_list("gloves", /obj/item/clothing/gloves)
	initialize_chameleon_list("mask", /obj/item/clothing/mask, list(/obj/item/clothing/mask/scarf))
	initialize_chameleon_list("glasses", /obj/item/clothing/glasses)
	return 1

/proc/initialize_chameleon_list(category = "", var/basic_type, var/list/blocked = list())
	var/list/check = chameleons_categories[category]
	if(check && check.len) return
	var/list/styles = list()
	for(var/T in subtypesof(basic_type) - blocked)
		var/obj/O = T
		styles[initial(O.name)] = T
	chameleons_categories[category] = styles
	return

/proc/change_item_appearance(var/obj/item/C, var/obj/item/clothing/new_type)
	if(!istype(C) || !new_type) return
	C.desc = initial(new_type.desc)
	C.name = initial(new_type.name)
	C.icon = initial(new_type.icon)
	C.icon_state = initial(new_type.icon_state)
	C.item_state = initial(new_type.item_state)
	C.wear_state = initial(new_type.wear_state)

	C.slot_flags = initial(new_type.slot_flags)

	C.item_state_slots = initial(new_type.item_state_slots)
	C.body_parts_covered = initial(new_type.body_parts_covered)
	C.flags_inv = initial(new_type.flags_inv)
	C.description_info = initial(new_type.description_info)

/obj/item/chameleon
	name = "chameleon module"
	desc = "Miniature hologram generator."
	permeability_coefficient = 0.90
	icon = 'icons/obj/device.dmi'
	icon_state = "shield0"
	origin_tech = "syndicate=3"
	var/category = ""

/obj/item/chameleon/attack_self(var/mob/living/user)
	if(in_use) return
	if(!category)
		in_use = 1
		category = input("Select clothing category.", "Categroy") as null|anything in chameleons_categories
		new /obj/item/chameleon/proc/change(src,"Change [capitalize(category)] Appearance")
		user << "<span class='notice'>Category has been set to [category].</span>"
		in_use = 0
	if(category)
		change(user)

/obj/item/chameleon/proc/change(var/mob/living/user)
	set name = "Change Item Appearance"
	set desc = "Change item appearance"
	set category = "Object"
	set src in usr

	if(in_use) return
	in_use = 1
	if(!user)
		user = usr
	var/picked = input("Select [category] to change it to", "Chameleon Setup") \
		as null|anything in chameleons_categories[category]
	if(!picked || !src in usr)
		return
	var/newtype = chameleons_categories[category][picked]
	change_item_appearance(src, newtype)

	update_icon()

	in_use = 0

/obj/item/chameleon/update_icon()
	..() // Blood overlay and so on.
	// Kostily time!
	var/mob/living/carbon/human/user = loc
	if(!istype(user)) return

	if(src == user.get_active_hand() || src == user.get_inactive_hand())
		update_held_icon()
	else
		switch(category)
			if("uniform")	user.update_inv_w_uniform()
			if("hat")		user.update_inv_head()
			if("suit")		user.update_inv_wear_suit()
			if("shoes")		user.update_inv_shoes()
			if("backpack")	user.update_inv_back()
			if("gloves")	user.update_inv_gloves()
			if("mask")		user.update_inv_wear_mask()
			if("glasses")	user.update_inv_glasses()

//*****************
//**Cham Jumpsuit**
//*****************

/obj/item/chameleon/under
//starts off as black
	name = "black jumpsuit"
	icon_state = "black"
	item_state = "bl_suit"
	desc = "It's a plain jumpsuit. It seems to have a small dial on the wrist."
	origin_tech = "syndicate=3"
	category = "uniform"

/obj/item/chameleon/under/emp_act(severity)
	name = "psychedelic"
	desc = "Groovy!"
	icon_state = "psyche"
	update_icon()

//*****************
//**Chameleon Hat**
//*****************

/obj/item/chameleon/head
	name = "grey cap"
	icon_state = "greysoft"
	item_state = "greysoft"
	desc = "It looks like a plain hat, but upon closer inspection, \
			there's an advanced holographic array installed inside. It seems to have a small dial inside."
	body_parts_covered = 0
	category = "hat"

/obj/item/chameleon/head/emp_act(severity)
	name = "grey cap"
	desc = "It's a baseball hat in a tasteful grey colour."
	icon_state = "greysoft"
	update_icon()

//******************
//**Chameleon Suit**
//******************

/obj/item/chameleon/suit
	name = "armor"
	icon_state = "armor"
	item_state = "armor"
	desc = "It appears to be a vest of standard armor, except this is embedded with a hidden holographic cloaker, \
			allowing it to change it's appearance, but offering no protection.. It seems to have a small dial inside."
	category = "suit"

/obj/item/chameleon/suit/emp_act(severity)
	name = "armor"
	desc = "An armored vest that protects against some damage."
	icon_state = "armor"
	update_icon()

//*******************
//**Chameleon Shoes**
//*******************

/obj/item/chameleon/shoes
	name = "black shoes"
	icon_state = "black"
	item_state = "black"
	desc = "They're comfy black shoes, with clever cloaking technology built in.\
			It seems to have a small dial on the back of each shoe."
	category = "shoes"

/obj/item/chameleon/shoes/emp_act(severity)
	name = "black shoes"
	desc = "A pair of black shoes."
	icon_state = "black"
	item_state = "black"
	update_icon()

//********************
//**Chameleon Gloves**
//********************

/obj/item/chameleon/gloves
	name = "black gloves"
	icon_state = "black"
	item_state = "bgloves"
	desc = "It looks like a pair of gloves, but it seems to have a small dial inside."
	category = "gloves"

/obj/item/chameleon/gloves/emp_act(severity)
	name = "black gloves"
	desc = "It looks like a pair of gloves, but it seems to have a small dial inside."
	icon_state = "black"
	update_icon()

//******************
//**Chameleon Mask**
//******************

/obj/item/chameleon/mask
	name = "gas mask"
	icon_state = "gas_alt"
	item_state = "gas_alt"
	desc = "It looks like a plain gask mask, but on closer inspection, it seems to have a small dial inside."
	category = "mask"

/obj/item/chameleon/mask/emp_act(severity)
	name = "gas mask"
	desc = "It's a gas mask."
	icon_state = "gas_alt"
	update_icon()

//*********************
//**Chameleon Glasses**
//*********************

/obj/item/chameleon/glasses
	name = "Optical Meson Scanner"
	icon_state = "meson"
	item_state = "glasses"
	desc = "It looks like a plain set of mesons, but on closer inspection, it seems to have a small dial inside."
	category = "glasses"

/obj/item/chameleon/glasses/emp_act(severity)
	name = "Optical Meson Scanner"
	desc = "It's a set of mesons."
	icon_state = "meson"
	update_icon()

//**********************
//**Chameleon Backpack**
//**********************

/obj/item/weapon/storage/backpack/chameleon
	name = "backpack"
	icon_state = "backpack"
	item_state = "backpack"
	desc = "A backpack outfitted with cloaking tech. It seems to have a small dial inside, kept away from the storage."
	var/list/styles = list()

/obj/item/weapon/storage/backpack/chameleon/New()
	if(styles && styles.len) return
	for(var/T in typesof(/obj/item/weapon/storage/backpack) - type)
		var/obj/O = T
		styles[initial(O.name)] = T

/obj/item/weapon/storage/backpack/chameleon/emp_act(severity)
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	icon_state = "backpack"
	item_state = "backpack"
	update_icon()

/obj/item/weapon/storage/backpack/chameleon/verb/change()
	set name = "Change Backpack Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select backpack to change it to", "Chameleon Backpack") as null|anything in styles
	if(!picked) return

	var/newtype = styles[picked]
	change_item_appearance(src, newtype)


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
	var/global/list/styles = list()

/obj/item/weapon/gun/projectile/chameleon/New()
	..()
	if(styles && styles.len) return
	for(var/T in subtypesof(/obj/item/weapon/gun/projectile) - type)
		var/obj/O = T
		styles[initial(O.name)] = T

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

	var/picked = input("Select backpack to change it to", "Chameleon Backpack") as null|anything in styles
	if(!picked) return

	var/newtype = styles[picked]
	change_item_appearance(src, newtype)