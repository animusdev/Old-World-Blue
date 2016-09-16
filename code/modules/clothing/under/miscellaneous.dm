/obj/item/clothing/under/pj/red
	name = "red pj's"
	desc = "Sleepwear."
	icon_state = "red_pyjamas"
	item_state = "r_suit"

/obj/item/clothing/under/pj/blue
	name = "blue pj's"
	desc = "Sleepwear."
	icon_state = "blue_pyjamas"
	item_state = "b_suit"

/obj/item/clothing/under/captain_fly
	name = "rogue's uniform"
	desc = "For the man who doesn't care because he's still free."
	icon_state = "captain_fly"
	item_state = "r_suit"

/obj/item/clothing/under/scratch
	name = "white suit"
	desc = "A white suit, suitable for an excellent host"
	icon_state = "scratch"
	item_state = "scratch"

/obj/item/clothing/under/sl_suit
	desc = "It's a very amish looking suit."
	name = "amish suit"
	icon_state = "sl_suit"
	item_state = "sl_suit"

/obj/item/clothing/under/max
	name = "classy suit"
	desc = "You can't really tell the reason, but this suit looks kinda painful"
	icon_state = "max"
	item_state = "max"

/obj/item/clothing/under/waiter
	name = "waiter's outfit"
	desc = "It's a very smart uniform with a special pocket for tip."
	icon_state = "waiter"
	item_state = "waiter"

/obj/item/clothing/under/rank/mailman
	name = "mailman's jumpsuit"
	desc = "<i>'Special delivery!'</i>"
	icon_state = "mailman"
	item_state = "b_suit"

/obj/item/clothing/under/sexyclown
	name = "sexy-clown suit"
	desc = "It makes you look HONKable!"
	icon_state = "sexyclown"
	item_state = "lb_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/vice
	name = "vice officer's jumpsuit"
	desc = "It's the standard issue pretty-boy outfit, as seen on Holo-Vision."
	icon_state = "vice"
	item_state = "gy_suit"

//This set of uniforms looks fairly fancy and is generally used for high-ranking NT personnel from what I've seen, so lets give them appropriate ranks.
/obj/item/clothing/under/rank/centcom
	desc = "Gold trim on space-black cloth, this uniform displays the rank of \"Captain.\""
	name = "\improper NanoTrasen Officer's Dress Uniform"
	icon_state = "officer"
	item_state = "lawyer_black"
	displays_id = 0

/obj/item/clothing/under/rank/centcom_officer
	desc = "Gold trim on space-black cloth, this uniform displays the rank of \"Admiral.\""
	name = "\improper NanoTrasen Officer's Dress Uniform"
	icon_state = "officer"
	item_state = "lawyer_black"
	displays_id = 0

/obj/item/clothing/under/rank/centcom_captain
	desc = "Gold trim on space-black cloth, this uniform displays the rank of \"Admiral-Executive.\""
	name = "\improper NanoTrasen Officer's Dress Uniform"
	icon_state = "centcom"
	item_state = "lawyer_black"
	displays_id = 0

/obj/item/clothing/under/ert
	name = "ERT tactical uniform"
	desc = "A short-sleeved black uniform, paired with grey digital-camo cargo pants. It looks very tactical."
	icon_state = "ert_uniform"
	item_state = "bl_suit"

/obj/item/clothing/under/space
	name = "\improper NASA jumpsuit"
	desc = "It has a NASA logo on it and is made of space-proofed materials."
	icon_state = "black"
	item_state = "bl_suit"
	w_class = 4//bulky item
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.02
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | ARMS //Needs gloves and shoes with cold protection to be fully protected.
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/under/acj
	name = "administrative cybernetic jumpsuit"
	icon_state = "syndicate"
	item_state = "bl_suit"
	desc = "it's a cybernetically enhanced jumpsuit used for administrative duties."
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	armor = list(melee = 100, bullet = 100, laser = 100,energy = 100, bomb = 100, bio = 100, rad = 100)
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/under/owl
	name = "owl uniform"
	desc = "A jumpsuit with owl wings. Photorealistic owl feathers! Twooooo!"
	icon_state = "owl"
	item_state = "owl"

/obj/item/clothing/under/johnny
	name = "johnny~~ jumpsuit"
	desc = "Johnny~~"
	icon_state = "johnny"
	item_state = "johnny"

