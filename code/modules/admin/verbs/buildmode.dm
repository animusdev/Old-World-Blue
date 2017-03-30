/proc/togglebuildmode(mob/M as mob in player_list)
	set name = "Toggle Build Mode"
	set category = "Special Verbs"
	if(M.client)
		if(M.client.buildmode)
			log_admin("[key_name(usr)] has left build mode.", null, 0)
			qdel(M.client.buildmode)
			M.client.buildmode = null
		else
			log_admin("[key_name(usr)] has entered build mode.", null, 0)
			M.client.buildmode = PoolOrNew(/datum/buildmode, M.client)

/obj/screen/bmode//Cleaning up the tree a bit
	density = 1
	anchored = 1
	layer = 20
	dir = NORTH
	icon = 'icons/misc/buildmode.dmi'
	var/datum/buildmode/build_master = null

/obj/screen/bmode/New(var/datum/buildmode/BM)
	..()
	build_master = BM
	build_master.client.screen += src

/obj/screen/bmode/Destroy()
	if(build_master && build_master.client)
		build_master.client.screen -= src
	build_master = null
	return ..()

/obj/screen/bmode/builddir
	icon_state = "build"
	screen_loc = "NORTH,WEST"
	Click()
		switch(dir)
			if(NORTH)
				set_dir(EAST)
			if(EAST)
				set_dir(SOUTH)
			if(SOUTH)
				set_dir(WEST)
			if(WEST)
				set_dir(NORTHWEST)
			if(NORTHWEST)
				set_dir(NORTH)
		return 1

/obj/screen/bmode/buildhelp
	icon = 'icons/misc/buildmode.dmi'
	icon_state = "buildhelp"
	screen_loc = "NORTH,WEST+1"
	Click()
		switch(build_master.mode)
			if(1) // Basic Build
				usr << "<span class='notice'>***********************************************************</span>"
				usr << "<span class='notice'>Left Mouse Button        = Construct / Upgrade</span>"
				usr << "<span class='notice'>Right Mouse Button       = Deconstruct / Delete / Downgrade</span>"
				usr << "<span class='notice'>Left Mouse Button + ctrl = R-Window</span>"
				usr << "<span class='notice'>Left Mouse Button + alt  = Airlock</span>"
				usr << ""
				usr << "<span class='notice'>Use the button in the upper left corner to</span>"
				usr << "<span class='notice'>change the direction of built objects.</span>"
				usr << "<span class='notice'>***********************************************************</span>"
			if(2) // Adv. Build
				usr << "<span class='notice'>***********************************************************</span>"
				usr << "<span class='notice'>Right Mouse Button on buildmode button = Set object type</span>"
				usr << "<span class='notice'>Middle Mouse Button on buildmode button= On/Off object type saying</span>"
				usr << "<span class='notice'>Middle Mouse Button on turf/obj        = Capture object type</span>"
				usr << "<span class='notice'>Left Mouse Button on turf/obj          = Place objects</span>"
				usr << "<span class='notice'>Right Mouse Button                     = Delete objects</span>"
				usr << "<span class='notice'>Mouse Button + ctrl                    = Copy object type</span>"
				usr << ""
				usr << "<span class='notice'>Use the button in the upper left corner to</span>"
				usr << "<span class='notice'>change the direction of built objects.</span>"
				usr << "<span class='notice'>***********************************************************</span>"
			if(3) // Edit
				usr << "<span class='notice'>***********************************************************</span>"
				usr << "<span class='notice'>Right Mouse Button on buildmode button = Select var(type) & value</span>"
				usr << "<span class='notice'>Left Mouse Button on turf/obj/mob      = Set var(type) & value</span>"
				usr << "<span class='notice'>Right Mouse Button on turf/obj/mob     = Reset var's value</span>"
				usr << "<span class='notice'>Middle Mouse Button on turf/obj/mob    = Copy var's value</span>"
				usr << "<span class='notice'>***********************************************************</span>"
			if(4) // Throw
				usr << "<span class='notice'>***********************************************************</span>"
				usr << "<span class='notice'>Left Mouse Button on turf/obj/mob      = Select</span>"
				usr << "<span class='notice'>Right Mouse Button on turf/obj/mob     = Throw</span>"
				usr << "<span class='notice'>***********************************************************</span>"
			if(5) // Room Build
				usr << "<span class='notice'>***********************************************************</span>"
				usr << "<span class='notice'>Left Mouse Button on turf              = Select as point A</span>"
				usr << "<span class='notice'>Right Mouse Button on turf             = Select as point B</span>"
				usr << "<span class='notice'>Right Mouse Button on buildmode button = Change floor/wall type</span>"
				usr << "<span class='notice'>***********************************************************</span>"
			if(6) // Make Ladders
				usr << "<span class='notice'>***********************************************************</span>"
				usr << "<span class='notice'>Left Mouse Button on turf              = Set as upper ladder loc</span>"
				usr << "<span class='notice'>Right Mouse Button on turf             = Set as lower ladder loc</span>"
				usr << "<span class='notice'>***********************************************************</span>"
			if(7) // Move Into Contents
				usr << "<span class='notice'>***********************************************************</span>"
				usr << "<span class='notice'>Left Mouse Button on turf/obj/mob      = Select</span>"
				usr << "<span class='notice'>Right Mouse Button on turf/obj/mob     = Move into selection</span>"
				usr << "<span class='notice'>***********************************************************</span>"
			if(8) // Make Lights
				usr << "<span class='notice'>***********************************************************</span>"
				usr << "<span class='notice'>Left Mouse Button on turf/obj/mob      = Make it glow</span>"
				usr << "<span class='notice'>Right Mouse Button on turf/obj/mob     = Reset glowing</span>"
				usr << "<span class='notice'>Right Mouse Button on buildmode button = Change glow properties</span>"
				usr << "<span class='notice'>***********************************************************</span>"
		return 1

