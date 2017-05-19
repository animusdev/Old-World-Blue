// Pretty much everything here is stolen from the dna scanner FYI


/obj/machinery/bodyscanner
	var/mob/living/carbon/occupant
	var/locked
	name = "Body Scanner"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "body_scanner_0"
	dir = WEST
	density = 1
	anchored = 1

	use_power = 1
	idle_power_usage = 60
	active_power_usage = 10000	//10 kW. It's a big all-body scanner.

/obj/machinery/bodyscanner/relaymove(mob/user as mob)
	if (user.stat)
		return
	src.go_out()
	return

/obj/machinery/bodyscanner/verb/eject()
	set src in oview(1)
	set category = "Object"
	set name = "Eject Body Scanner"

	if (usr.stat != 0)
		return
	src.go_out()
	add_fingerprint(usr)
	return

/obj/machinery/bodyscanner/verb/move_inside()
	set src in oview(1)
	set category = "Object"
	set name = "Enter Body Scanner"

	if (usr.stat)
		return
	if (src.occupant)
		usr << "\blue <B>The scanner is already occupied!</B>"
		return
	if (usr.abiotic())
		usr << "\blue <B>Subject cannot have abiotic items on.</B>"
		return
	set_occupant(usr)
	src.add_fingerprint(usr)
	return

/obj/machinery/bodyscanner/proc/go_out()
	if (!occupant || locked)
		return
	for(var/obj/O in src)
		O.forceMove(loc)
	src.occupant.forceMove(loc)
	src.occupant.reset_view()
	src.occupant = null
	update_use_power(1)
	src.icon_state = "body_scanner_0"
	return

/obj/machinery/bodyscanner/proc/set_occupant(var/mob/living/L)
	L.forceMove(src)
	src.occupant = L
	update_use_power(2)
	src.icon_state = "body_scanner_1"
	src.add_fingerprint(usr)


/obj/machinery/bodyscanner/affect_grab(var/mob/user, var/mob/target, var/obj/item/weapon/grab/grab)
	if (src.occupant)
		user << SPAN_NOTE("The scanner is already occupied!")
		return
	if(target.buckled)
		user << SPAN_NOTE("Unbuckle the subject before attempting to move them.")
		return
	if(target.abiotic())
		user << SPAN_NOTE("Subject cannot have abiotic items on.")
		return
	set_occupant(target)
	src.add_fingerprint(user)
	return TRUE

/obj/machinery/bodyscanner/MouseDrop_T(var/mob/target, var/mob/user)
	if(!ismob(target))
		return
	if (src.occupant)
		user << SPAN_NOTE("The scanner is already occupied!")
		return
	if (target.abiotic())
		user << SPAN_NOTE("Subject cannot have abiotic items on.")
		return
	if (target.buckled)
		user << SPAN_NOTE("Unbuckle the subject before attempting to move them.")
		return
	user.visible_message(
		SPAN_NOTE("\The [user] begins placing \the [target] into \the [src]."),
		SPAN_NOTE("You start placing \the [target] into \the [src].")
	)
	if(!do_after(user, 30, src) || !Adjacent(target))
		return
	set_occupant(target)
	src.add_fingerprint(user)
	return

/obj/machinery/bodyscanner/ex_act(severity)
	switch(severity)
		if(1.0)
			for(var/atom/movable/A in src)
				A.forceMove(loc)
				A.ex_act(severity)
		if(2.0)
			if (prob(50))
				for(var/atom/movable/A in src)
					A.forceMove(loc)
					A.ex_act(severity)
		if(3.0)
			if (prob(25))
				for(var/atom/movable/A in src)
					A.forceMove(loc)
					A.ex_act(severity)
	qdel(src)

/obj/machinery/bodyscanner/blob_act()
	if(prob(50))
		for(var/atom/movable/A in src)
			A.forceMove(loc)
		qdel(src)

/obj/machinery/body_scanconsole/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				qdel(src)
				return
	return

/obj/machinery/body_scanconsole/blob_act()
	if(prob(50))
		qdel(src)

/obj/machinery/body_scanconsole/power_change()
	..()
	if(stat & BROKEN)
		icon_state = "body_scannerconsole-p"
	else
		if (stat & NOPOWER)
			spawn(rand(0, 15))
				src.icon_state = "body_scannerconsole-p"
		else
			icon_state = initial(icon_state)