/obj/item/clothing/under/rainbow
	name = "rainbow"
	desc = "rainbow"
	icon_state = "rainbow"
	item_state = "rainbow"

/obj/item/clothing/under/psysuit
	name = "dark undersuit"
	desc = "A thick, layered grey undersuit lined with power cables. Feels a little like wearing an electrical storm."
	icon_state = "psysuit"
	item_state = "bl_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/under/gentlesuit
	name = "gentlemans suit"
	desc = "A silk black shirt with a white tie and a matching gray vest and slacks. Feels proper."
	icon_state = "gentlesuit"
	item_state = "gy_suit"

/obj/item/clothing/under/maid
	name = "maid uniform"
	desc = "Traditional French maid uniform."
	icon_state = "maid"
	item_state = "chef"

/obj/item/clothing/under/gimmick/rank/captain/suit
	name = "captain's suit"
	desc = "A green suit and yellow necktie. Exemplifies authority."
	icon_state = "green_suit"
	item_state = "dg_suit"

/obj/item/clothing/under/gimmick/rank/head_of_personnel/suit
	name = "head of personnel's suit"
	desc = "A teal suit and yellow necktie. An authoritative yet tacky ensemble."
	icon_state = "teal_suit"
	item_state = "g_suit"

/obj/item/clothing/under/suit_jacket
	name = "black suit"
	desc = "A black suit and red tie. Very formal."
	icon_state = "black_suit"
	item_state = "bl_suit"

/obj/item/clothing/under/suit_jacket/really_black
	name = "executive suit"
	desc = "A formal black suit and red tie, intended for the station's finest."
	icon_state = "really_black_suit"
	item_state = "jensensuit"

/obj/item/clothing/under/suit_jacket/female
	name = "executive suit"
	desc = "A formal trouser suit for women, intended for the station's finest."
	icon_state = "black_suit_fem"
	item_state = "lawyer_black"

/obj/item/clothing/under/suit_jacket/red
	name = "red suit"
	desc = "A red suit and blue tie. Somewhat formal."
	icon_state = "red_suit"
	item_state = "r_suit"

/obj/item/clothing/under/blackskirt
	name = "black skirt"
	desc = "A black skirt, very fancy!"
	icon_state = "blackskirt"
	item_state = "bl_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/schoolgirl
	name = "schoolgirl uniform"
	desc = "It's just like one of my Japanese animes!"
	icon_state = "schoolgirl"
	item_state = "w_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/overalls
	name = "laborer's overalls"
	desc = "A set of durable overalls for getting the job done."
	icon_state = "overalls"
	item_state = "lb_suit"

/obj/item/clothing/under/pirate
	name = "pirate outfit"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "r_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/soviet
	name = "soviet uniform"
	desc = "For the Motherland!"
	icon_state = "soviet"
	item_state = "gy_suit"

/obj/item/clothing/under/redcoat
	name = "redcoat uniform"
	desc = "Looks old."
	icon_state = "redcoat"
	item_state = "r_suit"

/obj/item/clothing/under/kilt
	name = "kilt"
	desc = "Includes shoes and plaid"
	icon_state = "kilt"
	item_state = "kilt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|FEET

/obj/item/clothing/under/sexymime
	name = "sexy mime outfit"
	desc = "The only time when you DON'T enjoy looking at someone's rack."
	icon_state = "sexymime"
	item_state = "ba_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

//ZONE-tan Loadout
/obj/item/clothing/under/zone
	name = "zone dress"
	desc = "A pleasant to touch indigo dress. It smells like seafood."
	icon_state = "zone"
	item_state = "p_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/gladiator
	name = "gladiator uniform"
	desc = "Are you not entertained? Is that not why you are here?"
	icon_state = "gladiator"
	item_state = "o_suit"
	body_parts_covered = LOWER_TORSO

//dress
/obj/item/clothing/under/dress
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/dress/dress_fire
	name = "flame dress"
	desc = "A small black dress with blue flames print on it."
	icon_state = "dress_fire"
	item_state = "waiter"

/obj/item/clothing/under/dress/dress_blue
	name = "blue dress"
	desc = "A small blue dress."
	icon_state = "bluedress"
	item_state = "b_suit"

/obj/item/clothing/under/dress/dress_green
	name = "green dress"
	desc = "A simple, tight fitting green dress."
	icon_state = "dress_green"
	item_state = "g_suit"

