/datum/instrument
	var/name = "Generic instrument" // Name of the instrument
	var/id = null	 				// Used everywhere to distinguish between categories and actual data and to identify instruments
	var/category = null				// Used to categorize instruments
	var/list/samples = list()		// Write here however many samples, follow this syntax: "%note num%"='%sample file%' eg. "27"='synthesizer/e2.ogg'. Key must never be lower than 0 and higher than 127
	var/list/datum/sample_pair/sample_map = list() // Used to modulate sounds, don't fill yourself


/datum/instrument/proc/create_full_sample_deviation_map()
	// Obtain samples
	if (!samples.len)
		CRASH("No samples were defined in [src.type]")

	var/list/delta_1 = list()
	for (var/key in samples)	delta_1 += text2num(key)
	sortTim(delta_1, associative=0)

	for (var/indx1=1, indx1<=length(delta_1)-1, indx1++)
		var/from_key = delta_1[indx1]
		var/to_key   = delta_1[indx1+1]
		var/sample1  = samples[n2t(from_key)]
		var/sample2  = samples[n2t(to_key)]
		var/pivot    = round((from_key+to_key)/2)
		for (var/key = from_key, key<=pivot, key++)	sample_map[n2t(key)] = new /datum/sample_pair(sample1, key-from_key) // [55+56] / 2 -> 55.5 -> 55 so no changes will occur
		for (var/key = pivot+1, key<=to_key, key++)	sample_map[n2t(key)] = new /datum/sample_pair(sample2, key-to_key)

	// Fill in 0 -- first key and last key -- 127
	var/first_key = delta_1[1]
	var/last_key  = delta_1[delta_1.len]
	var/first_sample = samples[n2t(first_key)]
	var/last_sample = samples[n2t(last_key)]
	for (var/key=0, key<first_key, key++)	sample_map[n2t(key)] = new /datum/sample_pair(first_sample, key-first_key)
	for (var/key=last_key, key<=127, key++)	sample_map[n2t(key)] = new /datum/sample_pair(last_sample,  key-last_key)
	return samples