/obj/machinery/body_scanconsole
	var/obj/machinery/bodyscanner/connected
	var/known_implants = list(
		/obj/item/weapon/implant/chem,
		/obj/item/weapon/implant/death_alarm,
		/obj/item/weapon/implant/loyalty,
		/obj/item/weapon/implant/tracking
	)
	var/delete
	var/temphtml
	name = "Body Scanner Console"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "body_scannerconsole"
	dir = WEST
	density = 0
	anchored = 1


/obj/machinery/body_scanconsole/New()
	..()
	spawn(5)
		for(var/dir in cardinal)
			connected = locate(/obj/machinery/bodyscanner) in get_step(src, dir)
			if(connected)
				return

/obj/machinery/body_scanconsole/attack_ai(user as mob)
	return src.attack_hand(user)

/obj/machinery/body_scanconsole/attack_hand(user as mob)
	if(..())
		return
	if(stat & (NOPOWER|BROKEN))
		return
	if(!connected || (connected.stat & (NOPOWER|BROKEN)))
		user << "\red This console is not connected to a functioning body scanner."
		return
	if(!ishuman(connected.occupant))
		user << "\red This device can only scan compatible lifeforms."
		return

	var/dat
	if (src.delete && src.temphtml) //Window in buffer but its just simple message, so nothing
		src.delete = src.delete
	else if (!src.delete && src.temphtml) //Window in buffer - its a menu, dont add clear message
		dat = text("[]<BR><BR><A href='?src=\ref[];clear=1'>Main Menu</A>", src.temphtml, src)
	else
		if (src.connected) //Is something connected?
			dat = format_occupant_data(src.connected.get_occupant_data())
			dat += "<HR><A href='?src=\ref[src];print=1'>Print</A><BR>"
		else
			dat = "<font color='red'> Error: No Body Scanner connected.</font>"

	dat += text("<BR><A href='?src=\ref[];mach_close=scanconsole'>Close</A>", user)
	user << browse(dat, "window=scanconsole;size=430x600")
	return


/obj/machinery/body_scanconsole/Topic(href, href_list)
	if (..())
		return

	if (href_list["print"])
		if (!src.connected)
			usr << "\icon[src]<span class='warning'>Error: No body scanner connected.</span>"
			return
		var/mob/living/carbon/human/occupant = src.connected.occupant
		if (!src.connected.occupant)
			usr << "\icon[src]<span class='warning'>The body scanner is empty.</span>"
			return
		if (!ishuman(occupant))
			usr << "\icon[src]<span class='warning'>The body scanner cannot scan that lifeform.</span>"
			return
		var/obj/item/weapon/paper/R = new(src.loc)
		R.name = "Body scan report"
		R.info = format_occupant_data(src.connected.get_occupant_data())


/obj/machinery/bodyscanner/proc/get_occupant_data()
	if (!occupant || !ishuman(occupant))
		return
	var/mob/living/carbon/human/H = occupant
	var/list/occupant_data = list(
		"stationtime" = worldtime2text(),
		"stat" = H.stat,
		"health" = H.health,
		"virus_present" = H.virus2.len,
		"bruteloss" = H.getBruteLoss(),
		"fireloss" = H.getFireLoss(),
		"oxyloss" = H.getOxyLoss(),
		"toxloss" = H.getToxLoss(),
		"rads" = H.radiation,
		"cloneloss" = H.getCloneLoss(),
		"brainloss" = H.getBrainLoss(),
		"paralysis" = H.paralysis,
		"bodytemp" = H.bodytemperature,
		"borer_present" = H.has_brain_worms(),
		"inaprovaline_amount" = H.reagents.get_reagent_amount("inaprovaline"),
		"dexalin_amount" = H.reagents.get_reagent_amount("dexalin"),
		"stoxin_amount" = H.reagents.get_reagent_amount("stoxin"),
		"bicaridine_amount" = H.reagents.get_reagent_amount("bicaridine"),
		"dermaline_amount" = H.reagents.get_reagent_amount("dermaline"),
		"blood_amount" = H.vessel.get_reagent_amount("blood"),
		"percent" = round(H.vessel.get_reagent_amount("blood") / H.species.blood_volume*100),
		"disabilities" = H.sdisabilities,
		"lung_ruptured" = H.is_lung_ruptured(),
		"external_organs" = H.organs.Copy(),
		"internal_organs" = H.internal_organs.Copy(),
		"species_organs" = H.species.has_organ //Just pass a reference for this, it shouldn't ever be modified outside of the datum.
		)
	return occupant_data