/obj/item/clothing/under/dress/dress_orange
	name = "orange dress"
	desc = "A fancy orange gown for those who like to show leg."
	icon_state = "dress_orange"
	item_state = "y_suit"

/obj/item/clothing/under/dress/dress_pink
	name = "pink dress"
	desc = "A simple, tight fitting pink dress."
	icon_state = "dress_pink"
	item_state = "p_suit"

/obj/item/clothing/under/dress/dress_yellow
	name = "yellow dress"
	desc = "A flirty, little yellow dress."
	icon_state = "dress_yellow"
	item_state = "y_suit"

/obj/item/clothing/under/dress/dress_saloon
	name = "saloon girl dress"
	desc = "A old western inspired gown for the girl who likes to drink."
	icon_state = "dress_saloon"
	item_state = "r_suit"

/obj/item/clothing/under/dress/dress_cap
	name = "captain's dress uniform"
	desc = "Feminine fashion for the style concious captain."
	icon_state = "dress_cap"
	item_state = "b_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/dress/dress_hop
	name = "head of personnel dress uniform"
	desc = "Feminine fashion for the style concious HoP."
	icon_state = "dress_hop"
	item_state = "b_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/dress/dress_hr
	name = "human resources director uniform"
	desc = "Superior class for the nosy H.R. Director."
	icon_state = "huresource"
	item_state = "y_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/dress/plaid_blue
	name = "blue plaid skirt"
	desc = "A preppy blue skirt with a white blouse."
	icon_state = "plaid_blue"
	item_state = "ba_suit"

/obj/item/clothing/under/dress/plaid_red
	name = "red plaid skirt"
	desc = "A preppy red skirt with a white blouse."
	icon_state = "plaid_red"
	item_state = "ba_suit"

/obj/item/clothing/under/dress/plaid_purple
	name = "blue purple skirt"
	desc = "A preppy purple skirt with a white blouse."
	icon_state = "plaid_purple"
	item_state = "ba_suit"

/obj/item/clothing/under/dress/plaid_black
	name = "black purple skirt"
	desc = "A preppy black skirt with a white blouse."
	icon_state = "plaid_black"
	item_state = "ba_suit"

//wedding stuff
/obj/item/clothing/under/wedding/
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/wedding/bride_orange
	name = "orange wedding dress"
	desc = "A big and puffy orange dress."
	icon_state = "bride_orange"
	item_state = "y_suit"
	flags_inv = HIDESHOES

/obj/item/clothing/under/wedding/bride_purple
	name = "purple wedding dress"
	desc = "A big and puffy purple dress."
	icon_state = "bride_purple"
	item_state = "p_suit"
	flags_inv = HIDESHOES

/obj/item/clothing/under/wedding/bride_blue
	name = "blue wedding dress"
	desc = "A big and puffy blue dress."
	icon_state = "bride_blue"
	item_state = "b_suit"
	flags_inv = HIDESHOES

/obj/item/clothing/under/wedding/bride_red
	name = "red wedding dress"
	desc = "A big and puffy red dress."
	icon_state = "bride_red"
	item_state = "r_suit"
	flags_inv = HIDESHOES

/obj/item/clothing/under/wedding/bride_white
	name = "silky wedding dress"
	desc = "A white wedding gown made from the finest silk."
	icon_state = "bride_white"
	item_state = "nursesuit"
	flags_inv = HIDESHOES
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/sundress
	name = "sundress"
	desc = "Makes you want to frolic in a field of daisies."
	icon_state = "sundress"
	item_state = "bl_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/sundress_white
	name = "white sundress"
	desc = "A white sundress decorated with purple lilies."
	icon_state = "sundress_white"
	item_state = "w_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/blackjumpskirt
	name = "black jumpskirt"
	desc = "A black jumpskirt, Sol size 0."
	icon_state = "blackjumpskirt"
	item_state = "bl_suit"

/obj/item/clothing/under/captainformal
	name = "captain's formal uniform"
	desc = "A captain's formal-wear, for special occasions."
	icon_state = "captain_formal"
	item_state = "b_suit"

/obj/item/clothing/under/hosformalmale
	name = "head of security's formal uniform"
	desc = "A male head of security's formal-wear, for special occasions."
	icon_state = "hos_formal_male"
	item_state = "r_suit"

