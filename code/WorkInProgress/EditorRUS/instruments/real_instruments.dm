/obj/structure/synthesized_instrument
	var/obj/sound_player/player
	var/maximum_lines = MUSICAL_MAX_LINES
	var/maximum_line_length = MUSICAL_MAX_LINE_LENGTH

	var/edit = 0
	var/help = 0

	Destroy()
		qdel(player)
		..()

	attack_hand(mob/user)
		interact(user)

	interact(mob/user) // CONDITIONS ..(user) that shit in subclasses
		user.set_machine(src)
		show_menu_for(user)

	proc/show_menu_for(mob/user) // Override this
		var/dat = "sry u r not supposd 2 c dis"
		user << browse(dat, "window=instrument")
		user.unset_machine(src)

	proc/shouldStopPlaying(mob/user)
		return 0

	proc/common_instruments_Topic(href, href_list)
		var/send_control = 1

		src.add_fingerprint(usr)

		if(href_list["newsong"])
			send_control = 0
			player.song.lines = new()
			player.song.tempo = player.song.sanitize_tempo(5) // default 120 BPM
			player.song.name = ""

		else if(href_list["import"])
			send_control = 0
			var/t = ""
			do
				t = html_encode(input(usr, "Please paste the entire song, formatted:", text("[]", name), t)  as message)
				if(!in_range(src, usr))
					return

				if(lentext(t) >= 2*maximum_lines*maximum_line_length)
					var/cont = input(usr, "Your message is too long! Would you like to continue editing it?", "", "yes") in list("yes", "no")
					if(cont == "no")
						break
			while(lentext(t) > 2*maximum_lines*maximum_line_length)

			//split into lines
			spawn()
				player.song.lines = text2list(t, "\n")
				if(copytext(player.song.lines[1],1,6) == "BPM: ")
					if(text2num(copytext(player.song.lines[1],6)) != 0)
						player.song.tempo = player.song.sanitize_tempo(600 / text2num(copytext(player.song.lines[1],6)))
						player.song.lines.Cut(1,2)
					else
						player.song.tempo = player.song.sanitize_tempo(5)
				else
					player.song.tempo = player.song.sanitize_tempo(5) // default 120 BPM
				if(player.song.lines.len > maximum_lines)
					usr << "Too many lines!"
					player.song.lines.Cut(maximum_lines+1)
				var/linenum = 1
				for(var/l in player.song.lines)
					if(lentext(l) > maximum_line_length)
						usr << "Line [linenum] too long!"
						player.song.lines.Remove(l)
					else
						linenum++
				updateDialog(usr)		// make sure updates when complete

		else if(href_list["help"])
			send_control = 0
			help = text2num(href_list["help"]) - 1

		else if(href_list["edit"])
			send_control = 0
			edit = text2num(href_list["edit"]) - 1

		else if(href_list["tempo"])
			send_control = 0
			player.song.tempo = player.song.sanitize_tempo(player.song.tempo + text2num(href_list["tempo"]))

		else if(href_list["play"])
			send_control = 0
			if (!player.song.playing)
				// Props to penot1971 for finding this potentially server-crashing bug
				// It was unintentionally and indirectly fixed by a new version, but still
				player.song.playing = 1
				spawn()
					player.song.play_song(usr)

		else if(href_list["newline"])
			send_control = 0
			var/newline = html_encode(input("Enter your line: ", src.name) as text|null)
			if(!newline || !in_range(src, usr))
				return
			if(player.song.lines.len > maximum_lines)
				return
			if(lentext(newline) > maximum_line_length)
				newline = copytext(newline, 1, maximum_line_length)
			player.song.lines.Add(newline)

		else if(href_list["deleteline"])
			send_control = 0
			var/num = round(text2num(href_list["deleteline"]))
			if(num > player.song.lines.len || num < 1)
				return
			player.song.lines.Cut(num, num+1)

		else if(href_list["modifyline"])
			send_control = 0
			var/num = round(text2num(href_list["modifyline"]),1)
			var/content = html_encode(input("Enter your line: ", src.name, player.song.lines[num]) as text|null)
			if(!content || !in_range(src, usr))
				return
			if(lentext(content) > maximum_line_length)
				content = copytext(content, 1, maximum_line_length)
			if(num > player.song.lines.len || num < 1)
				return
			player.song.lines[num] = content

		else if(href_list["stop"])
			send_control = 0
			player.song.playing = 0

		if (!send_control)
			updateDialog(usr)
		return send_control


