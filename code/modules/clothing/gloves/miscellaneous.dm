/obj/item/clothing/gloves/captain
	desc = "Regal blue gloves, with a nice gold trim. Swanky."
	name = "captain's gloves"
	icon_state = "captain"
	item_state = "captain"
	siemens_coefficient = 0
	permeability_coefficient = 0.05

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/black/cyborg
	desc = "beep boop borp"
	name = "cyborg gloves"
	siemens_coefficient = 1.0

/obj/item/clothing/gloves/black/swat
	desc = "These tactical gloves are somewhat fire and impact-resistant."
	name = "\improper SWAT Gloves"
	siemens_coefficient = 0.50
	permeability_coefficient = 0.05

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/black/swat/combat //Combined effect of SWAT gloves and insulated gloves
	desc = "These tactical gloves are somewhat fire and impact resistant."
	name = "combat gloves"
	siemens_coefficient = 0
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/white/latex
	name = "latex gloves"
	desc = "Sterile latex gloves."
	siemens_coefficient = 1.0 //thin latex gloves, much more conductive than fabric gloves (basically a capacitor for AC)
	permeability_coefficient = 0.01
	germ_level = 0

/obj/item/clothing/gloves/botanic_leather
	desc = "These leather work gloves protect against thorns, barbs, prickles, spikes and other harmful objects of floral origin."
	name = "botanist's leather gloves"
	icon_state = "leather"
	item_state = "leather"
	permeability_coefficient = 0.05
	siemens_coefficient = 0.50 //thick work gloves

/obj/item/clothing/gloves/black/batman
	name = "batman gloves"
	icon_state = "batman"

/obj/item/clothing/gloves/black/half
	name = "half cut gloves"
	icon_state = "half_cut_gloves"