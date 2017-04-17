///////////////////////////////////////
// STRUCTURAL ENZYMES
///////////////////////////////////////

// "Zeroes out" all of the blocks.
/datum/dna/proc/ResetSE()
	var/datum/mutation/M = null
	for(var/block in SE)
		M = all_mutations[block]
		SetSEValue(block,rand(1,M.activation_level),1)
	UpdateSE()

// Set a DNA SE block's raw value.
/datum/dna/proc/SetSEValue(var/block,var/value,var/defer=0)
	if(!block in SE)
		return
	ASSERT(value>=0)
	ASSERT(value<=MAX_SE_VALUE)
	SE[block]=value
	dirtySE=1
	if(!defer)
		UpdateSE()

// Get a DNA SE block's raw value.
/datum/dna/proc/GetSEValue(var/block)
	if(!block in SE)
		return 0
	return SE[block]

// Set a DNA SE block's value, given a value and a max possible value.
// Might be used for species?
/datum/dna/proc/SetSEValueRange(var/block,var/value,var/maxvalue)
	if(!block in SE)
		return
	ASSERT(maxvalue<=MAX_SE_VALUE)
	var/range = round(MAX_SE_VALUE / maxvalue)
	if(value)
		SetSEValue(block, value * range - rand(1,range-1))

// Getter version of above.
/datum/dna/proc/GetSEValueRange(var/block,var/maxvalue)
	if(!block in SE)
		return 0
	var/value = GetSEValue(block)
	return round(1 +(value / 4096)*maxvalue)

// Is the block "on" (1) or "off" (0).
/datum/dna/proc/GetSEState(var/block)
	if(!block in SE)
		return 0
	var/datum/mutation/M = all_mutations[block]
	return M.get_state(SE[block])

// Set a block "on" or "off".
/datum/dna/proc/SetSEState(var/block,var/state,var/defer=0)
	if(!block in SE)
		return
	var/datum/mutation/M = all_mutations[block]
	var/value = M.pick_state_value(state)
	SetSEValue(block,value,defer)

// Get hex-encoded SE block.
/datum/dna/proc/GetSEBlock(var/block)
	return EncodeDNABlock(GetSEValue(block))

// Do not use this unless you absolutely have to.
// Set a block from a hex string.  This is inefficient.  If you can, use SetUIValue().
// Used in DNA modifiers.
/datum/dna/proc/SetSEBlock(var/block,var/value,var/defer=0)
	if(!block in SE)
		return
	var/nval=hex2num(value)
	return SetSEValue(block, nval, defer)

/datum/dna/proc/GetSESubBlock(var/block,var/subBlock)
	return copytext(GetSEBlock(block),subBlock,subBlock+1)

// Do not use this unless you absolutely have to.
// Set a sub-block from a hex character.  This is inefficient.  If you can, use SetUIValue().
// Used in DNA modifiers.
/datum/dna/proc/SetSESubBlock(var/block,var/subBlock, var/newSubBlock, var/defer=0)
	if(!block in SE)
		return

	var/oldBlock=GetSEBlock(block)
	var/newBlock=""
	for(var/i=1, i<=length(oldBlock), i++)
		if(i==subBlock)
			newBlock+=newSubBlock
		else
			newBlock+=copytext(oldBlock,i,i+1)
	SetSEBlock(block,newBlock,defer)

/datum/dna/proc/UpdateSE()
	struc_enzymes=""
	for(var/block in SE)
		struc_enzymes += EncodeDNABlock(SE[block])
	dirtySE=0

