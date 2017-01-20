/*
 * Science
 */
/obj/item/clothing/under/rank/research_director
	desc = "It's a jumpsuit worn by those with the know-how to achieve the position of \"Research Director\". Its fabric provides minor protection from biological contaminants."
	name = "research director's jumpsuit"
	icon_state = "director"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/research_director/alt
	desc = "A dress suit and slacks stained with hard work and dedication to science. Perhaps other things as well, but mostly hard work and dedication."
	name = "head researcher uniform"
	icon_state = "rdalt"
	item_state = "director"

/obj/item/clothing/under/rank/research_director/skirt
	name = "research director dress uniform"
	desc = "Feminine fashion for the style concious RD. Its fabric provides minor protection from biological contaminants."
	icon_state = "dress_rd"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/scientist
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has markings that denote the wearer as a scientist."
	name = "scientist's jumpsuit"
	icon_state = "science"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/under/rank/scientist/skirt
	name = "scientist's jumpskirt"
	icon_state = "sciencef"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/scientist/jeans
	desc = "Simple blue jeans paired with white skirt. It has purple stripes on it's shoulders. Neat."
	name = "scientist's jeans uniform"
	icon_state = "sciencej"
	item_state = "w_suit"

/obj/item/clothing/under/rank/scientist/jeans/female
	icon_state = "sciencejf"


/obj/item/clothing/under/rank/xenoarch
	desc = "It's made of a special fiber that provides minor protection against radiation. It has markings that denote the wearer as a xenoarcheologist."
	name = "xenoarcheologist's jumpsuit"
	icon_state = "xenoarch"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 10)

/obj/item/clothing/under/rank/plasmares
	desc = "It's made of a special fiber that provides minor protection against bombs. It has markings that denote the wearer as a phoron researcher."
	name = "phoron researcher's jumpsuit"
	icon_state = "plasmares"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/under/rank/xenobio
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has markings that denote the wearer as a xenobiologist."
	name = "xenobiologist's jumpsuit"
	icon_state = "xenobio"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/anomalist
	desc = "It's made of a special fiber that provides minor protection against radiation. It has markings that denote the wearer as an anomalist."
	name = "anomalist's jumpsuit"
	icon_state = "anomalist"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 10)

/obj/item/clothing/under/rank/chemist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a chemist rank stripe on it."
	name = "chemist's jumpsuit"
	icon_state = "chemistry"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/chemist/skirt
	name = "chemist's jumpskirt"
	icon_state = "chemistryf"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/chemist/jeans
	desc = "Simple blue jeans paired with white skirt. It has orange stripes on it's shoulders. Neat."
	name = "chemist's jeans uniform"
	icon_state = "chemistryj"
	item_state = "w_suit"

/obj/item/clothing/under/rank/chemist/jeans/female
	icon_state = "chemistryjf"

/obj/item/clothing/under/rank/pharma
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a pharmacist rank stripe on it."
	name = "pharmacist's jumpsuit"
	icon_state = "pharma"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)


/*
 * Medical
 */
/obj/item/clothing/under/rank/chief_medical_officer
	desc = "It's a jumpsuit worn by those with the experience to be \"Chief Medical Officer\". It provides minor biological protection."
	name = "chief medical officer's jumpsuit"
	icon_state = "cmo"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/chief_medical_officer/skirt
	desc = "It's a jumpskirt worn by those with the experience to be \"Chief Medical Officer\". It provides minor biological protection."
	name = "chief medical officer's jumpskirt"
	icon_state = "cmof"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/chief_medical_officer/jeans
	desc = "Simple blue jeans paired with white skirt. It has light-blue stripes on it's shoulders. Neat."
	name = "chief medical officer's jeans uniform"
	icon_state = "cmoj"

/obj/item/clothing/under/rank/chief_medical_officer/jeans/female
	icon_state = "cmojf"

/obj/item/clothing/under/rank/geneticist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a genetics rank stripe on it."
	name = "geneticist's jumpsuit"
	icon_state = "genetics"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/geneticist/skirt
	name = "geneticist's jumpskirt"
	icon_state = "geneticsf"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/geneticist/jeans
	desc = "Simple blue jeans paired with white skirt. It has a genetics rank stripe on it's shoulders. Neat."
	name = "geneticist's jeans uniform"
	icon_state = "geneticsj"

/obj/item/clothing/under/rank/geneticist/jeans/female
	icon_state = "geneticsjf"