/obj/item/device/synthesized_instrument
	var/obj/sound_player/player
	var/maximum_lines = MUSICAL_MAX_LINES
	var/maximum_line_length = MUSICAL_MAX_LINE_LENGTH

	var/edit = 0
	var/help = 0

	Del()
		del(player)
		..()

	attack_self(mob/user)
		if(!user.IsAdvancedToolUser())
			user << "<span class='warning'>You don't have the dexterity to do this!</span>"
			return 1
		interact(user)

	interact(mob/user) // CONDITIONS ..(user) that shit in subclasses
		user.set_machine(src)
		show_menu_for(user)

	proc/show_menu_for(mob/user) // Override this
		var/dat = "sry u r not supposd 2 c dis"
		user << browse(dat, "window=instrument")
		user.unset_machine(src)

	proc/shouldStopPlaying()
		return 0

	proc/common_instruments_Topic(href, href_list)
		var/send_control = 1

		src.add_fingerprint(usr)

		if(href_list["newsong"])
			send_control = 0
			player.song.lines = new()
			player.song.tempo = player.song.sanitize_tempo(5) // default 120 BPM
			player.song.name = ""

		else if(href_list["import"])
			send_control = 0
			var/t = ""
			do
				t = html_encode(input(usr, "Please paste the entire song, formatted:", text("[]", name), t)  as message)
				if(!in_range(src, usr))
					return

				if(lentext(t) >= 2*maximum_lines*maximum_line_length)
					var/cont = input(usr, "Your message is too long! Would you like to continue editing it?", "", "yes") in list("yes", "no")
					if(cont == "no")
						break
			while(lentext(t) > 2*maximum_lines*maximum_line_length)

			//split into lines
			spawn()
				player.song.lines = text2list(t, "\n")
				if(copytext(player.song.lines[1],1,6) == "BPM: ")
					if(text2num(copytext(player.song.lines[1],6)) != 0)
						player.song.tempo = player.song.sanitize_tempo(600 / text2num(copytext(player.song.lines[1],6)))
						player.song.lines.Cut(1,2)
					else
						player.song.tempo = player.song.sanitize_tempo(5)
				else
					player.song.tempo = player.song.sanitize_tempo(5) // default 120 BPM
				if(player.song.lines.len > maximum_lines)
					usr << "Too many lines!"
					player.song.lines.Cut(maximum_lines+1)
				var/linenum = 1
				for(var/l in player.song.lines)
					if(lentext(l) > maximum_line_length)
						usr << "Line [linenum] too long!"
						player.song.lines.Remove(l)
					else
						linenum++
				updateDialog(usr)		// make sure updates when complete

		else if(href_list["help"])
			send_control = 0
			help = text2num(href_list["help"]) - 1

		else if(href_list["edit"])
			send_control = 0
			edit = text2num(href_list["edit"]) - 1

		else if(href_list["tempo"])
			send_control = 0
			player.song.tempo = player.song.sanitize_tempo(player.song.tempo + text2num(href_list["tempo"]))

		else if(href_list["play"])
			send_control = 0
			if (!player.song.playing)
				// Props to penot1971 for finding this potentially server-crashing bug
				// It was unintentionally and indirectly fixed by a new version, but still
				player.song.playing = 1
				spawn()
					player.song.play_song(usr)

		else if(href_list["newline"])
			send_control = 0
			var/newline = html_encode(input("Enter your line: ", src.name) as text|null)
			if(!newline || !in_range(src, usr))
				return
			if(player.song.lines.len > maximum_lines)
				return
			if(lentext(newline) > maximum_line_length)
				newline = copytext(newline, 1, maximum_line_length)
			player.song.lines.Add(newline)

		else if(href_list["deleteline"])
			send_control = 0
			var/num = round(text2num(href_list["deleteline"]))
			if(num > player.song.lines.len || num < 1)
				return
			player.song.lines.Cut(num, num+1)

		else if(href_list["modifyline"])
			send_control = 0
			var/num = round(text2num(href_list["modifyline"]),1)
			var/content = html_encode(input("Enter your line: ", src.name, player.song.lines[num]) as text|null)
			if(!content || !in_range(src, usr))
				return
			if(lentext(content) > maximum_line_length)
				content = copytext(content, 1, maximum_line_length)
			if(num > player.song.lines.len || num < 1)
				return
			player.song.lines[num] = content

		else if(href_list["stop"])
			send_control = 0
			player.song.playing = 0

		if (!send_control)
			updateDialog(usr)
		return send_control