/obj/machinery/body_scanconsole/proc/format_occupant_data(var/list/occ)
	var/dat = "<font color='blue'><b>Scan performed at [occ["stationtime"]]</b></font><br>"
	dat += "<font color='blue'><b>Occupant Statistics:</b></font><br>"
	var/aux
	switch (occ["stat"])
		if(0)
			aux = "Conscious"
		if(1)
			aux = "Unconscious"
		else
			aux = "Dead"
	dat += text("[]\tHealth %: [] ([])</font><br>", (occ["health"] > 50 ? "<font color='blue'>" : "<font color='red'>"), occ["health"], aux)
	if (occ["virus_present"])
		dat += "<font color='red'>Viral pathogen detected in blood stream.</font><br>"
	dat += text("[]\t-Brute Damage %: []</font><br>", (occ["bruteloss"] < 60 ? "<font color='blue'>" : "<font color='red'>"), occ["bruteloss"])
	dat += text("[]\t-Respiratory Damage %: []</font><br>", (occ["oxyloss"] < 60 ? "<font color='blue'>" : "<font color='red'>"), occ["oxyloss"])
	dat += text("[]\t-Toxin Content %: []</font><br>", (occ["toxloss"] < 60 ? "<font color='blue'>" : "<font color='red'>"), occ["toxloss"])
	dat += text("[]\t-Burn Severity %: []</font><br><br>", (occ["fireloss"] < 60 ? "<font color='blue'>" : "<font color='red'>"), occ["fireloss"])

	dat += text("[]\tRadiation Level %: []</font><br>", (occ["rads"] < 10 ?"<font color='blue'>" : "<font color='red'>"), occ["rads"])
	dat += text("[]\tGenetic Tissue Damage %: []</font><br>", (occ["cloneloss"] < 1 ?"<font color='blue'>" : "<font color='red'>"), occ["cloneloss"])
	dat += text("[]\tApprox. Brain Damage %: []</font><br>", (occ["brainloss"] < 1 ?"<font color='blue'>" : "<font color='red'>"), occ["brainloss"])
	dat += text("Paralysis Summary %: [] ([] seconds left!)<br>", occ["paralysis"], round(occ["paralysis"] / 4))
	dat += text("Body Temperature: [occ["bodytemp"]-T0C]&deg;C ([occ["bodytemp"]*1.8-459.67]&deg;F)<br><HR>")

	if(occ["borer_present"])
		dat += "Large growth detected in frontal lobe, possibly cancerous. Surgical removal is recommended.<br>"

	dat += text("[]\tBlood Level %: [] ([] units)</FONT><BR>", (occ["percent"] > BLOOD_VOLUME_SAFE ?"<font color='blue'>" : "<font color='red'>"), occ["percent"], occ["blood_amount"])

	dat += text("Inaprovaline: [] units<BR>", occ["inaprovaline_amount"])
	dat += text("Soporific: [] units<BR>", occ["stoxin_amount"])
	dat += text("[]\tDermaline: [] units</FONT><BR>", (occ["dermaline_amount"] < 30 ? "<font color='black'>" : "<font color='red'>"), occ["dermaline_amount"])
	dat += text("[]\tBicaridine: [] units<BR>", (occ["bicaridine_amount"] < 30 ? "<font color='black'>" : "<font color='red'>"), occ["bicaridine_amount"])
	dat += text("[]\tDexalin: [] units<BR>", (occ["dexalin_amount"] < 30 ? "<font color='black'>" : "<font color='red'>"), occ["dexalin_amount"])

	dat += "<HR><table border='1'>"
	dat += "<tr>"
	dat += "<th>Organ</th>"
	dat += "<th>Burn Damage</th>"
	dat += "<th>Brute Damage</th>"
	dat += "<th>Other Wounds</th>"
	dat += "</tr>"

	for(var/obj/item/organ/external/e in occ["external_organs"])
		var/AN = ""
		var/open = ""
		var/infected = ""
		var/imp = ""
		var/bled = ""
		var/robot = ""
		var/splint = ""
		var/internal_bleeding = ""
		var/lung_ruptured = ""

		dat += "<tr>"

		for(var/datum/wound/W in e.wounds) if(W.internal)
			internal_bleeding = "<br>Internal bleeding"
			break
		if(e.organ_tag == BP_CHEST && occ["lung_ruptured"])
			lung_ruptured = "Lung ruptured:"
		if(e.status & ORGAN_SPLINTED)
			splint = "Splinted:"
		if(e.status & ORGAN_BLEEDING)
			bled = "Bleeding:"
		if(e.status & ORGAN_BROKEN)
			AN = "[e.broken_description]:"
		switch(e.robotic)
			if(ORGAN_ASSISTED)
				robot = "Assisted:"
			if(ORGAN_ROBOT)
				robot = "Prosthetic:"
		if(e.open)
			open = "Open:"

		switch (e.germ_level)
			if (INFECTION_LEVEL_ONE to INFECTION_LEVEL_ONE + 200)
				infected = "Mild Infection:"
			if (INFECTION_LEVEL_ONE + 200 to INFECTION_LEVEL_ONE + 300)
				infected = "Mild Infection+:"
			if (INFECTION_LEVEL_ONE + 300 to INFECTION_LEVEL_ONE + 400)
				infected = "Mild Infection++:"
			if (INFECTION_LEVEL_TWO to INFECTION_LEVEL_TWO + 200)
				infected = "Acute Infection:"
			if (INFECTION_LEVEL_TWO + 200 to INFECTION_LEVEL_TWO + 300)
				infected = "Acute Infection+:"
			if (INFECTION_LEVEL_TWO + 300 to INFECTION_LEVEL_TWO + 400)
				infected = "Acute Infection++:"
			if (INFECTION_LEVEL_THREE to INFINITY)
				infected = "Septic:"

		if (e.implants.len)
			var/unknown_body = 0
			for(var/I in e.implants)
				if(is_type_in_list(I,known_implants))
					imp += "[I] implanted:"
				else
					unknown_body++
			if(unknown_body)
				imp += "Unknown body present:"

		if(!AN && !open && !infected & !imp)
			AN = "None:"
		if(!(e.status & ORGAN_DESTROYED))
			dat += "<td>[e.name]</td><td>[e.burn_dam]</td><td>[e.brute_dam]</td><td>[robot][bled][AN][splint][open][infected][imp][internal_bleeding][lung_ruptured]</td>"
		else
			dat += "<td>[e.name]</td><td>-</td><td>-</td><td>Not Found</td>"
		dat += "</tr>"

	for(var/obj/item/organ/internal/i in occ["internal_organs"])

		var/mech = ""
		if(i.robotic == 1)
			mech = "Assisted:"
		if(i.robotic == 2)
			mech = "Mechanical:"

		var/infection = "None"
		switch (i.germ_level)
			if (1 to INFECTION_LEVEL_ONE + 200)
				infection = "Mild Infection:"
			if (INFECTION_LEVEL_ONE + 200 to INFECTION_LEVEL_ONE + 300)
				infection = "Mild Infection+:"
			if (INFECTION_LEVEL_ONE + 300 to INFECTION_LEVEL_ONE + 400)
				infection = "Mild Infection++:"
			if (INFECTION_LEVEL_TWO to INFECTION_LEVEL_TWO + 200)
				infection = "Acute Infection:"
			if (INFECTION_LEVEL_TWO + 200 to INFECTION_LEVEL_TWO + 300)
				infection = "Acute Infection+:"
			if (INFECTION_LEVEL_TWO + 300 to INFINITY)
				infection = "Acute Infection++:"

		dat += "<tr>"
		dat += "<td>[i.name]</td><td>N/A</td><td>[i.damage]</td><td>[infection]:[mech]</td><td></td>"
		dat += "</tr>"
	dat += "</table>"

	var/list/species_organs = occ["species_organs"]
	for(var/organ_name in species_organs)
		if(!locate(species_organs[organ_name]) in occ["internal_organs"])
			dat += text("<font color='red'>No [organ_name] detected.</font><BR>")

	if(occ["sdisabilities"] & BLIND)
		dat += text("<font color='red'>Cataracts detected.</font><BR>")
	if(occ["sdisabilities"] & NEARSIGHTED)
		dat += text("<font color='red'>Retinal misalignment detected.</font><BR>")
	return dat
