var/list/datum/power/arachna/powerinstances1

/datum/power/arachna
	name = "Error Power"
	desc = "This is error"
	helptext = "If you see it, then you see error"
	isVerb = 1 // Is it an active power, or passive?
	verbpath // Path to a verb that contains the effects.
	var/cost = 1000
	var/use_web_flag = 0
	var/web_cost = 1000
	var/nutricioncost= 100000

/datum/power/arachna/jump
	name = "Jump"
	desc = "Jump front of you direction"
	helptext = "Jump to 5 cells from, you current position. If mob on the way, you knock him down."
	verbpath = /mob/proc/jump// Path to a verb that contains the effects.
	cost = 1
	nutricioncost = 100

/datum/power/arachna/spiderweb
	name = "Net"
	desc = "Fell like a cowboy"
	helptext = "Make a net and try catch someone. Like a ninja!"
	verbpath = /mob/proc/silk_net// Path to a verb that contains the effects.
	cost = 1
	nutricioncost = 100
	use_web_flag = 1
	web_cost = 25