/obj/item/clothing/under/hosformalfem
	name = "head of security's formal uniform"
	desc = "A female head of security's formal-wear, for special occasions."
	icon_state = "hos_formal_fem"
	item_state = "r_suit"

/obj/item/clothing/under/assistantformal
	name = "assistant's formal uniform"
	desc = "An assistant's formal-wear. Why an assistant needs formal-wear is still unknown."
	icon_state = "assistant_formal"
	item_state = "gy_suit"

/obj/item/clothing/under/suit_jacket/charcoal
	name = "charcoal suit"
	desc = "A charcoal suit and red tie. Very professional."
	icon_state = "charcoal_suit"
	item_state = "bl_suit"

/obj/item/clothing/under/suit_jacket/navy
	name = "navy suit"
	desc = "A navy suit and red tie, intended for the station's finest."
	icon_state = "navy_suit"
	item_state = "bl_suit"

/obj/item/clothing/under/suit_jacket/burgundy
	name = "burgundy suit"
	desc = "A burgundy suit and black tie. Somewhat formal."
	icon_state = "burgundy_suit"
	item_state = "r_suit"

/obj/item/clothing/under/suit_jacket/checkered
	name = "checkered suit"
	desc = "That's a very nice suit you have there. Shame if something were to happen to it, eh?"
	icon_state = "checkered_suit"
	item_state = "gy_suit"

/obj/item/clothing/under/suit_jacket/tan
	name = "tan suit"
	desc = "A tan suit with a yellow tie. Smart, but casual."
	icon_state = "tan_suit"
	item_state = "lb_suit"

/obj/item/clothing/under/serviceoveralls
	name = "workman outfit"
	desc = "The very image of a working man. Not that you're probably doing work."
	icon_state = "mechanic"
	item_state = "lb_suit"

/obj/item/clothing/under/cheongsam
	name = "white cheongsam"
	desc = "It is a white cheongsam dress."
	icon_state = "mai_yang"
	item_state = "nursesuit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/nisse
	name = "fabulous yellow dress"
	desc = "What a miracle!"
	icon_state = "nisse_dress"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/lethal
	name = "fabulous mazarine dress"
	desc = "Luxurious dress."
	icon_state = "lethal_dress"
	item_state = "psyche"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS|HANDS

/obj/item/clothing/under/nikiss
	name = "fabulous purple dress"
	desc = "SHRIEK!"
	icon_state = "nikiss_dress"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/blazer
	name = "blue blazer"
	desc = "A bold but yet conservative outfit, red corduroys, navy blazer and a tie."
	icon_state = "blue_blazer"
	item_state = "blue_blazer"

/obj/item/clothing/under/phantom
	name = "stylish red vest"
	icon_state = "phantom"
	item_state = "r_suit"

/obj/item/clothing/under/russobluecamooutfit
	name = "russian blue camo"
	desc = "Drop and give me dvadtsat!"
	icon_state = "russobluecamo"
	item_state = "b_suit"

/obj/item/clothing/under/squatter_outfit
 	name = "slav squatter tracksuit"
 	desc = "Cyka blyat."
 	icon_state = "squatteroutfit"
 	item_state = "squatteroutfit"

/obj/item/clothing/under/batman
	name = "batman uniform"
	desc = "You are the night."
	icon_state = "batman"
	item_state = "bl_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	armor = list(melee = 20, bullet = 10, laser = 0,energy = 5, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/under/batman/hop
	desc = "It's a jumpsuit worn by someone who works in the position of \"Head of Personnel\"."
	icon_state = "bmuniform"

/obj/item/clothing/under/bum1
	name = "simple clothing"
	desc = "There are a change? A pair of thalers at least ..."
	icon_state = "bum1"

/obj/item/clothing/under/bum2
	name = "simple clothing"
	desc = "Place your order here ."
	icon_state = "bum2"

/obj/item/clothing/under/bum3
	name = "simple clothing"
	desc = "Captain - a piece of shit!"
	icon_state = "bum3"

/obj/item/clothing/under/SID
	name = "SID suit"
	icon_state = "jane_sid_suit"
	item_state = "suit-orange"

/obj/item/clothing/under/french
	name = "french suit"
	icon_state = "french_suit"

//Pants

