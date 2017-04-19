/obj/item/clothing/glasses/hud
	name = "HUD"
	desc = "A heads-up display that provides important info in (almost) real time."
	flags = 0 //doesn't protect eyes because it's a monocle, duh
	origin_tech = list(TECH_MAGNET = 3, TECH_BIO = 2)
	var/list/icon/current = list() //the current hud icons

	proc
		process_hud(var/mob/M)	return

/obj/item/clothing/glasses/hud/health
	name = "Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	icon_state = "healthhud"
	body_parts_covered = 0

/obj/item/clothing/glasses/hud/health/on_examine(var/mob/living/carbon/human/target, var/mob/living/user)
	if(!istype(target))
		return

	var/perpname = target.get_id_name(target.name)
	var/medical = "None"

	var/datum/data/record/E = find_general_record("name", perpname)
	if(E)
		medical = E.fields["p_stat"]

	var/list/msg = new
	msg += "<span class = 'deptradio'>Physical status:</span> <a href='?src=\ref[src];medical=[perpname]'>\[[medical]\]</a>"
	msg += "<span class = 'deptradio'>Medical records:</span> <a href='?src=\ref[src];medrecord=[perpname]'>\[View\]</a> <a href='?src=\ref[src];medrecordadd=[perpname]'>\[Add comment\]</a>"

	var/obj/item/clothing/under/U = target.get_equipped_item(slot_w_uniform)
	if(U && istype(U) && U.sensor_mode >= 2)
		msg += "<span class='deptradio'><b>Damage Specifics:</span> <span style=\"color:blue\">[round(target.getOxyLoss(), 1)]</span>-<span style=\"color:green\">[round(target.getToxLoss(), 1)]</span>-<span style=\"color:#FFA500\">[round(target.getFireLoss(), 1)]</span>-<span style=\"color:red\">[round(target.getBruteLoss(), 1)]</span></b>"

	user << jointext(msg, "\n")

/obj/item/clothing/glasses/hud/health/Topic(href, href_list)
	if(..() || src.loc != usr)
		return 1

	if (href_list["medical"])
		var/perpname = href_list["medical"]

		var/datum/data/record/R = find_general_record("name", perpname)
		if(!R)
			usr << "\red Unable to locate a data core entry for this person."
			return

		var/setmedical = input(usr, "Specify a new medical status for this person.", "Medical HUD", R.fields["p_stat"]) \
			in list("*SSD*", "*Deceased*", "Physically Unfit", "Active", "Disabled", "Cancel")

		if(src.loc != usr)
			if(setmedical != "Cancel")
				R.fields["p_stat"] = setmedical
				if(PDA_Manifest.len)
					PDA_Manifest.Cut()

				spawn()
					usr.handle_regular_hud_updates()

	if(href_list["medrecord"])
		var/perpname = href_list["medrecord"]

		var/datum/data/record/R = find_medical_record("name", perpname)
		if(!R)
			usr << "\red Unable to locate a data core entry for this person."
			return
		usr << "<b>Name:</b> [R.fields["name"]]	<b>Blood Type:</b> [R.fields["b_type"]]"
		usr << "<b>DNA:</b> [R.fields["b_dna"]]"
		usr << "<b>Minor Disabilities:</b> [R.fields["mi_dis"]]"
		usr << "<b>Details:</b> [R.fields["mi_dis_d"]]"
		usr << "<b>Major Disabilities:</b> [R.fields["ma_dis"]]"
		usr << "<b>Details:</b> [R.fields["ma_dis_d"]]"
		usr << "<b>Notes:</b> [R.fields["notes"]]"
		usr << "<a href='?src=\ref[src];medrecordComment=[perpname]'>\[View Comment Log\]</a>"

	if(href_list["medrecordComment"])
		var/perpname = href_list["medrecordComment"]

		var/datum/data/record/R = find_medical_record("name", perpname)
		if(!R)
			usr << "\red Unable to locate a data core entry for this person."
			return
		var/counter = 1
		while(R.fields["com_[counter]"])
			usr << R.fields["com_[counter]"]
			counter++
		if (counter == 1)
			usr << "No comment found"
		usr << "<a href='?src=\ref[src];medrecordadd=[perpname]'>\[Add comment\]</a>"


/obj/item/clothing/glasses/hud/health/prescription
	name = "Prescription Health Scanner HUD"
	desc = "A medical HUD integrated with a set of prescription glasses"
	icon_state = "glasseshealth"
	prescription = 1

/obj/item/clothing/glasses/hud/health/process_hud(var/mob/M)
	process_med_hud(M, 1)

/obj/item/clothing/glasses/hud/security
	name = "Security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status and security records."
	icon_state = "securityhud"
	body_parts_covered = 0
	var/global/list/jobs[0]

/obj/item/clothing/glasses/hud/security/on_examine(var/mob/living/carbon/human/target, var/mob/living/user)
	if(!istype(target))
		return
	var/perpname = target.get_id_name(target.name)
	var/criminal = "None"

	var/datum/data/record/E = find_security_record("name", perpname)
	if(E)
		criminal = E.fields["criminal"]

	var/list/msg = new
	msg += "<span class = 'deptradio'>Criminal status:</span> <a href='?src=\ref[src];criminal=1'>\[[criminal]\]</a>"
	msg += "<span class = 'deptradio'>Security records:</span> <a href='?src=\ref[src];secrecord=`'>\[View\]</a>  <a href='?src=\ref[src];secrecordadd=`'>\[Add comment\]</a>"

	user << jointext(msg, "\n")

/obj/item/clothing/glasses/hud/engi
	name = "Engineereing HUD"
	desc = "A heads-up display that scans walls, floors, and stuff to provide accurate data about station condition"
	icon_state = "engihud"
	item_state = "engihud"
	body_parts_covered = 0
	vision_flags = SEE_TURFS

/obj/item/clothing/glasses/hud/security/jensenshades
	name = "Augmented shades"
	desc = "Polarized bioneural eyewear, designed to augment your vision."
	icon_state = "jensenshades"
	item_state = "jensenshades"
	darkness_view = -1

/obj/item/clothing/glasses/hud/security/process_hud(var/mob/M)
	process_sec_hud(M, 1)
