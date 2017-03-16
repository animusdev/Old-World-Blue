/obj/sound_player/synthesizer
	forced_sound_in = 4
	var/list/datum/music_code/code = list()

	apply_modifications_for(mob/who, sound/what, which, where, which_one)
		..(who, what, which)
		for (var/datum/music_code/cond in code)
			if (cond.test(which, where, which_one))
				var/datum/sample_pair/pair = cond.instrument.sample_map[n2t(which)]
				what.file = pair.sample


#define LESSER 1
#define EQUAL 2
#define GREATER 3
#define COMPARE(alpha, beta) ((alpha)<(beta) ? LESSER : (alpha)==(beta) ? EQUAL : GREATER)

/datum/music_code
	var/octave = null
	var/octave_condition = null
	var/line_num = null
	var/line_condition = null
	var/line_note_num = null
	var/line_note_condition = null
	var/datum/instrument/instrument = null

	proc/test(note_num, line_num, line_note_num)
		var/result = 1
		if (src.octave!=null && src.octave_condition)
			var/cur_octave = round(note_num * 0.083)
			if (COMPARE(cur_octave, octave) != octave_condition)
				result = 0
		if (src.line_num && src.line_condition)
			if (COMPARE(line_num, src.line_num) != line_condition)
				result = 0
		if (src.line_note_num && src.line_note_condition)
			if (COMPARE(line_num, src.line_note_num) != line_note_condition)
				result = 0
		return result

	proc/octave_code()
		if (src.octave!=null)
			var/sym = (octave_condition==LESSER ? "<" :
			           octave_condition==EQUAL ? "=" :
			           octave_condition==GREATER ? ">" : null)
			return "O[sym][octave]"
		return ""

	proc/line_num_code()
		if (src.line_num)
			var/sym = (line_condition==LESSER ? "<" :
			           line_condition==EQUAL ? "=" :
			           line_condition==GREATER ? ">" : null)
			return "L[sym][line_num]"
		return ""

	proc/line_note_num_code()
		if (src.line_note_num)
			var/sym = (line_note_condition==LESSER ? "<" :
			           line_note_condition==EQUAL ? "=" :
			           line_note_condition==GREATER ? ">" : null)
			return "N[sym][line_note_num]"
		return ""



#undef LESSER
#undef EQUAL
#undef GREATER
#undef COMPARE

