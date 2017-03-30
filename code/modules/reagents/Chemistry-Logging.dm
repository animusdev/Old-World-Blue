
/var/list/chemical_reaction_logs = list()

/proc/log_chemical_reaction(atom/A, datum/chemical_reaction/R, multiplier)
	if(!A || !R)
		return

	var/turf/T = get_turf(A)
	var/logstr = "[usr ? key_name(usr) : "EVENT"] mixed [R.name] ([R.result]) (x[multiplier]) in \the [A]"

	chemical_reaction_logs += "\[[time_stamp()]\] [logstr] at [T ? "[T.x],[T.y],[T.z]" : "*null*"]"

	log_admin(logstr, T, R.log_is_important)

/client/proc/view_chemical_reaction_logs()
	set name = "Show Chemical Reactions"
	set category = "Admin"

	if(!check_rights(R_ADMIN|R_MOD))
		return

	var/html = ""
	for(var/entry in chemical_reaction_logs)
		html += "[entry]<br>"

	usr << browse(html, "window=chemlogs")
