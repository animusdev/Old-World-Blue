/**
* DNA 2: The Spaghetti Strikes Back
*
* @author N3X15 <nexisentertainment@gmail.com>
*/

/////////////////////
// UNIQUE IDENTITY //
/////////////////////

// Create random UI.
/datum/dna/proc/ResetUI(var/defer=0)
	for(var/i=1,i<=DNA_UI_LENGTH,i++)
		switch(i)
			if(DNA_UI_SKIN_TONE)
				SetUIValueRange(DNA_UI_SKIN_TONE,rand(1,220),220,1) // Otherwise, it gets fucked
			else
				UI[i]=rand(0,4095)
	if(!defer)
		UpdateUI()

/datum/dna/proc/ResetUIFrom(var/mob/living/carbon/human/character)
	// INITIALIZE!
	ResetUI(1)
	// Hair
	// FIXME:  Species-specific defaults pls
	if(!character.h_style)
		character.h_style = "Skinhead"
	var/hair = hair_styles_list.Find(character.h_style)

	// Facial Hair
	if(!character.f_style)
		character.f_style = "Shaved"
	var/beard  = facial_hair_styles_list.Find(character.f_style)

	body_build = character.body_build.name
	age        = character.age

	var/r_part = hex2num(copytext(character.hair_color, 2, 4))
	var/g_part = hex2num(copytext(character.hair_color, 4, 6))
	var/b_part = hex2num(copytext(character.hair_color, 6, 8))

	SetUIValueRange(DNA_UI_HAIR_R,    r_part,    255,    1)
	SetUIValueRange(DNA_UI_HAIR_G,    g_part,    255,    1)
	SetUIValueRange(DNA_UI_HAIR_B,    b_part,    255,    1)

	r_part = hex2num(copytext(character.eyes_color, 2, 4))
	g_part = hex2num(copytext(character.eyes_color, 4, 6))
	b_part = hex2num(copytext(character.eyes_color, 6, 8))

	SetUIValueRange(DNA_UI_EYES_R,    r_part,    255,    1)
	SetUIValueRange(DNA_UI_EYES_G,    g_part,    255,    1)
	SetUIValueRange(DNA_UI_EYES_B,    b_part,    255,    1)

	r_part = hex2num(copytext(character.facial_color, 2, 4))
	g_part= hex2num(copytext(character.facial_color, 4, 6))
	b_part = hex2num(copytext(character.facial_color, 6, 8))

	SetUIValueRange(DNA_UI_BEARD_R,   r_part,  255,    1)
	SetUIValueRange(DNA_UI_BEARD_G,   g_part,  255,    1)
	SetUIValueRange(DNA_UI_BEARD_B,   b_part,  255,    1)

	r_part = hex2num(copytext(character.skin_color, 2, 4))
	g_part = hex2num(copytext(character.skin_color, 4, 6))
	b_part = hex2num(copytext(character.skin_color, 6, 8))

	SetUIValueRange(DNA_UI_SKIN_R,    r_part,    255,    1)
	SetUIValueRange(DNA_UI_SKIN_G,    g_part,    255,    1)
	SetUIValueRange(DNA_UI_SKIN_B,    b_part,    255,    1)

	SetUIValueRange(DNA_UI_SKIN_TONE, 35-character.s_tone, 220,    1) // Value can be negative.

	SetUIState(DNA_UI_GENDER,         character.gender!=MALE,        1)

	SetUIValueRange(DNA_UI_HAIR_STYLE,  hair,  hair_styles_list.len,       1)
	SetUIValueRange(DNA_UI_BEARD_STYLE, beard, facial_hair_styles_list.len,1)

	UpdateUI()

// Set a DNA UI block's raw value.
/datum/dna/proc/SetUIValue(var/block,var/value,var/defer=0)
	if (block<=0) return
	ASSERT(value>0)
	ASSERT(value<=4095)
	UI[block]=value
	dirtyUI=1
	if(!defer)
		UpdateUI()

// Get a DNA UI block's raw value.
/datum/dna/proc/GetUIValue(var/block)
	if (block<=0) return 0
	return UI[block]

// Set a DNA UI block's value, given a value and a max possible value.
// Used in hair and facial styles (value being the index and maxvalue being the len of the hairstyle list)
/datum/dna/proc/SetUIValueRange(var/block,var/value,var/maxvalue,var/defer=0)
	if (block<=0) return
	// FIXME: hair/beard/eye RGB values if they are 0 are not set,
	// this is a work around we'll encode it in the DNA to be 1 instead.
	if (value==0) value = 1
	ASSERT(maxvalue<=MAX_SE_VALUE)
	var/range = (MAX_SE_VALUE / maxvalue)
	if(value)
		SetUIValue(block,round(value * range),defer)

// Getter version of above.
/datum/dna/proc/GetUIValueRange(var/block,var/maxvalue)
	if (block<=0) return 0
	var/value = GetUIValue(block)
	return round(1 +(value / 4096)*maxvalue)

// Is the UI gene "on" or "off"?
// For UI, this is simply a check of if the value is > 2050.
/datum/dna/proc/GetUIState(var/block)
	if (block<=0) return
	return UI[block] > 2050


// Set UI gene "on" (1) or "off" (0)
/datum/dna/proc/SetUIState(var/block,var/on,var/defer=0)
	if (block<=0) return
	var/val
	if(on)
		val=rand(2050,MAX_SE_VALUE)
	else
		val=rand(1,2049)
	SetUIValue(block,val,defer)

// Get a hex-encoded UI block.
/datum/dna/proc/GetUIBlock(var/block)
	return EncodeDNABlock(GetUIValue(block))

// Do not use this unless you absolutely have to.
// Set a block from a hex string.  This is inefficient.  If you can, use SetUIValue().
// Used in DNA modifiers.
/datum/dna/proc/SetUIBlock(var/block,var/value,var/defer=0)
	if (block<=0) return
	return SetUIValue(block,hex2num(value),defer)

// Get a sub-block from a block.
/datum/dna/proc/GetUISubBlock(var/block,var/subBlock)
	return copytext(GetUIBlock(block),subBlock,subBlock+1)

// Do not use this unless you absolutely have to.
// Set a block from a hex string.  This is inefficient.  If you can, use SetUIValue().
// Used in DNA modifiers.
/datum/dna/proc/SetUISubBlock(var/block,var/subBlock, var/newSubBlock, var/defer=0)
	if (block<=0) return
	var/oldBlock=GetUIBlock(block)
	var/newBlock=""
	for(var/i=1, i<=length(oldBlock), i++)
		if(i==subBlock)
			newBlock+=newSubBlock
		else
			newBlock+=copytext(oldBlock,i,i+1)
	SetUIBlock(block,newBlock,defer)

/datum/dna/proc/UpdateUI()
	src.uni_identity=""
	for(var/block in UI)
		uni_identity += EncodeDNABlock(block)
	//testing("New UI: [uni_identity]")
	dirtyUI=0