/obj/screen/bmode/buildquit
	icon_state = "buildquit"
	screen_loc = "NORTH,WEST+3"

	Click()
		togglebuildmode(build_master.client.mob)
		return 1

/datum/buildmode
	var/mode = 1
	var/client/client = null
	var/obj/screen/bmode/builddir/builddir   = null
	var/obj/screen/bmode/buildhelp/buildhelp = null
	var/obj/screen/bmode/buildmode/buildmode = null
	var/obj/screen/bmode/buildquit/buildquit = null

	var/atom/movable/throw_atom = null

	var/varholder = "name"
	var/valueholder = "derp"
	var/objholder = /obj/structure/closet
	var/objsay = 1

	var/wall_holder = /turf/simulated/wall
	var/floor_holder = /turf/simulated/floor/plating
	var/turf/coordA = null
	var/turf/coordB = null

	var/new_light_color = "#FFFFFF"
	var/new_light_range = 3
	var/new_light_intensity = 3

/datum/buildmode/New(var/client/CL)
	..()
	client = CL
	client.show_popup_menus = 0

	builddir  = new (src)
	buildhelp = new (src)
	buildmode = new (src)
	buildquit = new (src)


/datum/buildmode/Destroy()
	if(client)
		client.show_popup_menus = 1
	qdel(builddir)
	builddir = null
	qdel(buildhelp)
	buildhelp = null
	qdel(buildmode)
	buildmode = null
	qdel(buildquit)
	buildquit = null
	throw_atom = null
	client = null
	return ..()

/obj/screen/bmode/buildmode
	icon_state = "buildmode1"
	screen_loc = "NORTH,WEST+2"

