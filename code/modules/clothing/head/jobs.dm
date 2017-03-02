
//Bartender
/obj/item/clothing/head/chefhat
	name = "chef's hat"
	desc = "It's a hat used by chefs to keep hair out of your food. Judging by the food in the mess, they don't work."
	icon_state = "chefhat"
	item_state = "chefhat"
	desc = "The commander in chef's head wear."
	siemens_coefficient = 0.9

/obj/item/clothing/head/caphat
	name = "captain's hat"
	icon_state = "captain"
	desc = "It's good being the king."
	item_state = "caphat"
	siemens_coefficient = 0.9

/obj/item/clothing/head/captain/formal
	name = "parade hat"
	desc = "No one in a commanding position should be without a perfect, white hat of ultimate authority."
	icon_state = "officercap"

//Captain: This probably shouldn't be space-worthy
/obj/item/clothing/head/cap
	name = "captain's cap"
	desc = "You fear to wear it for the negligence it brings."
	icon_state = "capcap"
	siemens_coefficient = 0.9

//Chaplain
/obj/item/clothing/head/chaplain_hood
	name = "chaplain's hood"
	desc = "It's hood that covers the head. It keeps you warm during the space winters."
	icon_state = "chaplain_hood"
	flags_inv = BLOCKHAIR
	body_parts_covered = HEAD

//Chaplain
/obj/item/clothing/head/nun_hood
	name = "nun hood"
	desc = "Maximum piety in this star system."
	icon_state = "nun_hood"
	flags_inv = BLOCKHAIR
	body_parts_covered = HEAD

//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, an artists favorite headwear."
	icon_state = "beret"
	body_parts_covered = 0

//Security

/obj/item/clothing/head/HoS
	name = "Head of Security Hat"
	desc = "The hat of the Head of Security. For showing the officers who's in charge."
	icon_state = "hoscap"
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 10, bomb = 25, bio = 10, rad = 0)
	siemens_coefficient = 0.8

/obj/item/clothing/head/HoS/solyarkin
	name = "Internal security hat."
	desc = "An old hat. A lot of time ago it was part of standard Internal Security gear, \
			but now - its just memories "
	icon_state = "secelitetop"
	item_state = "secelitetop"




/obj/item/clothing/head/helmet/warden
	name = "warden's hat"
	desc = "It's a special helmet issued to the Warden of a securiy force. Protects the head from impacts."
	armor = list(melee = 60, bullet = 40, laser = 60, energy = 15, bomb = 25, bio = 0, rad = 0)
	icon_state = "policehelm"

/obj/item/clothing/head/helmet/warden/alt
	icon_state = "warden"
	desc = "A Collectable Police Officer's Hat. This hat emphasizes that you are THE LAW."

/obj/item/clothing/head/helmet/warden/drill
	name = "warden's drill hat"
	desc = "You've definitely have seen that hat before."
	icon_state = "wardendrill"

/obj/item/clothing/head/hop
	name = "crew resource's hat"
	desc = "A stylish hat that both protects you from enraged former-crewmembers \
			and gives you a false sense of authority."
	icon_state = "hopcap"
	armor = list(melee = 40, bullet = 30, laser = 25, energy = 10, bomb = 5, bio = 0, rad = 0)

/obj/item/clothing/head/beret/sec
	name = "security beret"
	desc = "A beret with the security insignia emblazoned on it. \
			For officers that are more inclined towards style than safety."
	icon_state = "beret_badge"
/obj/item/clothing/head/beret/sec/alt
	name = "officer beret"
	desc = "A navy blue beret with an officer's rank emblem. \
			For officers that are more inclined towards style than safety."
	icon_state = "officerberet"
/obj/item/clothing/head/beret/sec/hos
	name = "officer beret"
	desc = "A navy blue beret with a commander's rank emblem. \
			For officers that are more inclined towards style than safety."
	icon_state = "hosberet"
/obj/item/clothing/head/beret/sec/warden
	name = "warden beret"
	desc = "A navy blue beret with a warden's rank emblem. \
			For officers that are more inclined towards style than safety."
	icon_state = "wardenberet"
/obj/item/clothing/head/beret/sec/alt/corp
	name = "officer beret"
	desc = "A black beret with an officer's rank emblem. \
			For officers that are more inclined towards style than safety."
	icon_state = "beret_corporate_officer"
/obj/item/clothing/head/beret/sec/hos/corp
	name = "officer beret"
	desc = "A black beret with a commander's rank emblem. \
			For officers that are more inclined towards style than safety."
	icon_state = "beret_corporate_hos"
/obj/item/clothing/head/beret/sec/warden/corp
	name = "warden beret"
	desc = "A black beret with a warden's rank emblem.\
			For officers that are more inclined towards style than safety."
	icon_state = "beret_corporate_warden"
/obj/item/clothing/head/beret/eng
	name = "engineering beret"
	desc = "A beret with the engineering insignia emblazoned on it. \
			For engineers that are more inclined towards style than safety."
	icon_state = "e_beret_badge"
/obj/item/clothing/head/beret/jan
	name = "purple beret"
	desc = "A stylish, if purple, beret."
	icon_state = "purpleberet"
/obj/item/clothing/head/beret/centcom/officer
	name = "officers beret"
	desc = "A black beret adorned with the shield—a silver kite \
			shield with an engraved sword—of the NanoTrasen security forces."
	icon_state = "centcomofficerberet"
/obj/item/clothing/head/beret/centcom/captain
	name = "captains beret"
	desc = "A white beret adorned with the shield—a silver kite \
			shield with an engraved sword—of the NanoTrasen security forces."
	icon_state = "centcomcaptain"

//Detective
/obj/item/clothing/head/det_hat
	name = "hat"
	desc = "Someone who wears this will look very smart."
	icon_state = "detective"
	allowed = list(/obj/item/weapon/reagent_containers/food/snacks/candy_corn, /obj/item/weapon/pen)
	armor = list(melee = 50, bullet = 5, laser = 25,energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	body_parts_covered = 0
/obj/item/clothing/head/det_hat/black
	icon_state = "detective2"

//Medical
/obj/item/clothing/head/surgery
	name = "surgical cap"
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs."
	icon_state = "surgcap_blue"
	flags_inv = BLOCKHEADHAIR

/obj/item/clothing/head/surgery/purple
	desc = "A cap surgeons wear during operations. \
			Keeps their hair from tickling your internal organs. This one is deep purple."
	icon_state = "surgcap_purple"

/obj/item/clothing/head/surgery/blue
	desc = "A cap surgeons wear during operations. \
			Keeps their hair from tickling your internal organs. This one is baby blue."
	icon_state = "surgcap_blue"

/obj/item/clothing/head/surgery/green
	desc = "A cap surgeons wear during operations. \
			Keeps their hair from tickling your internal organs. This one is dark green."
	icon_state = "surgcap_green"
