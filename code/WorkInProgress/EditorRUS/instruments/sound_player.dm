/obj/sound_player
	// Virtual object
	// It's the one used to modify shit
	var/range = 15
	var/volume = 100
	var/volume_falloff_exponent = 1.3
	var/forced_sound_in = 0
	var/falloff = 5
	var/three_dimensional_sound = 1

	var/datum/synthesized_song/song
	var/datum/instrument/instrument
	var/obj/actual_instrument

	New(obj/where, datum/instrument/what)
		song = new (src, what)
		actual_instrument = where
		src.loc = where

	Destroy()
		song.playing = 0
		sleep(1)
		for (var/channel in song.free_channels)
			global.free_channels += channel // Deoccupy channels
		qdel(song)
		..()

/obj/sound_player/proc/apply_modifications_for(mob/who, sound/what, note_num, which_line, which_note) // You don't need to override this
	what.volume = volume - volume*(min(get_dist(src, who)+1, range)/range)**volume_falloff_exponent
	if (three_dimensional_sound)
		what.falloff = falloff
		var/turf/source = get_turf(src)
		var/turf/receiver = get_turf(who)
		var/dx = source.x - receiver.x // Hearing from the right/left
		what.x = round(max(-SURROUND_CAP, min(SURROUND_CAP, dx)), 1)

		var/dz = source.y - receiver.y // Hearing from infront/behind
		what.z = round(max(-SURROUND_CAP, min(SURROUND_CAP, dz)), 1)
	return

/obj/sound_player/proc/who_to_play_for() // Find suitable mobs to annoy with music
	var/mob/eligible_mobs = list()
	for (var/mob/some_hearer in hearers(src, null))
		if (!(some_hearer.client && some_hearer.mind))
			continue
		var/dist = get_dist(some_hearer, src)
		if (dist > forced_sound_in)
			continue
		eligible_mobs += some_hearer
	return eligible_mobs

/obj/sound_player/proc/shouldStopPlaying(mob/user)
	return actual_instrument:shouldStopPlaying(user)

/obj/sound_player/proc/channel_overload()
	// Cease playing
	return 0