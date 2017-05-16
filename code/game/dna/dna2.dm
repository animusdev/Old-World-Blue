var/global/list/datum/dna/gene/dna_genes[0]

/////////////////
// GENE DEFINES
/////////////////

/datum/dna
	// READ-ONLY, GETS OVERWRITTEN
	// DO NOT FUCK WITH THESE OR BYOND WILL EAT YOUR FACE
	var/uni_identity=""   // Encoded UI
	var/struc_enzymes=""  // Encoded SE
	var/unique_enzymes="" // MD5 of player name

	// Internal dirtiness checks
	var/dirtyUI=0
	var/dirtySE=0

	// Okay to read, but you're an idiot if you do.
	// BLOCK = VALUE
	var/list/SE = new
	var/list/UI[DNA_UI_LENGTH]

	// From old dna.
	var/b_type = "A+"  // Should probably change to an integer => string map but I'm lazy.
	var/body_build = "Default"
	var/real_name      // Stores the real name of the person who originally got this dna datum.
	var/age = 30
	// New stuff
	var/species = SPECIES_HUMAN

// Make a copy of this strand.
// USE THIS WHEN COPYING STUFF OR YOU'LL GET CORRUPTION!
/datum/dna/proc/Clone()
	var/datum/dna/new_dna = new()
	new_dna.unique_enzymes = unique_enzymes
	new_dna.b_type = b_type
	new_dna.body_build = body_build
	new_dna.age = age
	new_dna.real_name = real_name
	new_dna.species = species
	new_dna.SE = SE.Copy()
	new_dna.UI = UI.Copy()
	new_dna.UpdateSE()
	new_dna.UpdateUI()
	return new_dna

/datum/dna/proc/set_real_name(var/new_name)
	unique_enzymes = md5(new_name)
	reg_dna[unique_enzymes] = new_name

///////////////////////////////////////
// STRUCTURAL ENZYMES
///////////////////////////////////////

/proc/EncodeDNABlock(var/value)
	return add_zero2(num2hex(value,1), 3)

// BACK-COMPAT!
//  Just checks our character has all the crap it needs.
/datum/dna/proc/check_integrity(var/mob/living/carbon/human/character)
	if(character)
		if(UI.len != DNA_UI_LENGTH)
			ResetUIFrom(character)
		if(dirtyUI || !uni_identity)
			UpdateUI()

		if(SE.len != character.species.mutations.len || length(struc_enzymes)!= 3 * SE.len)
			ResetSE()
		if(dirtySE)
			UpdateSE()

		if(length(unique_enzymes) != 32)
			unique_enzymes = md5(character.real_name)
	else
		if(length(uni_identity) != 3 * DNA_UI_LENGTH)
			uni_identity = "00600200A00E0110148FC01300B0095BD7FD3F4"
		if(length(struc_enzymes)!= 3 * SE.len)
			struc_enzymes = "43359156756131E13763334D1C369012032164D4FE4CD61544B6C03F251B6C60A42821D26BA3B0FD6"

// BACK-COMPAT!
//  Initial DNA setup.  I'm kind of wondering why the hell this doesn't just call the above.
/datum/dna/proc/ready_dna(mob/living/carbon/human/character)
	ResetUIFrom(character)

	ResetSE()

	set_real_name(character.real_name)