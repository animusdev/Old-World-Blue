/obj/item/weapon/picket_sign
	icon_state = "picket"
	name = "blank picket sign"
	desc = "It's blank"
	force = 5
	w_class = 4.0
	attack_verb = list("bashed","smacked")

	var/label = ""

/obj/item/weapon/picket_sign/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/pen))
		var/input = russian_to_cp1251(input(usr, "What would you like to write on the sign", "Label Sigh"))
		if(input)
			label = input
			src.name = "[label] sign"
			desc =	"It reads: [label]"
	..()

/obj/item/weapon/picket_sign/attack_self(mob/living/carbon/human/user)
	if(label)
		user.visible_message("<span class='warning'>[user] waves around \the \"[label]\" sign.</span>")
	else
		user.visible_message("<span class='warning'>[user] waves around blank sign.</span>")