/obj/item/clothing/under/pants
	body_parts_covered = LOWER_TORSO|LEGS
	gender = PLURAL

/obj/item/clothing/under/pants/classicjeans
	name = "classic jeans"
	desc = "You feel cooler already."
	icon_state = "jeansclassic"
	item_state = "jeansclassic"

/obj/item/clothing/under/pants/mustangjeans
	name = "Must Hang jeans"
	desc = "Made in the finest space jeans factory this side of Alpha Centauri."
	icon_state = "jeansmustang"
	item_state = "jeansmustang"

/obj/item/clothing/under/pants/blackjeans
	name = "black jeans"
	desc = "Only for those who can pull it off."
	icon_state = "jeansblack"
	item_state = "jeansblack"

/obj/item/clothing/under/pants/youngfolksjeans
	name = "Young Folks jeans"
	desc = "For those tired of boring old jeans. Relive the passion of your youth!"
	icon_state = "jeansyoungfolks"
	item_state = "jeansyoungfolks"

/obj/item/clothing/under/pants/white
	name = "white pants"
	desc = "Plain white pants. Boring."
	icon_state = "whitepants"
	item_state = "whitepants"

/obj/item/clothing/under/pants/red
	name = "red pants"
	desc = "Bright red pants. Overflowing with personality."
	icon_state = "redpants"
	item_state = "redpants"

/obj/item/clothing/under/pants/black
	name = "black pants"
	desc = "These pants are dark, like your soul."
	icon_state = "blackpants"
	item_state = "blackpants"

/obj/item/clothing/under/pants/tan
	name = "tan pants"
	desc = "Some tan pants. You look like a white collar worker with these on."
	icon_state = "tanpants"
	item_state = "tanpants"

/obj/item/clothing/under/pants/track
	name = "track pants"
	desc = "A pair of track pants, for the athletic."
	icon_state = "trackpants"
	item_state = "trackpants"

/obj/item/clothing/under/pants/jeans
	name = "jeans"
	desc = "A nondescript pair of tough blue jeans."
	icon_state = "jeans"
	item_state = "jeansc"

/obj/item/clothing/under/pants/sweaterj
	name = "sweaterj"
	desc = "Common space sweater."
	icon_state = "sweaterj"

/obj/item/clothing/under/pants/blouse
	name = "blouse"
	desc = "Common space blouse."
	icon_state = "blouse"

/obj/item/clothing/under/pants/khaki
	name = "khaki pants"
	desc = "A pair of dust beige khaki pants."
	icon_state = "khaki"
	item_state = "khaki"

/obj/item/clothing/under/pants/camo
	name = "camo pants"
	desc = "A pair of woodland camouflage pants. Probably not the best choice for a space station."
	icon_state = "camopants"
	item_state = "camopants"

/obj/item/clothing/under/army
	name = "battle dress uniform"
	desc = "Standard-issue uniform of the NT colonial infantry"
	icon_state = "armybd"
	item_state = "armybd"

//swimsuit
/obj/item/clothing/under/swimsuit/
	siemens_coefficient = 1
	body_parts_covered = 0

/obj/item/clothing/under/swimsuit/black
	name = "black swimsuit"
	desc = "An oldfashioned black swimsuit."
	icon_state = "swim_black"
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/blue
	name = "blue swimsuit"
	desc = "An oldfashioned blue swimsuit."
	icon_state = "swim_blue"
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/purple
	name = "purple swimsuit"
	desc = "An oldfashioned purple swimsuit."
	icon_state = "swim_purp"
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/green
	name = "green swimsuit"
	desc = "An oldfashioned green swimsuit."
	icon_state = "swim_green"
	siemens_coefficient = 1

/obj/item/clothing/under/swimsuit/red
	name = "red swimsuit"
	desc = "An oldfashioned red swimsuit."
	icon_state = "swim_red"
	siemens_coefficient = 1

//pyjamas
//originally intended to be pinstripes >.>

/obj/item/clothing/under/bluepyjamas
	name = "blue pyjamas"
	desc = "Slightly old-fashioned sleepwear."
	icon_state = "blue_pyjamas"
	item_state = "blue_pyjamas"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/obj/item/clothing/under/redpyjamas
	name = "red pyjamas"
	desc = "Slightly old-fashioned sleepwear."
	icon_state = "red_pyjamas"
	item_state = "red_pyjamas"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS