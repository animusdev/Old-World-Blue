/obj/effect/blob/core
	name = "blob core"
	icon = 'icons/mob/blob.dmi'
	icon_state = "blob_core"
	health = 200
	brute_resist = 2
	fire_resist = 2


	New(loc, var/h = 200)
		blobs += src
		blob_cores += src
		processing_objects.Add(src)
		..(loc, h)


	Destroy()
		blob_cores -= src
		processing_objects.Remove(src)
		..()
		return


	update_icon()
		if(health <= 0)
			playsound(src.loc, 'sound/effects/splat.ogg', 50, 1)
			qdel(src)
			return
		return


	run_action()
		Pulse(0,1)
		Pulse(0,2)
		Pulse(0,4)
		Pulse(0,8)
		//Should have the fragments in here somewhere
		return 1


	proc/create_fragments(var/wave_size = 1)
		var/list/candidates = list()
		for(var/mob/observer/dead/G in player_list)
			if(ROLE_ALIEN in G.client.prefs.special_toggles)
				if(!(G.mind && G.mind.current && G.mind.current.stat != DEAD))
					candidates += G.key

		if(candidates.len)
			for(var/i = 0 to wave_size)
				var/mob/living/blob/B = new/mob/living/blob(src.loc)
				B.key = pick(candidates)
				candidates -= B.key