/obj/screen/bmode/buildmode/Click(location, control, params)
	var/list/pa = params2list(params)

	if(pa.Find("middle"))
		switch(build_master.mode)
			if(2)
				build_master.objsay=!build_master.objsay

	if(pa.Find("left"))
		switch(build_master.mode)
			if(1)
				build_master.mode = 2
				src.icon_state = "buildmode2"
			if(2)
				build_master.mode = 3
				src.icon_state = "buildmode3"
			if(3)
				build_master.mode = 4
				src.icon_state = "buildmode4"
			if(4)
				build_master.mode = 5
				src.icon_state = "buildmode5"
			if(5)
				build_master.mode = 6
				src.icon_state = "buildmode6"
			if(6)
				build_master.mode = 7
				src.icon_state = "buildmode7"
			if(7)
				build_master.mode = 8
				src.icon_state = "buildmode8"
			if(8)
				build_master.mode = 1
				src.icon_state = "buildmode1"

	else if(pa.Find("right"))
		switch(build_master.mode)
			if(1) // Basic Build
				return 1
			if(2) // Adv. Build
				build_master.objholder = build_master.get_path_from_partial_text(/obj/structure/closet)

			if(3) // Edit
				var/list/locked = list("vars", "key", "ckey", "client", "firemut", "ishulk", "telekinesis", "xray", "virus", "viruses", "cuffed", "ka", "last_eaten", "urine")

				build_master.varholder = input(usr,"Enter variable name:" ,"Name", "name")
				if(build_master.varholder in locked && !check_rights(R_DEBUG,0))
					return 1
				var/thetype = input(usr,"Select variable type:" ,"Type") in list("text","number","mob-reference","obj-reference","turf-reference")
				if(!thetype) return 1
				switch(thetype)
					if("text")
						build_master.valueholder = input(usr,"Enter variable value:" ,"Value", "value") as text
					if("number")
						build_master.valueholder = input(usr,"Enter variable value:" ,"Value", 123) as num
					if("mob-reference")
						build_master.valueholder = input(usr,"Enter variable value:" ,"Value") as mob in mob_list
					if("obj-reference")
						build_master.valueholder = input(usr,"Enter variable value:" ,"Value") as obj in world
					if("turf-reference")
						build_master.valueholder = input(usr,"Enter variable value:" ,"Value") as turf in world
			if(5) // Room build
				var/choice = alert("Would you like to change the floor or wall holders?","Room Builder", "Floor", "Wall")
				switch(choice)
					if("Floor")
						build_master.floor_holder = build_master.get_path_from_partial_text(/turf/simulated/floor/plating)
					if("Wall")
						build_master.wall_holder = build_master.get_path_from_partial_text(/turf/simulated/wall)
			if(8) // Lights
				var/choice = alert("Change the new light range, power, or color?", "Light Maker", "Range", "Power", "Color")
				switch(choice)
					if("Range")
						var/input = input("New light range.","Light Maker",3) as null|num
						if(input)
							build_master.new_light_range = input
					if("Power")
						var/input = input("New light power.","Light Maker",3) as null|num
						if(input)
							build_master.new_light_intensity = input
					if("Color")
						var/input = input("New light color.","Light Maker",3) as null|color
						if(input)
							build_master.new_light_color = input
	return 1

/datum/buildmode/proc/build_click(var/mob/user, params, var/obj/object)
	var/list/pa = params2list(params)

	switch(mode)
		if(1) // Basic Build
			if(istype(object,/turf) && pa.Find("left") && !pa.Find("alt") && !pa.Find("ctrl") )
				if(istype(object,/turf/space))
					var/turf/T = object
					T.ChangeTurf(/turf/simulated/floor)
					return
				else if(istype(object,/turf/simulated/floor))
					var/turf/T = object
					T.ChangeTurf(/turf/simulated/wall)
					return
				else if(istype(object,/turf/simulated/wall))
					var/turf/T = object
					T.ChangeTurf(/turf/simulated/wall/r_wall)
					return
			else if(pa.Find("right"))
				if(istype(object,/turf/simulated/wall/r_wall))
					var/turf/T = object
					T.ChangeTurf(/turf/simulated/wall)
					return
				else if(istype(object,/turf/simulated/wall))
					var/turf/T = object
					T.ChangeTurf(/turf/simulated/floor)
					return
				else if(istype(object,/turf/simulated/floor))
					var/turf/T = object
					T.ChangeTurf(/turf/space)
					return
				else if(istype(object,/obj))
					qdel(object)
					return
			else if(istype(object,/turf) && pa.Find("alt") && pa.Find("left"))
				new/obj/machinery/door/airlock(get_turf(object))
			else if(istype(object,/turf) && pa.Find("ctrl") && pa.Find("left"))
				var/obj/structure/window/reinforced/WIN = new (get_turf(object))
				WIN.set_dir(builddir.dir)
		if(2) // Adv. Build
			if(pa.Find("middle") || pa.Find("ctrl"))
				objholder = object.type
				user << "<span class='notice'>[object] ([object.type]) copied to buildmode.</span>"
			else if(pa.Find("left"))
				if(ispath(objholder,/turf))
					var/turf/T = get_turf(object)
					T.ChangeTurf(objholder)
				else
					var/obj/A = new objholder (get_turf(object))
					A.set_dir(builddir.dir)
			else if(pa.Find("right"))
				if(isobj(object))
					qdel(object)
		if(3) // Edit
			if(pa.Find("left")) //I cant believe this shit actually compiles.
				if(object.vars.Find(varholder))
					log_admin("[key_name(usr)] modified [object.name]'s [varholder] to [valueholder]", valueholder, 0)
					object.vars[varholder] = valueholder
				else
					user << "<span class='danger'>[initial(object.name)] does not have a var called '[varholder]'</span>"
			else if(pa.Find("right"))
				if(object.vars.Find(varholder))
					log_admin("[key_name(usr)] modified [object.name]'s [varholder] to [valueholder]", valueholder, 0)
					object.vars[varholder] = initial(object.vars[varholder])
				else
					user << "<span class='danger'>[initial(object.name)] does not have a var called '[varholder]'</span>"
			else if(pa.Find("middle"))
				if(object.vars.Find(varholder))
					valueholder = object.vars[varholder]
				else
					user << "<span class='danger'>[initial(object.name)] does not have a var called '[varholder]'</span>"
		if(4) // Throw
			if(pa.Find("left"))
				if(istype(object, /atom/movable))
					throw_atom = object
			if(pa.Find("right"))
				if(throw_atom)
					throw_atom.throw_at(object, 10, 1)
					log_admin("[key_name(usr)] threw [throw_atom] at [object]", object, 0)
		if(5) // Room build
			if(pa.Find("left"))
				coordA = get_turf(object)
				user << "<span class='notice'>Defined [object] ([object.type]) as point A.</span>"
			if(pa.Find("right"))
				coordB = get_turf(object)
				user << "<span class='notice'>Defined [object] ([object.type]) as point B.</span>"
			if(coordA && coordB)
				user << "<span class='notice'>A and B set, creating rectangle.</span>"
				make_rectangle(
					coordA,
					coordB,
					wall_holder,
					floor_holder
					)
				coordA = null
				coordB = null
		if(6) // Ladders
			if(pa.Find("left"))
				coordA = get_turf(object)
				user << "<span class='notice'>Defined [object] ([object.type]) as upper ladder location.</span>"
			if(pa.Find("right"))
				coordB = get_turf(object)
				user << "<span class='notice'>Defined [object] ([object.type]) as lower ladder location.</span>"
			if(coordA && coordB)
				user << "<span class='notice'>Ladder locations set, building ladders.</span>"
				var/obj/structure/ladder/A = new /obj/structure/ladder(coordA)
				var/obj/structure/ladder/B = new /obj/structure/ladder(coordB)
				A.target = B
				B.target = A
				B.icon_state = "ladderup"
				coordA = null
				coordB = null
		if(7) // Move into contents
			if(pa.Find("left"))
				if(istype(object, /atom))
					throw_atom = object
			if(pa.Find("right"))
				if(throw_atom && istype(object, /atom/movable))
					object.forceMove(throw_atom)
					log_admin("[key_name(usr)] moved [object] into [throw_atom].", throw_atom, 0)
		if(8) // Lights
			if(pa.Find("left"))
				if(object)
					object.set_light(new_light_range, new_light_intensity, new_light_color)
			if(pa.Find("right"))
				if(object)
					object.set_light(0, 0, "#FFFFFF")
	return 1