/obj/structure/synthesized_instrument/synthesizer
	name = "The Synthesizer 2.2"
	desc = "This thing is an unholy abomination from the depths of a hell they call <font color='red'>\"Brig\"</font>. The demons in red play this to torture the soul of whoever is damned to this place.<br>This particular version was recovered from the Clown Planet<br>"
	icon = 'synthesizer.dmi'
	icon_state = "synthesizer"
	anchored = 1
	density = 1
	var/datum/instrument/instruments = list()
	var/coding = 0
	var/showing_ids = 0
	var/coding_help = 1

	New()
		..()
		for (var/type in typesof(/datum/instrument))
			var/datum/instrument/new_instrument = new type
			if (!new_instrument.id) continue
			new_instrument.create_full_sample_deviation_map()
			instruments[new_instrument.name] = new_instrument
		player = new /obj/sound_player/synthesizer (src, instruments[pick(instruments)])

	attackby(obj/item/O, mob/user, params)
		if (istype(O, /obj/item/weapon/wrench))
			if (!anchored && !isinspace())
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				user << "<span class='notice'> You begin to tighten \the [src] to the floor...</span>"
				if (do_after(user, 20))
					user.visible_message( \
						"[user] tightens \the [src]'s casters.", \
						"<span class='notice'> You tighten \the [src]'s casters. Now it can be played again.</span>", \
						"<span class='italics'>You hear ratchet.</span>")
					anchored = 1
			else if(anchored)
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				user << "<span class='notice'> You begin to loosen \the [src]'s casters...</span>"
				if (do_after(user, 40))
					user.visible_message( \
						"[user] loosens \the [src]'s casters.", \
						"<span class='notice'> You loosen \the [src]. Now it can be pulled somewhere else.</span>", \
						"<span class='italics'>You hear ratchet.</span>")
					anchored = 0
		else
			..()

	proc/compose_code(var/html=0)
		var/code = ""
		var/line_number = 1
		if (src.player:code:len)
			// Find instruments involved and create a list of statements
			var/list/list/datum/music_code/statements = list() // Instruments involved
			for (var/datum/music_code/this_code in src.player:code)
				if (statements[this_code.instrument.id])
					statements[this_code.instrument.id] += this_code
				else
					statements[this_code.instrument.id] = list(this_code)

			// Each instrument statement is split by ;\n or ;<br> in this case
			// Each statement is in parenthesises and separated by |
			// Statements have up to 3 conditions separated by &

			for (var/instrument_id in statements)
				var/conditions = ""
				for (var/datum/music_code/cond in statements[instrument_id])
					var/sub_code = "("
					var/octave_code = cond.octave_code()
					var/line_code = cond.line_num_code()
					var/line_note_code = cond.line_note_num_code()
					sub_code += octave_code ? octave_code+"|" : ""
					sub_code += line_code ? line_code + "|" : ""
					sub_code += line_note_code
					sub_code = copytext(sub_code, 1, -1)
					sub_code += ")"
					conditions = sub_code + " & "
				conditions = copytext(conditions, 1, -3)
				code = code + (html ? "[line_number]: " : "") + conditions + " -> " + (instrument_id + (html ? "<br>" : "\n"))
				line_number++
		return code

	proc/decompose_code(code, mob/blame)
		if (length(code) > 10000)
			blame << "This code is WAAAAY too long."
			return
		code = replacetext(code, " ", "")
		code = replacetext(code, "(", "")
		code = replacetext(code, ")", "")

		var/list/instruments_ids = list()
		var/list/datum/instrument/instruments_by_id = list()
		for (var/ins in instruments)
			var/datum/instrument/instr = instruments[ins]
			instruments_by_id[instr.id] = instr
			instruments_ids += instr.id

		var/line = 1
		var/list/datum/music_code/conditions = list()
		for (var/super_statement in text2list(code, "\n"))
			var/list/delta = text2list(super_statement, "->")
			if (delta.len==0)
				blame << "Line [line]: Empty super statement"
				return
			if (delta.len==1)
				blame << "Line [line]: Not enough parameters in super statement"
				return
			if (delta.len>2)
				blame << "Line [line]: Too many parameters in super statement"
				return
			var/id = delta[2]
			if (!(id in instruments_ids))
				blame << "Line [line]: Unknown ID. [id]"
				return

			for (var/statements in text2list(delta[1], "|"))
				var/datum/music_code/new_condition = new

				for (var/property in text2list(statements, "&"))
					if (length(property) < 3)
						blame << "Line [line]: Invalid property [property]"
						return
					var/variable = copytext(property, 1, 2)
					if (variable != "O" && variable != "N" && variable != "L")
						blame << "Line [line]: Unknown variable [variable] in [property]"
						return
					var/operator = copytext(property, 2, 3)
					if (operator != "<" && operator != ">" && operator != "=")
						blame << "Line [line]: Unknown operator [operator] in [property]"
						return
					var/list/que = text2list(property, operator)
					var/value = que[2]
					operator = operator=="<" ? 1 : operator=="=" ? 2 : 3
					if (num2text(text2num(value)) != value)
						blame << "Line [line]: Invalid value [value] in [property]"
						return
					value = text2num(value)
					switch(variable)
						if ("O")
							new_condition.octave = value
							new_condition.octave_condition = operator
						if ("N")
							new_condition.line_note_num = value
							new_condition.line_note_condition = operator
						if ("L")
							new_condition.line_num = value
							new_condition.line_condition = operator
				new_condition.instrument = instruments_by_id[id]
				conditions += new_condition
			line++
		src.player:code = conditions



	show_menu_for(mob/user)
		var/dat = ""

		if (player.song.lines.len > 0)
			dat += "<H3>Playback</H3>"
			if(!player.song.playing)
				dat += "<A href='?src=\ref[src];play=1'>Play</A> <SPAN CLASS='linkOn'>Stop</SPAN><BR>"
			else
				dat += "<SPAN CLASS='linkOn'>Play</SPAN> <A href='?src=\ref[src];stop=1'>Stop</A><BR>"
			dat += "<A href='?src=\ref[src];autorepeat=1'>[player.song.autorepeat ? "Disable autoplay" : "Enable autoplay"]</A><BR>"
		dat += "Current instrument: <A href='?src=\ref[src];change_instrument=1'>[player.song.instrument_data.name]</A><BR>"
		dat += "Volume: "
		dat += "<A href='?src=\ref[src];change_vol=-10'>-10</A> "
		dat += "<A href='?src=\ref[src];change_vol=-1'>-1</A> "
		dat += num2text(player.volume)
		dat += "<A href='?src=\ref[src];change_vol=1'>1</A> "
		dat += "<A href='?src=\ref[src];change_vol=10'>10</A> "
		dat += "<BR>"
		dat += "Transpose by octave: <A href='?src=\ref[src];transpose=-1'>-</A> [player.song.transposition] <A href='?src=\ref[src];transpose=1'>+</A><BR>"
		dat += "Octave range: "
		dat += "<A href='?src=\ref[src];change_min_octave=-1'>-</A> [player.song.octave_range_min]</A> <A href='?src=\ref[src];change_min_octave=1'>+</A> "
		dat += "<A href='?src=\ref[src];change_max_octave=-1'>-</A> [player.song.octave_range_max]</A> <A href='?src=\ref[src];change_max_octave=1'>+</A><BR>"
		dat += "<A href='?src=\ref[src];3d_sound=1'>[player.three_dimensional_sound ? "Disable 3D" : "Enable 3D"]</A><BR>"
		if (player.song.linear_decay)
			dat += "Sustain pedal timer: "
			dat += "<A href='?src=\ref[src];sustain_change=-10'>-10</A> "
			dat += "<A href='?src=\ref[src];sustain_change=-1'>-1</A> "
			dat += num2text(player.song.sustain_timer)
			dat += "<A href='?src=\ref[src];sustain_change=1'>1</A> "
			dat += "<A href='?src=\ref[src];sustain_change=10'>10</A> "
			dat += "<BR>"
		else
			dat += "Soft coefficient: [player.song.soft_coeff] <A href='?src=\ref[src];soft_change=1'>Change coefficient</A><BR>"
		dat += "<A href='?src=\ref[src];toggle_decay=1'>[!player.song.linear_decay ? "Exponential decay" : "Linear decay"]</A><BR>"

		if(!edit)
			dat += "<BR><B><A href='?src=\ref[src];edit=2'>Show Editor</A></B><BR>"
		else
			dat += "<H3>Editing</H3>"
			dat += "<B><A href='?src=\ref[src];edit=1'>Hide Editor</A></B>"
			dat += " <A href='?src=\ref[src];newsong=1'>Start a New Song</A>"
			dat += " <A href='?src=\ref[src];import=1'>Import a Song</A><BR><BR>"
			var/bpm = round(600 / player.song.tempo)
			dat += "Tempo: <A href='?src=\ref[src];tempo=[world.tick_lag]'>-</A> [bpm] BPM <A href='?src=\ref[src];tempo=-[world.tick_lag]'>+</A><BR><BR>"
			var/linecount = 0
			for(var/line in player.song.lines)
				linecount += 1
				dat += "Line [linecount]: <A href='?src=\ref[src];modifyline=[linecount]'>Edit</A> <A href='?src=\ref[src];deleteline=[linecount]'>X</A> [line]<BR>"
			dat += "<A href='?src=\ref[src];newline=1'>Add Line</A><BR><BR>"

			dat += "<A href='?src=\ref[src];code=1'>[!coding ? "Show Music Code" : "Hide Music Code"]</A><BR>"
			dat += "<A href='?src=\ref[src];code_help=1'>[!coding_help ? "Show Music Code help" : "Hide Music Code help"]</A><BR>"
			if (coding_help)
				dat += "Each statement-instrument pair consists of \[statement\] -> \[instrument ID\] delimited by newline<br>"
				dat += "Each statement defines conditions to be met to switch this note's sample to defined instrument's sample set.<br>"
				dat += "Each condition is delimited by logical OR written as |.<br>"
				dat += "Each condition can be enclosed in parenthesises<br>"
				dat += "Each condition is a set of properties.<br>"
				dat += "Each property has 3 arguments: symbolic variable, operator and value.<br>"
				dat += "Symbolic variable must be either O, L or N.<br>"
				dat += "O is octave, L is line number, N is note number inside a line.<br>"
				dat += html_encode("Logical operators allowed: <, =, >")+"<br>"
				dat += "Current value defined by symbolic variable is tested against some value according to defined operator.<br>"
				dat += "Each property must be delimited by &<br>"
				dat += "For example:<br>"
				dat += html_encode("(O<3&L>5&N=10) | (N<10&L<10) -> guitar")+"<br>"
				dat += "Means \"Use an instrument with the ID \"guitar\" after 5th line on each 10th note if its octave is less than three<br>OR if it is before 10th line and appears before 10th note in this line<br><br>"

			dat += coding ? compose_code(html=1) : ""
			dat += coding ? "<A href='?src=\ref[src];edit_code=1'>Edit code</A><BR>" : ""
			dat += coding ? "<A href='?src=\ref[src];ids=1'>[showing_ids ? "Hide IDs" : "Show IDs"]</A><BR>" : ""
			if (showing_ids)
				for (var/ins in instruments)
					var/datum/instrument/instr = instruments[ins]
					dat += "[instr.name] <=> [instr.id]<BR>"

			if(help)
				dat += "<B><A href='?src=\ref[src];help=1'>Hide Help</A></B><BR>"
				dat += {"
						Lines are a series of chords, separated by commas (,), each with notes seperated by hyphens (-).<br>
						Every note in a chord will play together, with chord timed by the tempo.<br>
						<br>
						Notes are played by the names of the note, and optionally, the accidental, and/or the octave number.<br>
						By default, every note is natural and in octave 3. Defining otherwise is remembered for each note.<br>
						Example: <i>C,D,E,F,G,A,B</i> will play a C major scale.<br>
						After a note has an accidental placed, it will be remembered: <i>C,C4,C,C3</i> is C3,C4,C4,C3</i><br>
						Chords can be played simply by seperating each note with a hyphon: <i>A-C#,Cn-E,E-G#,Gn-B</i><br>
						A pause may be denoted by an empty chord: <i>C,E,,C,G</i><br>
						To make a chord be a different time, end it with /x, where the chord length will be length<br>
						defined by tempo / x: <i>C,G/2,E/4</i><br>
						Combined, an example is: <i>E-E4/4,F#/2,G#/8,B/8,E3-E4/4</i>
						<br>
						Lines may be up to 50 characters.<br>
						A song may only contain up to 200 lines.<br>
						"}
			else
				dat += "<B><A href='?src=\ref[src];help=2'>Show Help</A></B><BR>"

		var/datum/browser/popup = new(user, "instrument", name, 700, 500)
		popup.set_content(dat)
		popup.set_title_image(user.browse_rsc_icon(icon, icon_state))
		popup.open()

	Topic(href, href_list)
		if (!common_instruments_Topic(href, href_list))
			return

		if (href_list["autorepeat"])
			player.song.autorepeat = !player.song.autorepeat

		if (href_list["change_instrument"])
			var/list/categories = list()
			for (var/key in instruments)
				var/datum/instrument/instrument = instruments[key]
				categories |= instrument.category

			var/category = input(usr, "Choose a category") in categories as text|null
			var/list/instruments_available = list()
			for (var/key in instruments)
				var/datum/instrument/instrument = instruments[key]
				if (instrument.category == category)
					instruments_available += key

			var/new_instrument = input(usr, "Choose an instrument") in instruments_available as text|null
			if (new_instrument)
				player.song.instrument_data = instruments[new_instrument]

		if (href_list["change_vol"])
			player.volume = max(min(player.volume+text2num(href_list["change_vol"]), 100), 0)

		if (href_list["transpose"])
			var/delta = text2num(href_list["transpose"])
			player.song.transposition = max(min(player.song.transposition+delta, MUSICAL_HIGHEST_TRANSPOSE), MUSICAL_LOWEST_TRANSPOSE)

		if (href_list["change_min_octave"])
			var/delta = text2num(href_list["change_min_octave"])
			player.song.octave_range_min = max(min(player.song.octave_range_min+delta, MUSICAL_HIGHEST_OCTAVE), MUSICAL_LOWEST_OCTAVE)
			player.song.octave_range_max = max(player.song.octave_range_max, player.song.octave_range_min)

		if (href_list["change_max_octave"])
			var/delta = text2num(href_list["change_max_octave"])
			player.song.octave_range_max = max(min(player.song.octave_range_max+delta, MUSICAL_HIGHEST_OCTAVE), MUSICAL_LOWEST_OCTAVE)
			player.song.octave_range_min = min(player.song.octave_range_max, player.song.octave_range_min)

		if (href_list["3d_sound"])
			player.three_dimensional_sound = !player.three_dimensional_sound

		if (href_list["sustain_change"])
			var/delta = text2num(href_list["sustain_change"])
			player.song.sustain_timer = max(min(player.song.sustain_timer+delta, MUSICAL_LONGEST_TIMER), 1)

		if (href_list["soft_change"])
			var/new_coeff = input(usr, "from [MUSICAL_SOFTEST_DROP] to [MUSICAL_HARDEST_DROP]") as num
			if (new_coeff < MUSICAL_SOFTEST_DROP)
				return
			if (new_coeff > MUSICAL_HARDEST_DROP)
				return
			player.song.soft_coeff = new_coeff

		if (href_list["toggle_decay"])
			player.song.linear_decay = !player.song.linear_decay

		if (href_list["code"])
			coding = !coding

		if (href_list["ids"])
			showing_ids = !showing_ids

		if (href_list["code_help"])
			coding_help = !coding_help

		if (href_list["edit_code"])
			var/new_code = input(usr, "Program code", "Coding", compose_code()) as message
			decompose_code(new_code, usr)

		updateDialog(usr)
		return

	shouldStopPlaying(mob/user)
		if (src)
			if (player.song.autorepeat)
				return 0
			if (!anchored)
				return 1
			return 0
		return 1