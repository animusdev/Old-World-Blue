var/global/list/chameleons_categories = list(
	"uniform" = list(),
	"hat" = list(),
	"suit" = list(),
	"shoes" = list(),
	"backpack" = list(),
	"gloves" = list(),
	"mask" = list(),
	"glasses" = list(),
	"belt" = list(),
	"backpack" = list(),
	"gun" = list()
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
	initialize_chameleon_list("backpack", /obj/item/weapon/storage/backpack)
	initialize_chameleon_list("belt", /obj/item/weapon/storage/belt)
	initialize_chameleon_list("gun", /obj/item/weapon/gun/projectile)
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
	origin_tech = "syndicate=2"
	w_class = 1
	var/category = ""
	var/obj/item/captured_item
	var/default_type
	var/emp_type

/obj/item/chameleon/AltClick(user)
	if(src in user)
		attack_self(user)
	else
		..()

/obj/item/chameleon/New()
	..()
	if(default_type)
		change_item_appearance(src, default_type)
	if(category)
		new /obj/item/chameleon/proc/change(src,"Change [capitalize(category)] Appearance")

/obj/item/chameleon/proc/change()
	set name = "Change Item Appearance"
	set desc = "Change item appearance"
	set category = "Object"
	set src in usr

	if(in_use) return
	in_use = 1
	var/picked = input(usr, "Select [category] to change it to", "Chameleon Setup") \
		as null|anything in chameleons_categories[category]
	if(!picked || !src in usr)
		return
	var/newtype = chameleons_categories[category][picked]
	change_item_appearance(src, newtype)

	update_icon()

	in_use = 0

/obj/item/chameleon/attackby(obj/item/weapon/W, mob/user)
	if(iswirecutter(W) && captured_item)
		if(isturf(loc))
			change_item_appearance(src, type)
			user << "<span class='notice'>You cut [src] from [captured_item].</span>"
			category = null
			captured_item.forceMove(src.loc)
			captured_item = null
			armor = initial(armor)
			return 1
		else
			user << "<span class='warning'>You must place [src] on flat surface for detach [initial(name)]!</span>"
	..()

/obj/item/chameleon/attack_self(var/mob/living/user)
	if(in_use) return
	if(category)
		change(user)

/obj/item/chameleon/resolve_attackby(obj/item/A, mob/user)
	if(!category && !captured_item)
		if(istype(A, /obj/item/clothing/under))
			category = "uniform"
		else if(istype(A, /obj/item/clothing/head))
			category = "hat"
		else if(istype(A, /obj/item/clothing/suit))
			category = "suit"
		else if(istype(A, /obj/item/clothing/shoes))
			category = "shoes"
		else if(istype(A, /obj/item/clothing/gloves))
			category = "gloves"
		else if(istype(A, /obj/item/clothing/mask))
			category = "mask"
		else if(istype(A, /obj/item/clothing/glasses))
			category = "glasses"
		if(category)
			if(!isturf(A.loc))
				user << "<span class='warning'>You must place [A] on flat surface for attaching [src]!</span>"
				category = ""
				return 1
			new /obj/item/chameleon/proc/change(src,"Change [capitalize(category)] Appearance")
			user.drop_from_inventory(src, A.loc)
			captured_item = A
			src.armor = captured_item.armor
			src.w_class = captured_item.w_class
			A.forceMove(src)
			change_item_appearance(src, captured_item.type)
			user << "<span class='notice'>You attach [src] to [captured_item]</span>"
			return 1
	return ..()

/obj/item/chameleon/gloves/emp_act(severity)
	if(captured_item)
		change_item_appearance(src, captured_item.type)
	else if(default_type)
		change_item_appearance(src, default_type)

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
	desc = "It's a plain jumpsuit. It seems to have a small dial on the wrist."
	default_type = /obj/item/clothing/under/color
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
	default_type = /obj/item/clothing/head/soft/grey
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
	default_type = /obj/item/clothing/suit/armor
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
	default_type = /obj/item/clothing/shoes/black
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
	default_type = /obj/item/clothing/gloves/black
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
	default_type = /obj/item/clothing/mask/gas
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
	default_type = /obj/item/clothing/glasses/meson
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

	var/picked = input("Select backpack to change it to", "Chameleon Backpack") as null|anything in chameleons_categories["backpack"]
	if(!picked) return

	var/newtype = chameleons_categories["backpack"][picked]
	change_item_appearance(src, newtype)
	update_held_icon()


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
	origin_tech = "combat=2;materials=2;syndicate=3"
	ammo_type = /obj/item/ammo_casing/chameleon
	matter = list()

/obj/item/weapon/gun/projectile/chameleon/New()
	..()
	for(var/i in 1 to max_shells)
		loaded += new/obj/item/ammo_casing/chameleon(src)

/obj/item/weapon/gun/projectile/chameleon/emp_act(severity)
	name = "desert eagle"
	desc = "It's a desert eagle."
	icon_state = "deagle"
	update_held_icon()

/obj/item/weapon/gun/projectile/chameleon/verb/change()
	set name = "Change Gun Appearance"
	set category = "Object"
	set src in usr

	var/picked = input("Select gun to change it to", "Chameleon Gun") as null|anything in chameleons_categories["gun"]
	if(!picked) return

	var/newtype = chameleons_categories["gun"][picked]
	change_item_appearance(src, newtype)
	update_held_icon()