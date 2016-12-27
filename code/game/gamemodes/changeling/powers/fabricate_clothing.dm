var/global/list/changeling_fabricated_clothing = list(
	"w_uniform" = /obj/item/chameleon/changeling/under,
	"head" = /obj/item/chameleon/changeling/head,
	"wear_suit" = /obj/item/chameleon/changeling/suit,
	"shoes" = /obj/item/chameleon/changeling/shoes,
	"gloves" = /obj/item/chameleon/changeling/gloves,
	"wear_mask" = /obj/item/chameleon/changeling/mask,
	"glasses" = /obj/item/chameleon/changeling/glasses,
	"back" = /obj/item/chameleon/changeling/backpack,
	"belt" = /obj/item/chameleon/changeling/belt,
//	"wear_id" = /obj/item/weapon/card/id/syndicate/changeling
	)

/datum/power/changeling/fabricate_clothing
	name = "Fabricate Clothing"
	desc = "We reform our flesh to resemble various cloths, leathers, and other materials, allowing us to quickly create a disguise.  \
	We cannot be relieved of this clothing by others."
	helptext = "The disguise we create offers no defensive ability.  Each equipment slot that is empty will be filled with fabricated equipment. \
	To remove our new fabricated clothing, use this ability again."
	genomecost = 2
	verbpath = /mob/living/proc/changeling_fabricate_clothing

//Grows biological versions of chameleon clothes.
/mob/living/proc/changeling_fabricate_clothing()
	set category = "Changeling"
	set name = "Fabricate Clothing (10)"

	if(changeling_generic_equip_all_slots(changeling_fabricated_clothing, cost = 10))
		return 1
	return 0

/obj/item/chameleon/changeling
	origin_tech = list() //The base chameleon items have origin technology, which we will inherit if we don't null out this variable.
	canremove = 0 //Since this is essentially flesh impersonating clothes, tearing someone's skin off as if it were clothing isn't possible.

/obj/item/chameleon/changeling/emp_act(severity)
	return

/obj/item/chameleon/changeling/dropped()
	qdel(src)

/obj/item/chameleon/changeling/attack_hand(mob/living/carbon/human/user)
	if(src in user)
		playsound(src, 'sound/effects/splat.ogg', 30, 1)
		user.visible_message(
			"<span class='warning'>[user] tears off [src]!</span>",
			"<span class='notice'>We remove [src].</span>"
		)
		user.drop_from_inventory(src)
		user.update_icons()
		return

/obj/item/chameleon/changeling/under
	name = "malformed flesh"
	icon = 'icons/inv_slots/uniforms/icon.dmi'
	icon_state = "lingchameleon"
	item_state = "lingchameleon"
	desc = "The flesh all around us has grown a new layer of cells that can shift appearance and create a biological fabric that cannot be distinguished from \
	ordinary cloth, allowing us to make ourselves appear to wear almost anything."
	category = "uniform"
	slot_flags = SLOT_ICLOTHING

/obj/item/chameleon/changeling/head
	name = "malformed head"
	icon = 'icons/inv_slots/hats/icon.dmi'
	icon_state = "lingchameleon"
	desc = "Our head is swelled with a large quanity of rapidly shifting skin cells.  We can reform our head to resemble various hats and \
	helmets that biologicals are so fond of wearing."
	category = "hat"
	slot_flags = SLOT_HEAD

/obj/item/chameleon/changeling/suit
	name = "chitinous chest"
	icon = 'icons/inv_slots/suits/icon.dmi'
	icon_state = "lingchameleon"
	item_state = "armor"
	desc = "The cells in our chest are rapidly shifting, ready to reform into material that can resemble most pieces of clothing."
	category = "suit"
	slot_flags = SLOT_OCLOTHING

/obj/item/chameleon/changeling/shoes
	name = "malformed feet"
	icon = 'icons/inv_slots/shoes/icon.dmi'
	icon_state = "lingchameleon"
	item_state = "black"
	desc = "Our feet are overlayed with another layer of flesh and bone on top.  We can reform our feet to resemble various boots and shoes."
	category = "shoes"
	slot_flags = SLOT_FEET

/obj/item/chameleon/changeling/gloves
	name = "malformed hands"
	icon = 'icons/inv_slots/gloves/icon.dmi'
	icon_state = "lingchameleon"
	item_state = "lingchameleon"
	desc = "Our hands have a second layer of flesh on top.  We can reform our hands to resemble a large variety of fabrics and materials that biologicals \
	tend to wear on their hands.  Remember that these won't protect your hands from harm."
	category = "gloves"
	slot_flags = SLOT_GLOVES

/obj/item/chameleon/changeling/mask
	name = "chitin visor"
	icon = 'icons/inv_slots/masks/icon.dmi'
	icon_state = "lingchameleon"
	item_state = "gas_alt"
	desc = "A transparent visor of brittle chitin covers our face.  We can reform it to resemble various masks that biologicals use.  It can also utilize internal \
	tanks.."
	category = "mask"
	slot_flags = SLOT_MASK

/obj/item/chameleon/changeling/glasses
	name = "chitin goggles"
	icon_state = "lingchameleon"
	item_state = "glasses"
	desc = "A transparent piece of eyewear made out of brittle chitin.  We can reform it to resemble various glasses and goggles."
	category = "glasses"
	slot_flags = SLOT_EYES

/obj/item/chameleon/changeling/belt
	name = "waist pouch"
	icon = 'icons/inv_slots/belts/icon.dmi'
	desc = "We can store objects in this, as well as shift it's appearance, so that it resembles various common belts."
	icon_state = "lingchameleon"
	item_state = "utility"
	category = "belt"
	slot_flags = SLOT_BELT

/obj/item/chameleon/changeling/backpack
	name = "backpack"
	icon = 'icons/inv_slots/back/icon.dmi'
	icon_state = "backpack"
	item_state = "backpack"
	desc = "A large pouch imbedded in our back, it can shift form to resemble many common backpacks that other biologicals are fond of using."
	category = "backpack"
	slot_flags = SLOT_BACK

/*
/obj/item/weapon/card/id/syndicate/changeling
	name = "chitinous card"
	desc = "A card that we can reform to resemble identification cards.  Due to the nature of the material this is made of, it cannot store any access codes."
	icon_state = "changeling"
	assignment = "Harvester"
	origin_tech = list()
	electronic_warfare = 1 //The lack of RFID stuff makes it hard for AIs to track, I guess. *handwaves*
	registered_user = null
	access = null
	canremove = 0

/obj/item/weapon/card/id/syndicate/changeling/New(mob/user as mob)
	..()
	registered_user = user
	access = null

/obj/item/weapon/card/id/syndicate/changeling/verb/shred()
	set name = "Shred ID Card"
	set category = "Chameleon Items"
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		playsound(src, 'sound/effects/splat.ogg', 30, 1)
		visible_message("<span class='warning'>[H] tears off [src]!</span>",
		"<span class='notice'>We remove [src].</span>")
		qdel(src)
		H.update_icons()

/obj/item/weapon/card/id/syndicate/changeling/Click() //Since we can't hold it in our hands, and attack_hand() doesn't work if it in inventory...
	if(!registered_user)
		registered_user = usr
		usr.set_id_info(src)
	ui_interact(registered_user)
	..()
*/