/obj/item/clothing/under/rank/virologist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a virologist rank stripe on it."
	name = "virologist's jumpsuit"
	icon_state = "virology"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/virologist/skirt
	name = "virologist's jumpskirt"
	icon_state = "virologyf"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/virologist/jeans
	desc = "Simple blue jeans paired with white skirt. It has a virologist rank stripe on it's shoulders. Neat."
	name = "virologist's jeans uniform"
	icon_state = "virologyj"

/obj/item/clothing/under/rank/virologist/jeans/female
	icon_state = "virologyjf"

/obj/item/clothing/under/rank/nursesuit
	desc = "It's a jumpsuit commonly worn by nursing staff in the medical department."
	name = "nurse's suit"
	icon_state = "nursesuit"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/nurse
	desc = "A dress commonly worn by the nursing staff in the medical department."
	name = "nurse's dress"
	icon_state = "nurse"
	item_state = "nursesuit"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/orderly
	desc = "A white suit to be worn by medical attendants."
	name = "orderly's uniform"
	icon_state = "orderly"
	item_state = "nursesuit"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/medical
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a cross on the chest denoting that the wearer is trained medical personnel."
	name = "medical doctor's jumpsuit"
	icon_state = "medical"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/medical/skirt
	name = "medical doctor's jumpskirt"
	icon_state = "medicalf"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/medical/jeans
	desc = "Simple blue jeans paired with white skirt. It has green cross, drawn on it's chest. Neat."
	name = "medical doctor's jeans uniform"
	icon_state = "medicalj"
	item_state = "w_suit"

/obj/item/clothing/under/rank/medical/jeans/female
	icon_state = "medicaljf"

/obj/item/clothing/under/rank/medical/sleeveless
	name = "short sleeve medical jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one has a cross on the chest denoting that the wearer is trained medical personnel."
	icon_state = "medical_short"
	item_state = "white"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/under/rank/medical/sleeveless/New()
	..()
	verbs -= /obj/item/clothing/under/verb/rollsleeves

/obj/item/clothing/under/rank/medical/sleeveless/paramedic
	name = "EMS medical jumpsuit"
	icon_state = "paramedic_dark"
	item_state = "bl_suit"

/obj/item/clothing/under/rank/medical/sleeveless/blue
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in baby blue."
	icon_state = "scrubsblue"
	item_state = "blue"

/obj/item/clothing/under/rank/medical/sleeveless/green
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in dark green."
	icon_state = "scrubsgreen"
	item_state = "green"

/obj/item/clothing/under/rank/medical/sleeveless/purple
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in deep purple."
	icon_state = "scrubspurple"
	item_state = "purple"

/obj/item/clothing/under/rank/medical/sleeveless/black
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in black."
	icon_state = "scrubsblack"
	item_state = "black"

/obj/item/clothing/under/rank/medical/sleeveless/navyblue
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in navy blue."
	icon_state = "scrubsnavyblue"
	item_state = "blue"

/obj/item/clothing/under/rank/psych
	desc = "A basic white jumpsuit. It has turqouise markings that denote the wearer as a psychiatrist."
	name = "psychiatrist's jumpsuit"
	icon_state = "psych"
	item_state = "white"

/obj/item/clothing/under/rank/psych/turtleneck
	desc = "A turqouise turtleneck and a pair of dark blue slacks, belonging to a psychologist."
	name = "psychologist's turtleneck"
	icon_state = "psychturtle"
	item_state = "psyche"

/*
 * Medsci, unused (i think) stuff
 */
/obj/item/clothing/under/rank/geneticist_new
	desc = "It's made of a special fiber which provides minor protection against biohazards."
	name = "geneticist's jumpsuit"
	icon_state = "geneticist_new"
	item_state = "white"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/chemist_new
	desc = "It's made of a special fiber which provides minor protection against biohazards."
	name = "chemist's jumpsuit"
	icon_state = "chemist_new"
	item_state = "r_suit"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/rank/scientist_new
	desc = "Made of a special fiber that gives special protection against biohazards and small explosions."
	name = "scientist's jumpsuit"
	icon_state = "scientist_new"
	item_state = "p_suit"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/under/rank/virologist_new
	desc = "Made of a special fiber that gives increased protection against biohazards."
	name = "virologist's jumpsuit"
	icon_state = "virologist_new"
	item_state = "g_suit"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)