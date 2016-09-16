#define MODIFICATION_ORGANIC 1
#define MODIFICATION_SILICON 2
#define MODIFICATION_REMOVED 3

var/global/list/body_modifications = list()
var/global/list/modifications_types = list(
	"chest" = "",  "chest2" = "", "head" = "",   "groin" = "",
	"l_arm"  = "", "r_arm"  = "", "l_hand" = "", "r_hand" = "",
	"l_leg"  = "", "r_leg"  = "", "l_foot" = "", "r_foot" = "",
	"heart"  = "", "lungs"  = "", "liver"  = "", "eyes"   = ""
)

/proc/generate_body_modification_lists()
	for(var/mod_type in typesof(/datum/body_modification))
		var/datum/body_modification/BM = new mod_type()
		if(!BM.id) continue
		body_modifications[BM.id] += BM
		for(var/part in BM.body_parts)
			modifications_types[part] += "<div onclick=\"set('body_modification', '[BM.id]');\" class='block'><b>[BM.name]</b><br>[BM.desc]</div>"

/proc/get_default_modificaton(var/nature = MODIFICATION_ORGANIC)
	if(nature == MODIFICATION_ORGANIC) return body_modifications["nothing"]
	if(nature == MODIFICATION_SILICON) return body_modifications["prosthesis_basic"]
	if(nature == MODIFICATION_REMOVED) return body_modifications["amputated"]

/datum/body_modification
	var/name = ""
	var/short_name = ""
	var/id = ""				// For savefile. Must be unique.
	var/desc = ""			// Description.
	var/list/body_parts = list("chest", "chest2", "head", "groin", "l_arm", "r_arm", "l_hand", "r_hand", "l_leg", "r_leg",\
		"l_foot", "r_foot", "heart", "lungs", "liver", "brain", "eyes")		// For sorting'n'selection optimization.
	var/allowed_species = list("Human")	// Species restriction.
	var/allow_slim_body = 1			// The "main sprite question" yeah.
	var/replace_limb = null				// To draw usual limb or not.
	var/mob_icon = ""
	var/icon/icon = 'icons/mob/human_races/body_modification.dmi'
	var/nature = MODIFICATION_ORGANIC

	proc/get_mob_icon(organ, body_build = 0, color="#ffffff", gender = MALE)	//Use in setup character only
		return new/icon('icons/mob/human.dmi', "blank")

	proc/is_allowed(var/organ = "", datum/preferences/P)
		if(!organ || !(organ in body_parts))
			usr << "[name] isn't useable for [organ_tag_to_name[organ]]"
			return 0
		if(allowed_species && !(P.species in allowed_species))
			usr << "[name] isn't allowed for [P.species]"
			return 0
		if(!allow_slim_body && (P.body_build == BODY_SLIM))
			usr << "[name] isn't allowed for slim body"
			return 0
		var/list/organ_data = organ_structure[organ]
		if(organ_data)
			var/parent_organ = organ_data["parent"]
			if(parent_organ)
				var/datum/body_modification/parent = P.get_modification(parent_organ)
				if(parent.nature > nature)
					usr << "[name] can't be attached to [parent.name]"
					return 0
		return 1

	proc/apply_to_mob(var/mob/living/carbon/human/H, var/slot)
		return 1

/datum/body_modification/nothing
	name = "Unmodified organ"
	id = "nothing"
	short_name = "nothing"
	desc = "Normal organ."
	allowed_species = null

/datum/body_modification/amputation
	name = "Amputated"
	short_name = "Amputated"
	id = "amputated"
	desc = "Organ was removed."
	body_parts = list("l_arm", "r_arm", "l_hand", "r_hand", "l_leg", "r_leg", "l_foot", "r_foot")
	replace_limb = 1
	nature = MODIFICATION_REMOVED

/datum/body_modification/tattoo
	name = "Abstract"
	short_name = "T: Abstract"
	desc = "Simple tattoo (use flavor)."
	id = "abstract"
	body_parts = list("head", "chest", "chest2", "groin", "l_arm", "r_arm",\
		"l_hand", "r_hand", "l_leg", "r_leg", "l_foot", "r_foot")
	icon = 'icons/mob/tattoo.dmi'
	mob_icon = "1"


	New()
		if(!short_name) short_name = "T: [name]"
		name = "Tattoo: [name]"

	get_mob_icon(organ, body_build = 0, color = "#ffffff")
		var/icon/I = new/icon(icon, "[organ]_[mob_icon]_[body_build]")
		I.Blend(color, ICON_ADD)
		return I

	apply_to_mob(var/mob/living/carbon/human/H, var/slot)
		var/obj/item/organ/external/E = H.organs_by_name[slot]
		if(findtext(slot, "2"))
			E.tattoo2 = mob_icon
		else
			E.tattoo = mob_icon