/datum/buildmode/proc/get_path_from_partial_text(default_path)
	var/desired_path = input("Enter full or partial typepath.","Typepath","[default_path]")

	var/list/types = typesof(/atom)
	var/list/matches = list()

	for(var/path in types)
		if(findtext("[path]", desired_path))
			matches += path

	if(matches.len==0)
		alert("No results found.  Sorry.")
		return

	var/result = null

	if(matches.len==1)
		result = matches[1]
	else
		result = input("Select an atom type", "Spawn Atom", matches[1]) as null|anything in matches
		if(!objholder)
			result = default_path
	return result

/datum/buildmode/proc/make_rectangle(var/turf/A, var/turf/B, var/turf/wall_type, var/turf/floor_type)
	if(!A || !B) // No coords
		return
	if(A.z != B.z) // Not same z-level
		return

	var/height = A.y - B.y
	var/width = A.x - B.x
	var/z_level = A.z

	var/turf/lower_left_corner = null
	// First, try to find the lowest part
	var/desired_y = 0
	if(A.y <= B.y)
		desired_y = A.y
	else
		desired_y = B.y

	//Now for the left-most part.
	var/desired_x = 0
	if(A.x <= B.x)
		desired_x = A.x
	else
		desired_x = B.x

	lower_left_corner = locate(desired_x, desired_y, z_level)

	// Now we can begin building the actual room.  This defines the boundries for the room.
	var/low_bound_x = lower_left_corner.x
	var/low_bound_y = lower_left_corner.y

	var/high_bound_x = lower_left_corner.x + abs(width)
	var/high_bound_y = lower_left_corner.y + abs(height)

	for(var/i = low_bound_x, i <= high_bound_x, i++)
		for(var/j = low_bound_y, j <= high_bound_y, j++)
			var/turf/T = locate(i, j, z_level)
			if(i == low_bound_x || i == high_bound_x || j == low_bound_y || j == high_bound_y)
				if(isturf(wall_type))
					T.ChangeTurf(wall_type)
				else
					new wall_type(T)
			else
				if(isturf(floor_type))
					T.ChangeTurf(floor_type)
				else
					new floor_type(T)