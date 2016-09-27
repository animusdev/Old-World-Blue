/****************************************************
				EXTERNAL ORGANS
****************************************************/

/datum/organ_description/groin/arachna
	name = "abdomen"
	default_type = /obj/item/organ/external/groin/arachna


/obj/item/organ/external/groin/arachna
	name = "abdomen"
//	organ_tag = BP_GROIN
	encased = "chitin"

////////////////////LEGS////////////////
/obj/item/organ/external/leg/arachna
	max_damage = 50
	min_broken_damage = 30
	w_class = 3
	parent_organ = BP_GROIN
//	can_stand = 1
	encased = "chitin"
	dislocated = -1

/obj/item/organ/external/leg/arachna/left
	icon_position = LEFT
	body_part = LEG_LEFT

/obj/item/organ/external/leg/arachna/right
	icon_position = RIGHT
	body_part = LEG_RIGHT

//////////////front/////////////////
/obj/item/organ/external/leg/arachna/left/f_leg
	organ_tag = "l_f_leg"
	name = "left front leg"
//	body_part = LEG_LEFT //LEG_FRONT_LEFT
	amputation_point = "left front coxa"

/obj/item/organ/external/leg/arachna/right/f_leg
	organ_tag = "r_f_leg"
	name = "right front leg"
//	body_part = LEG_RIGHT //LEG_FRONT_RIGHT
	amputation_point = "right front coxa"

//////////////middle-front/////////////////
/obj/item/organ/external/leg/arachna/left/mf_leg
	organ_tag = "l_mf_leg"
	name = "left middle-front leg"
//	body_part = LEG__MIDDLE_FRONT_LEFT
	amputation_point = "left middle-front coxa"


/obj/item/organ/external/leg/arachna/right/mf_leg
	organ_tag = "r_mf_leg"
	name = "right middle-front leg"
//	body_part = LEG_MIDDLE_FRONT_RIGHT
	amputation_point = "right middle-front coxa"


//////////////middle-back/////////////////
/obj/item/organ/external/leg/arachna/left/mb_leg
	organ_tag = "l_mb_leg"
	name = "left middle-back leg"
//	body_part = LEG_MIDDLE_BACK_LEFT
	amputation_point = "left middle-back coxa"

/obj/item/organ/external/leg/arachna/right/mb_leg
	organ_tag = "r_mb_leg"
	name = "right middle-back leg"
//	body_part = LEG_MIDDLE_BACK_RIGHT
	amputation_point = "right middle-back coxa"


//////////////////back////////////////////
/obj/item/organ/external/leg/arachna/left/b_leg
	organ_tag = "l_b_leg"
	name = "left back leg"
//	body_part = LEG_BACK_LEFT
	amputation_point = "left back coxa"

/obj/item/organ/external/leg/arachna/right/b_leg
	organ_tag = "r_b_leg"
	name = "right back leg"
//	body_part = LEG_BACK_RIGHT
	amputation_point = "right back coxa"

////////////////////LEGS END////////////////

/obj/item/organ/external/foot
	min_broken_damage = 15
	w_class = 2
	can_stand = 1
	dislocated = -1
	encased = "chitin"

/obj/item/organ/external/foot/arachna/left
	icon_position = LEFT
	body_part = FOOT_LEFT

/obj/item/organ/external/foot/arachna/rignt
	icon_position = RIGHT
	body_part = FOOT_RIGHT

//////////////front/////////////////
/obj/item/organ/external/foot/arachna/left/f_foot
	organ_tag = "l_f_foot"
	name = "left front foot"
	parent_organ = "l_f_leg"
	joint = "left front patella"
	amputation_point = "left front patella"


/obj/item/organ/external/foot/arachna/right/f_foot
	organ_tag = "r_f_foot"
	name = "right front foot"
	parent_organ = "r_f_leg"
	joint = "right front patella"
	amputation_point = "right front patella"
//////////////middle-front/////////////////
/obj/item/organ/external/foot/arachna/left/mf_foot
	organ_tag = "l_mf_foot"
	name = "left middle-front foot"
	parent_organ = "l_mf_leg"
	joint = "left middle-front patella"
	amputation_point = "left middle-front patella"

/obj/item/organ/external/foot/arachna/right/mf_foot
	organ_tag = "r_mf_foot"
	name = "right middle-front foot"
	parent_organ = "r_mf_leg"
	joint = "right middle-front patella"
	amputation_point = "right middle-front patella"

//////////////middle-back/////////////////
/obj/item/organ/external/foot/arachna/left/mb_foot
	organ_tag = "l_mb_foot"
	name = "left middle-back foot"
	parent_organ = "l_mb_leg"
	joint = "left middle-back patella"
	amputation_point = "left middle-back patella"

/obj/item/organ/external/foot/arachna/right/mb_foot
	organ_tag = "r_mb_foot"
	name = "right middle-back foot"
	parent_organ = "r_mb_leg"
	joint = "right middle-back patella"
	amputation_point = "right middle-back patella"

//////////////////back////////////////////

/obj/item/organ/external/foot/arachna/left/b_foot
	organ_tag = "l_b_foot"
	name = "left back foot"
	parent_organ = "l_b_leg"
	joint = "left back patella"
	amputation_point = "left back patella"

/obj/item/organ/external/foot/arachna/right/b_foot
	organ_tag = "r_b_foot"
	name = "right back foot"
	parent_organ = "r_b_leg"
	joint = "right back patella"
	amputation_point = "right back patella"
////////////////////FOOT END////////////////