/datum/body_modification/tattoo/tajara_stripes
	name = "Tiger Stripes"
	short_name = "T: Tiger"
	desc = "A great camouflage to hide in long grass."
	id = "stripes"
	body_parts = list("head", "chest")
	icon = 'icons/mob/tattoo.dmi'
	mob_icon = "2"
	allowed_species = list("Tajara")

/datum/body_modification/tattoo/tribal_markings
	name = "Unathi Tribal Markings"
	short_name = "T: Tribal"
	desc = "A specific identification and beautification marks designed on the face or body."
	id = "tribal"
	body_parts = list("head", "chest")
	icon = 'icons/mob/tattoo.dmi'
	mob_icon = "2"
	allowed_species = list("Unathi")

/datum/body_modification/prosthesis
	name = "Unbranded"
	id = "prosthesis_basic"
	desc = "Simple, brutal and reliable prosthesis"
	body_parts = list("l_arm", "r_arm", "l_hand", "r_hand", \
		"l_leg", "r_leg", "l_foot", "r_foot")
	replace_limb = 1
	mob_icon = "base"
	nature = MODIFICATION_SILICON

	New()
		short_name = "P: [name]"
		name = "Prosthesis: [name]"

	get_mob_icon(organ, body_build = 0)
		return new/icon(icon, "[organ]_[mob_icon]_[body_build]")

/datum/body_modification/prosthesis/bishop
	name = "Bishop"
	id = "prosthesis_bishop"
	desc = "Prosthesis with white polymer casing with blue holo-displays."
	mob_icon = "bishop"

/datum/body_modification/prosthesis/hesphaistos
	name = "Hesphaistos"
	id = "prosthesis_hesphaistos"
	desc = "Prosthesis with militaristic black and green casing with gold stripes."

	get_mob_icon(organ, body_build = 0)
		return new/icon('icons/mob/human_races/cyberlimbs/hesphaistos.dmi', "[organ]_[body_build]")

/datum/body_modification/prosthesis/zenghu
	name = "Zeng-Hu"
	id = "prosthesis_zenghu"
	desc = "Prosthesis with rubbery fleshtone covering with visible seams."
	allow_slim_body = 0

	get_mob_icon(organ, body_build = 0)
		return new/icon('icons/mob/human_races/cyberlimbs/zenghu.dmi', "[organ]_[body_build]")

/datum/body_modification/prosthesis/xion
	name = "Xion"
	id = "prosthesis_xion"
	desc = "Prosthesis with minimalist black and red casing."

	get_mob_icon(organ, body_build = 0)
		return new/icon('icons/mob/human_races/cyberlimbs/xion.dmi', "[organ]_[body_build]")

/datum/body_modification/prosthesis/enforcer_charge
	name = "Enforcer Charge"
	id = "prosthesis_enforcer"
	allow_slim_body = 0
	mob_icon = "cyber"

/datum/body_modification/prosthesis/eyecam
	name = "Eye cam"
	id = "prosthesis_eye_cam"
	desc = "One of your eyes replaced with portable cam. Do not lose it."
	mob_icon = ""
	body_parts = list("eyes")

	get_mob_icon(organ, body_build = 0, color = "#ffffff")
		var/icon/I = new/icon(icon, "one_eye_[body_build]")
		I.Blend(color, ICON_ADD)
		return I

/datum/body_modification/mutation
	New()
		short_name = "M: [name]"
		name = "Mutation: [name]"

/datum/body_modification/mutation/exoskeleton
	name = "Exoskeleton"
	id = "mutation_exoskeleton"
	desc = "Your limb covered with bony shell (act as shield)."
	body_parts = list("head", "chest", "groin", "l_arm", "r_arm",\
		"l_hand", "r_hand", "l_leg", "r_leg", "l_foot", "r_foot")
	replace_limb = 1
	mob_icon = "exo"

	get_mob_icon(organ, body_build = 0, color="#ffffff", gender = MALE)
		if(organ in list("head", "chest", "groin"))
			return new/icon(icon, "[organ]_[mob_icon]_[gender==FEMALE?"f":"m"][body_build]")
		else
			return new/icon(icon, "[organ]_[mob_icon]_[body_build]")

/datum/body_modification/mutation/wings
	name = "Wings"
	id = "mutation_wings"
	desc = "Bird wings. Block backpack slot."
	body_parts = list("chest2")

	get_mob_icon()
		return null

/datum/body_modification/mutation/heterochromia
	name = "Heterochromia"
	id = "mutation_heterochromia"
	desc = "Special color for left eye."
	body_parts = list("eyes")

	get_mob_icon(organ, body_build = 0, color = "#ffffff")
		var/icon/I = new/icon(icon, "one_eye_[body_build]")
		I.Blend(color, ICON_ADD)
		return I

#undef MODIFICATION_REMOVED
#undef MODIFICATION_ORGANIC
#undef MODIFICATION_SILICON
