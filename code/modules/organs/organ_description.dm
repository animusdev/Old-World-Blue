/datum/organ_description
	var/name = "upper body"
	var/organ_tag = BP_CHEST
	var/default_type = /obj/item/organ/external/chest
	var/body_part = UPPER_TORSO
	var/amputation_point = "spine"
	var/joint = "neck"
	var/parent_organ = null
	var/icon_position = null
	var/can_grasp = 0
	var/can_stand = 0
	var/list/drop_on_remove = null

/datum/organ_description/groin
	name = "lower body"
	organ_tag = BP_GROIN
	default_type = /obj/item/organ/external/groin
	body_part = LOWER_TORSO
	joint = "hip"
	amputation_point = "lumbar"
	parent_organ = BP_CHEST

/datum/organ_description/head
	name = "head"
	organ_tag = BP_HEAD
	default_type = /obj/item/organ/external/head
	body_part = HEAD
	joint = "jaw"
	amputation_point = "neck"
	parent_organ = BP_CHEST
	drop_on_remove = list(slot_glasses,slot_head,slot_l_ear,slot_r_ear,slot_wear_mask)

/datum/organ_description/arm
	default_type = /obj/item/organ/external/limb
	parent_organ = BP_CHEST
	can_grasp = 1

/datum/organ_description/arm/left
	name = "left arm"
	organ_tag = BP_L_ARM
	body_part = ARM_LEFT
	joint = "left elbow"
	amputation_point = "left shoulder"

/datum/organ_description/arm/right
	name = "right arm"
	organ_tag = BP_R_ARM
	body_part = ARM_RIGHT
	joint = "right elbow"
	amputation_point = "right shoulder"

/datum/organ_description/leg
	default_type = /obj/item/organ/external/limb
	parent_organ = BP_GROIN
	can_stand = 1

/datum/organ_description/leg/left
	name = "left leg"
	organ_tag = BP_L_LEG
	body_part = LEG_LEFT
	icon_position = LEFT
	joint = "left knee"
	amputation_point = "left hip"

/datum/organ_description/leg/right
	name = "right leg"
	organ_tag = BP_R_LEG
	body_part = LEG_RIGHT
	icon_position = RIGHT
	joint = "right knee"
	amputation_point = "right hip"

/datum/organ_description/hand
	default_type = /obj/item/organ/external/tiny
	can_grasp = 1
	drop_on_remove = list(slot_gloves, slot_handcuffed)

/datum/organ_description/hand/left
	organ_tag = BP_L_HAND
	name = "left hand"
	body_part = HAND_LEFT
	parent_organ = BP_L_ARM
	joint = "left wrist"
	amputation_point = "left wrist"

/datum/organ_description/hand/right
	organ_tag = BP_R_HAND
	name = "right hand"
	body_part = HAND_RIGHT
	parent_organ = BP_R_ARM
	joint = "right wrist"
	amputation_point = "right wrist"

/datum/organ_description/foot
	default_type = /obj/item/organ/external/tiny
	can_stand = 1
	drop_on_remove = list(slot_shoes, slot_legcuffed)

/datum/organ_description/foot/left
	organ_tag = BP_L_FOOT
	name = "left foot"
	body_part = FOOT_LEFT
	icon_position = LEFT
	parent_organ = BP_L_LEG
	joint = "left ankle"
	amputation_point = "left ankle"

/datum/organ_description/foot/right
	organ_tag = BP_R_FOOT
	name = "right foot"
	body_part = FOOT_RIGHT
	icon_position = RIGHT
	parent_organ = BP_R_LEG
	joint = "right ankle"
	amputation_point = "right ankle"

////DIONA////
/datum/organ_description/diona
	name = "upper body"
	amputation_point = "branch"
	joint = "structural ligament"
	default_type = /obj/item/organ/external/diona/chest

/datum/organ_description/groin/diona
	name = "fork"
	default_type = /obj/item/organ/external/diona/groin

/datum/organ_description/head/diona
	default_type = /obj/item/organ/external/diona/head

/datum/organ_description/arm/left/diona
	name = "left upper tendril"
	default_type = /obj/item/organ/external/diona/limb

/datum/organ_description/arm/right/diona
	name = "right upper tendril"
	default_type = /obj/item/organ/external/diona/limb

/datum/organ_description/leg/left/diona
	name = "left lower tendril"
	default_type = /obj/item/organ/external/diona/limb

/datum/organ_description/leg/right/diona
	name = "right lower tendril"
	default_type = /obj/item/organ/external/diona/limb

/datum/organ_description/hand/left/diona
	name = "left grasper"
	default_type = /obj/item/organ/external/diona/tiny

/datum/organ_description/hand/right/diona
	name = "right grasper"
	default_type = /obj/item/organ/external/diona/tiny

/datum/organ_description/foot/left/diona
	default_type = /obj/item/organ/external/diona/tiny

/datum/organ_description/foot/right/diona
	default_type = /obj/item/organ/external/diona/tiny

////SLIME////
/datum/organ_description/slime
	name = "upper body"
	default_type = /obj/item/organ/external/chest/slime

/datum/organ_description/groin/slime
	name = "fork"
	default_type = /obj/item/organ/external/groin/slime

/datum/organ_description/head/slime
	default_type = /obj/item/organ/external/head/slime

/datum/organ_description/arm/left/slime
	default_type = /obj/item/organ/external/limb/slime

/datum/organ_description/arm/right/slime
	default_type = /obj/item/organ/external/limb/slime

/datum/organ_description/leg/left/slime
	default_type = /obj/item/organ/external/limb/slime

/datum/organ_description/leg/right/slime
	default_type = /obj/item/organ/external/limb/slime

/datum/organ_description/hand/left/slime
	default_type = /obj/item/organ/external/tiny/slime

/datum/organ_description/hand/right/slime
	default_type = /obj/item/organ/external/tiny/slime

/datum/organ_description/foot/left/slime
	default_type = /obj/item/organ/external/tiny/slime

/datum/organ_description/foot/right/slime
	default_type = /obj/item/organ/external/tiny/slime



