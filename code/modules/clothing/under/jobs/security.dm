/*
 * Contains:
 *		Security
 *		Detective
 *		Head of Security
 */

/*
 * Security
 */
/obj/item/clothing/under/rank/head_of_security
	desc = "It's a jumpsuit worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer."
	name = "head of security's jumpsuit"
	icon_state = "hos_red"
	item_state = "red"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/head_of_security/skirt
	desc = "It's a fashionable jumpskirt worn by those few with the dedication to achieve the position of \"Head of Security\". It has additional armor to protect the wearer."
	name = "head of security's jumpskirt"
	icon_state = "hos_redf"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/warden
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for more robust protection. It has the word \"Warden\" written on the shoulders."
	name = "warden's jumpsuit"
	icon_state = "warden_red"
	item_state = "red"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/warden/skirt
	desc = "Standard feminine fashion for a Warden. It is made of sturdier material than standard jumpskirts. It has the word \"Warden\" written on the shoulders."
	name = "warden's jumpskirt"
	icon_state = "warden_redf"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/security
	name = "security officer's jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "officer_red"
	item_state = "red"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security/skirt
	name = "security officer's jumpskirt"
	desc = "Standard feminine fashion for Security Officers.  It's made of sturdier material than the standard jumpskirts."
	icon_state = "officer_redf"

/*
Corporate
*/
/obj/item/clothing/under/rank/head_of_security/corp
	icon_state = "hos_corporate"
	item_state = "black"

/obj/item/clothing/under/rank/warden/corp
	icon_state = "warden_corporate"
	item_state = "black"

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	item_state = "black"

/obj/item/clothing/under/rank/tactical
	name = "tactical jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "swatunder"
	item_state = "green"
	armor = list(melee = 10, bullet = 5, laser = 5,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/*
 * Detective
 */
/obj/item/clothing/under/rank/det
	name = "detective's suit"
	desc = "A rumpled white dress shirt paired with well-worn grey slacks."
	icon_state = "detective"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	starting_accessories = list(/obj/item/clothing/accessory/blue_clip)

/obj/item/clothing/under/rank/det/black
	icon_state = "detective2"
	item_state = "sl_suit"

/obj/item/clothing/under/rank/det/slob
	icon_state = "polsuit"
	item_state = "sl_suit"

/obj/item/clothing/under/rank/det/seven
	icon_state = "detsuit_black"
	item_state = "sl_suit"

/obj/item/clothing/under/rank/det/forentech
	name = "red forensic technician suit"
	desc = "Someone who wears this means business."
	icon_state = "forentech"
	item_state = "r_suit"

/obj/item/clothing/under/rank/det/forentech2
	name = "blue forensic technician suit"
	desc = "Someone who wears this means business."
	icon_state = "forentech2"
	item_state = "b_suit"

/obj/item/clothing/under/rank/det/formal
	name = "formal uniform"
	desc = "It's Foresenic technician's formal suit. Classy black pants with white shirt and foresenics badge attached to it."
	icon_state = "formal_suit"
	item_state = "sl_suit"

/obj/item/clothing/under/rank/det/formal_dress
	name = "formal dress"
	desc = "It's Foresenic technician's formal skirt. Classy skirt pants with white shirt and foresenics badge attached to it."
	icon_state = "formal_dress"
	item_state = "sl_suit"

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security/solyarkin
	desc = "Better you do not meet the person who wears it."
	icon_state = "commi"

//Jensen cosplay gear
/obj/item/clothing/under/rank/head_of_security/jensen
	desc = "You never asked for anything that stylish."
	name = "head of security's jumpsuit"
	icon_state = "jensen"

/*
 * Blue uniforms
 */
/obj/item/clothing/under/rank/security/navyblue
	name = "security officer's uniform"
	desc = "The latest in fashionable security outfits."
	icon_state = "officerblueclothes"
	item_state = "ba_suit"

/obj/item/clothing/under/rank/head_of_security/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Head of Security."
	name = "head of security's uniform"
	icon_state = "hosblueclothes"
	item_state = "ba_suit"

/obj/item/clothing/under/rank/warden/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Warden."
	name = "warden's uniform"
	icon_state = "wardenblueclothes"
	item_state = "ba_suit"

/*
 * Navy uniforms
 */

/obj/item/clothing/under/rank/security/dnavy
	name = "security officer's uniform"
	desc = "Dark, navy and stylish. Enough to be the perfect piece of clothing."
	icon_state = "officerdnavyclothes"
	item_state = "ba_suit"

/obj/item/clothing/under/rank/head_of_security/dnavy
	desc = "The insignia on this uniform tells you that this uniform belongs to the Head of Security."
	name = "head of security's uniform"
	icon_state = "hosdnavyclothes"
	item_state = "ba_suit"

/obj/item/clothing/under/rank/warden/dnavy
	desc = "Dark. Navy. Sexy."
	name = "warden's uniform"
	icon_state = "wardendnavyclothes"
	item_state = "ba_suit"

//Investigator
/obj/item/clothing/under/investigator
	name = "worn suit"
	desc = "That's a simple white dress shirt with the pants."
	icon_state = "investigator"
	item_state = "det"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/investigator/alt
	desc = "That's a simple blue dress shirt with the jeans."
	icon_state = "investigatoralt"
	item_state = "det"

//Forensic Technician

/obj/item/clothing/under/forensic
	name = "black turtleneck"
	desc = "That's the black turtleneck with pants."
	icon_state = "forensictech"
	item_state = "bl_suit"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/dispatch
	name = "dispatcher's uniform"
	desc = "A dress shirt and khakis with a security patch sewn on."
	icon_state = "dispatch"
	item_state = "lawyer_blue"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security2
	name = "security officer's uniform"
	desc = "It's made of a slightly sturdier material, to allow for robust protection."
	icon_state = "redshirt2"
	item_state = "red"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

