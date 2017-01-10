var/list/arachna_powers = typesof(/datum/power/arachna) - /datum/power/arachna - /datum/power/arachna/venom //needed for the badmin verb for now
var/list/datum/power/arachna/arachna_powerinstances = list()

/datum/power/arachna
	name = "Error Power"
	desc = "This is error"
	helptext = "If you see it, then you see error"
	isVerb = 1 // Is it an active power, or passive?
	var/cost = 1000
	var/use_web_flag = 0 //Ability use a silk gland?
	var/web_cost = 1000 //Cost a resurses in silk gland
	var/nutricioncost= 100000 //How much nutrition need?
	var/extra_data

/datum/power/arachna/jump
	name = "Jump"
	desc = "Jump front of you direction"
	helptext = "Jump to 5 cells from, you current position. If mob on the way, you knock him down."
	verbpath = /mob/living/carbon/human/proc/arachna_prepare_jump
	cost = 1
	nutricioncost = 100
	isVerb = 1

/datum/power/arachna/spiderweb
	name = "Net"
	desc = "Fell like a cowboy"
	helptext = "Make a net and try catch someone. Like a ninja!"
	verbpath = /mob/proc/silk_net
	cost = 1
	nutricioncost = 100
	use_web_flag = 1
	web_cost = 25
	isVerb = 1

/*var/list/venom_list = list(
	"inaprovaline",
	"stoxin",
	"chloralhydrate",
	"synaptizine",
	"paroxetine",
	"kurovasicin",
	"space_drugs",
	"potassium_chlorophoride",
	"cryptobiolin",
	"tramadol",
	"impedrezene"
)*/

/datum/power/arachna/venom
	name = "VenomDatum"
	desc = "Make you poison better?"
	helptext = "This error too"
	isVerb = 0
	verbpath = /mob/living/carbon/human/proc/add_venom_datum

/datum/power/arachna/venom/inaprovaline
	name = "Inaprovaline"
	desc = "Make you poison better?"
	helptext = "Inaprovaline is a cardiac and synaptic stimulant. Weak painkiller. Help stabilize you victim. Why? Only you know."
	cost = 1
	extra_data = "inaprovaline"

/datum/power/arachna/venom/stoxin
	name = "Stoxin"
	desc = "Make you poison better?"
	helptext = "A less powerful sedative that takes a while to work."
	cost = 1
	extra_data = "stoxin"

/datum/power/arachna/venom/chloralhydrate
	name = "Chloralhydrate"
	helptext = "A powerful sedative."
	cost = 2
	extra_data = "chloralhydrate"

/datum/power/arachna/venom/synaptizine
	name = "Synaptizine"
	helptext = "Synaptizine is toxic, but treats hallucinations, paralysis, and stunned or weakened victim. It is metabolized very slowly.  Five units will cause dangerous poisoning."
	cost = 1
	extra_data = "synaptizine"

/datum/power/arachna/venom/paroxetine
	name = "Paroxetine"
	helptext = "Stronger antidepressant, with chance of hallucinations."
	cost = 1
	extra_data = "paroxetine"

/datum/power/arachna/venom/kurovasicin
	name = "Kurovasicin"
	helptext = "Stronger aphrodisiac. You horny bastard~"
	cost = 1
	extra_data = "kurovasicin"

/datum/power/arachna/venom/space_drugs
	name = "Space_drugs"
	helptext = "An illegal compound which induces a number of effects such as loss of balance and hallucinations. "
	cost = 1
	extra_data = "space_drugs"

/datum/power/arachna/venom/potassium_chlorophoride
	name = "Potassium_chlorophoride"
	helptext = "A specific chemical based on Potassium Chloride to stop the heart you victim."
	cost = 3
	extra_data = "potassium_chlorophoride"

/datum/power/arachna/venom/cryptobiolin
	name = "Cryptobiolin"
	helptext = "Causes confusion and dizziness on its own."
	cost = 1
	extra_data = "cryptobiolin"

/datum/power/arachna/venom/tramadol
	name = "Tramadol"
	helptext = "An effective and very addictive painkiller. For What? Only you know."
	cost = 1
	extra_data = "tramadol"

/datum/power/arachna/venom/impedrezene
	name = "Impedrezene"
	helptext = "A narcotic that impedes ones ability by slowing down the higher brain cell functions. Causes massive brain damage."
	cost = 2
	extra_data = "impedrezene"