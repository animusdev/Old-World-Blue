/datum/synthesized_song
	var/name = "Title"
	var/list/lines = list()
	var/tempo = 5

	var/playing = 0
	var/autorepeat = 0

	var/obj/sound_player/player // Not a physical thing
	var/datum/instrument/instrument_data

	var/list/free_channels = list()

	var/linear_decay = 1
	var/sustain_timer = 1
	var/soft_coeff = 2.0
	var/transposition = 0

	var/octave_range_min = MUSICAL_LOWEST_OCTAVE
	var/octave_range_max = MUSICAL_HIGHEST_OCTAVE

/datum/synthesized_song/New(obj/sound_player/playing_object, datum/instrument/instrument)
	player = playing_object
	instrument_data = instrument

	instrument.create_full_sample_deviation_map()
	spawn(1)	occupy_channels()


/datum/synthesized_song/Destroy()
	..()

/datum/synthesized_song/proc/sanitize_tempo(new_tempo) // Identical to datum/song
	new_tempo = abs(new_tempo)
	return max(round(new_tempo, world.tick_lag), world.tick_lag)

/datum/synthesized_song/proc/occupy_channels()
	for (var/i=0, i<MUSICAL_CHANNELS, i++)
		if (global.free_channels.len)
			free_channel(pick_n_take(global.free_channels))

/datum/synthesized_song/proc/take_any_channel()
	return pick_n_take(free_channels)

/datum/synthesized_song/proc/free_channel(channel)
	free_channels += channel

/datum/synthesized_song/proc/play_synthesized_note(note, acc, oct, duration, where, which_one)
	if (oct < MUSICAL_LOWEST_OCTAVE || oct > MUSICAL_HIGHEST_OCTAVE)	return
	if (oct < octave_range_min || oct > octave_range_max)	return

	var/delta1 = acc == "b" ? -1 : acc == "#" ? 1 : acc == "s" ? 1 : acc == "n" ? 0 : 0
	var/delta2 = OCTAVE_START(oct)

	var/note_num = delta1+delta2+nn2no[note]
	ASSERT(note_num >= 0 && note_num <= 127)

	var/datum/sample_pair/pair = instrument_data.sample_map[n2t(note_num)]
	#define Q 0.083 // 1/12
	var/freq = 2**(Q*pair.deviation)
	var/chan = take_any_channel()
	if (!chan)
		if (!player.channel_overload())
			playing = 0
			autorepeat = 0
			return
	#undef Q
	var/list/mob/to_play_for = player.who_to_play_for()

	for (var/mob/hearer in to_play_for)
		play_for(hearer, pair.sample, duration, freq, chan, note_num, where, which_one)

/datum/synthesized_song/proc/play_for(mob/who, what, duration, frequency, channel, which, where, which_one)
	var/sound/sound_copy = sound(what)
	sound_copy.wait = 0
	sound_copy.repeat = 0
	sound_copy.frequency = frequency
	sound_copy.channel = channel
	player.apply_modifications_for(who, sound_copy, which, where, which_one)

	who << sound_copy
	#if DM_VERSION < 511
		sound_copy.frequency = 1
	#endif
	spawn(duration)
		var/delta_volume = player.volume / sustain_timer
		var/stored_soft_coeff = soft_coeff
		var/stored_linear_decay = linear_decay
		while (playing)
			sleep(1)
			if (stored_linear_decay)
				sound_copy.volume = max(sound_copy.volume - delta_volume, 0)
			else
				sound_copy.volume = max(round(sound_copy.volume / stored_soft_coeff), 0)
			if (sound_copy.volume > 0)
				sound_copy.status |= SOUND_UPDATE
				who << sound_copy
			else
				break
		free_channel(sound_copy.channel)
		who << sound(channel=sound_copy.channel, wait=0)

#define CP(L, S) copytext(L, S, S+1)
#define IS_DIGIT(L) (L >= "0" && L <= "9" ? 1 : 0)

/datum/synthesized_song/proc/play_song(mob/user)
	spawn()
		do
			var/list/cur_accidentals = list("n", "n", "n", "n", "n", "n", "n")
			var/list/cur_octaves = list(3, 3, 3, 3, 3, 3, 3)
			var/cur_line = 1
			for (var/line in lines)
				var/cur_note = 1
				for (var/notes in text2list(lowertext(line), ","))
					var/list/components = text2list(notes, "/")
					var/delta = components.len==2 && text2num(components[2]) ? text2num(components[2]) : 1
					var/duration = max(round(sanitize_tempo(tempo / delta)), 1)
					var/note_str = text2list(components[1], "-")
					if (!playing || player.shouldStopPlaying(user))
						autorepeat = 0
						playing = 0
						break
					for (var/note in note_str)
						if (!length(note) >= 1)	continue // Wtf
						var/note_sym = CP(note, 1)
						var/note_off = 0
						if (note_sym >= "c" && note_sym <= "g") note_off = text2ascii(note_sym)-98
						else if (note_sym >= "a" && note_sym <= "b") note_off = text2ascii(note_sym)-91
						else continue
						var/octave = cur_octaves[note_off]
						var/accidental = cur_accidentals[note_off]
						if (length(note) == 3)
							accidental = CP(note, 2)
							octave = CP(note, 3)
							if (!(accidental == "b" || accidental == "n" || accidental == "#" || accidental == "s"))
								continue // Break
							if (!IS_DIGIT(octave))
								continue // Break
							else
								octave = text2num(octave)
						else if (length(note) == 2)
							if (IS_DIGIT(CP(note, 2)))
								octave = text2num(CP(note, 2))
							else
								accidental = CP(note, 2)
								if (!(accidental == "b" || accidental == "n" || accidental == "#" || accidental == "s"))
									continue // Break
						cur_octaves[note_off] = octave
						cur_accidentals[note_off] = accidental
						play_synthesized_note(note_off, accidental, octave+transposition, duration, cur_line, cur_note)
					cur_note++
					sleep(duration)
				if (!playing)
					break
				cur_line++
			if (autorepeat)
				continue
			playing = 0
			break
		while (1)

#undef CP
#undef IS_DIGIT