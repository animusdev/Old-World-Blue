//SUPPLY PACKS
//NOTE: only secure crate types use the access var (and are lockable)
//NOTE: hidden packs only show up when the computer has been hacked.
//ANOTER NOTE: Contraband is obtainable through modified supplycomp circuitboards.
//BIG NOTE: Don't add living things to crates, that's bad, it will break the shuttle.
//NEW NOTE: Do NOT set the price of any crates below 7 points. Doing so allows infinite points.

var/list/all_supply_groups = list(
	"Atmospherics",
	"Costumes",
	"Engineering",
	"Hospitality",
	"Hydroponics",
	"Materials",
	"Medical",
	"Miscellaneous",
//	"Munitions",
	"Reagents",
	"Reagent Cartridges",
	"Recreation",
	"Robotics",
	"Science",
	"Security",
	"Supplies",
	"Voidsuits"
)

/datum/supply_packs
	var/name = null
	var/list/contains = list()
	var/manifest = ""
	var/cost = null
	var/containertype = null
	var/containername = null
	var/access = null
	var/hidden = 0
	var/contraband = 0
	var/group = "Operations"

/datum/supply_packs/New()
	if(!manifest)
		manifest += "<ul>"
		for(var/path in contains)
			if(!path || !ispath(path, /atom))
				continue
			var/atom/O = path
			manifest += "<li>[initial(O.name)]</li>"
		manifest += "</ul>"

/datum/supply_packs/randomised
	var/num_contained		//number of items picked to be contained in a randomised crate

/datum/supply_packs/randomised/New()
	manifest += "Contains any [num_contained] of:"
	..()

/datum/supply_packs/custom
	name = "custom pack"
	cost = 0
	containername = "crate"
	containertype = /obj/structure/closet/crate
	group = "Operations"
	contains = list()

/datum/supply_packs/custom/New( t_name="Custom supply pack", t_cost=8, t_access=null, \
								t_containername="crate", t_containertype=/obj/structure/closet/crate, \
								t_group="Operations", t_hide=0, t_contains = list() )
	name = t_name
	cost = t_cost
	access = t_access
	group = t_group
	containername = t_containername
	containertype = t_containertype
	for( var/item in t_contains )
		contains += item
	..()
