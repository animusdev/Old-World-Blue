//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/*
 * A large number of misc global procs.
 */

//Checks if all high bits in req_mask are set in bitfield
#define BIT_TEST_ALL(bitfield, req_mask) ((~(bitfield) & (req_mask)) == 0)

//Inverts the colour of an HTML string
/proc/invertHTML(HTMLstring)

	if (!( istext(HTMLstring) ))
		CRASH("Given non-text argument!")
		return
	else
		if (length(HTMLstring) != 7)
			CRASH("Given non-HTML argument!")
			return
	var/textr = copytext(HTMLstring, 2, 4)
	var/textg = copytext(HTMLstring, 4, 6)
	var/textb = copytext(HTMLstring, 6, 8)
	var/r = hex2num(textr)
	var/g = hex2num(textg)
	var/b = hex2num(textb)
	textr = num2hex(255 - r)
	textg = num2hex(255 - g)
	textb = num2hex(255 - b)
	if (length(textr) < 2)
		textr = text("0[]", textr)
	if (length(textg) < 2)
		textr = text("0[]", textg)
	if (length(textb) < 2)
		textr = text("0[]", textb)
	return text("#[][][]", textr, textg, textb)
	return

//Returns the middle-most value
/proc/dd_range(var/low, var/high, var/num)
	return max(low,min(high,num))

//Returns whether or not A is the middle most value
/proc/InRange(var/A, var/lower, var/upper)
	if(A < lower) return 0
	if(A > upper) return 0
	return 1


/proc/Get_Angle(atom/movable/start,atom/movable/end)//For beams.
	if(!start || !end) return 0
	var/dy
	var/dx
	dy=(32*end.y+end.pixel_y)-(32*start.y+start.pixel_y)
	dx=(32*end.x+end.pixel_x)-(32*start.x+start.pixel_x)
	if(!dy)
		return (dx>=0)?90:270
	.=arctan(dx/dy)
	if(dy<0)
		.+=180
	else if(dx<0)
		.+=360

//Returns location. Returns null if no location was found.
/proc/get_teleport_loc(turf/location,mob/target,distance = 1, density = 0, errorx = 0, errory = 0, eoffsetx = 0, eoffsety = 0)
/*
Location where the teleport begins, target that will teleport, distance to go, density checking 0/1(yes/no).
Random error in tile placement x, error in tile placement y, and block offset.
Block offset tells the proc how to place the box. Behind teleport location, relative to starting location, forward, etc.
Negative values for offset are accepted, think of it in relation to North, -x is west, -y is south. Error defaults to positive.
Turf and target are seperate in case you want to teleport some distance from a turf the target is not standing on or something.
*/

	var/dirx = 0//Generic location finding variable.
	var/diry = 0

	var/xoffset = 0//Generic counter for offset location.
	var/yoffset = 0

	var/b1xerror = 0//Generic placing for point A in box. The lower left.
	var/b1yerror = 0
	var/b2xerror = 0//Generic placing for point B in box. The upper right.
	var/b2yerror = 0

	errorx = abs(errorx)//Error should never be negative.
	errory = abs(errory)
	//var/errorxy = round((errorx+errory)/2)//Used for diagonal boxes.

	switch(target.dir)//This can be done through equations but switch is the simpler method. And works fast to boot.
	//Directs on what values need modifying.
		if(1)//North
			diry+=distance
			yoffset+=eoffsety
			xoffset+=eoffsetx
			b1xerror-=errorx
			b1yerror-=errory
			b2xerror+=errorx
			b2yerror+=errory
		if(2)//South
			diry-=distance
			yoffset-=eoffsety
			xoffset+=eoffsetx
			b1xerror-=errorx
			b1yerror-=errory
			b2xerror+=errorx
			b2yerror+=errory
		if(4)//East
			dirx+=distance
			yoffset+=eoffsetx//Flipped.
			xoffset+=eoffsety
			b1xerror-=errory//Flipped.
			b1yerror-=errorx
			b2xerror+=errory
			b2yerror+=errorx
		if(8)//West
			dirx-=distance
			yoffset-=eoffsetx//Flipped.
			xoffset+=eoffsety
			b1xerror-=errory//Flipped.
			b1yerror-=errorx
			b2xerror+=errory
			b2yerror+=errorx

	var/turf/destination=locate(location.x+dirx,location.y+diry,location.z)

	if(destination)//If there is a destination.
		if(errorx||errory)//If errorx or y were specified.
			var/destination_list[] = list()//To add turfs to list.
			//destination_list = new()
			/*This will draw a block around the target turf, given what the error is.
			Specifying the values above will basically draw a different sort of block.
			If the values are the same, it will be a square. If they are different, it will be a rectengle.
			In either case, it will center based on offset. Offset is position from center.
			Offset always calculates in relation to direction faced. In other words, depending on the direction of the teleport,
			the offset should remain positioned in relation to destination.*/

			var/turf/center = locate((destination.x+xoffset),(destination.y+yoffset),location.z)//So now, find the new center.

			//Now to find a box from center location and make that our destination.
			for(var/turf/T in block(locate(center.x+b1xerror,center.y+b1yerror,location.z), locate(center.x+b2xerror,center.y+b2yerror,location.z) ))
				if(density&&T.density)	continue//If density was specified.
				if(T.x>world.maxx || T.x<1)	continue//Don't want them to teleport off the map.
				if(T.y>world.maxy || T.y<1)	continue
				destination_list += T
			if(destination_list.len)
				destination = pick(destination_list)
			else	return

		else//Same deal here.
			if(density&&destination.density)	return
			if(destination.x>world.maxx || destination.x<1)	return
			if(destination.y>world.maxy || destination.y<1)	return
	else	return

	return destination



/proc/LinkBlocked(turf/A, turf/B)
	if(A == null || B == null) return 1
	var/adir = get_dir(A,B)
	var/rdir = get_dir(B,A)
	if((adir & (NORTH|SOUTH)) && (adir & (EAST|WEST)))	//	diagonal
		var/iStep = get_step(A,adir&(NORTH|SOUTH))
		if(!LinkBlocked(A,iStep) && !LinkBlocked(iStep,B)) return 0

		var/pStep = get_step(A,adir&(EAST|WEST))
		if(!LinkBlocked(A,pStep) && !LinkBlocked(pStep,B)) return 0
		return 1

	if(DirBlocked(A,adir)) return 1
	if(DirBlocked(B,rdir)) return 1
	return 0


/proc/DirBlocked(turf/loc,var/dir)
	for(var/obj/structure/window/D in loc)
		if(!D.density)			continue
		if(D.dir == SOUTHWEST)	return 1
		if(D.dir == dir)		return 1

	for(var/obj/machinery/door/D in loc)
		if(!D.density)			continue
		if(istype(D, /obj/machinery/door/window))
			if((dir & SOUTH) && (D.dir & (EAST|WEST)))		return 1
			if((dir & EAST ) && (D.dir & (NORTH|SOUTH)))	return 1
		else return 1	// it's a real, air blocking door
	return 0

/proc/TurfBlockedNonWindow(turf/loc)
	for(var/obj/O in loc)
		if(O.density && !istype(O, /obj/structure/window))
			return 1
	return 0

/proc/sign(x)
	return x!=0?x/abs(x):0

/proc/getline(atom/M,atom/N)//Ultra-Fast Bresenham Line-Drawing Algorithm
	var/px=M.x		//starting x
	var/py=M.y
	var/line[] = list(locate(px,py,M.z))
	var/dx=N.x-px	//x distance
	var/dy=N.y-py
	var/dxabs=abs(dx)//Absolute value of x distance
	var/dyabs=abs(dy)
	var/sdx=sign(dx)	//Sign of x distance (+ or -)
	var/sdy=sign(dy)
	var/x=dxabs>>1	//Counters for steps taken, setting to distance/2
	var/y=dyabs>>1	//Bit-shifting makes me l33t.  It also makes getline() unnessecarrily fast.
	var/j			//Generic integer for counting
	if(dxabs>=dyabs)	//x distance is greater than y
		for(j=0;j<dxabs;j++)//It'll take dxabs steps to get there
			y+=dyabs
			if(y>=dxabs)	//Every dyabs steps, step once in y direction
				y-=dxabs
				py+=sdy
			px+=sdx		//Step on in x direction
			line+=locate(px,py,M.z)//Add the turf to the list
	else
		for(j=0;j<dyabs;j++)
			x+=dxabs
			if(x>=dyabs)
				x-=dyabs
				px+=sdx
			py+=sdy
			line+=locate(px,py,M.z)
	return line

//Returns whether or not a player is a guest using their ckey as an input
/proc/IsGuestKey(key)
	if (findtext(key, "Guest-", 1, 7) != 1) //was findtextEx
		return 0

	var/i = 7, ch, len = length(key)

	if(copytext(key, 7, 8) == "W") //webclient
		i++

	for (, i <= len, ++i)
		ch = text2ascii(key, i)
		if (ch < 48 || ch > 57)
			return 0
	return 1

//Ensure the frequency is within bounds of what it should be sending/recieving at
/proc/sanitize_frequency(var/f)
	f = round(f)
	f = max(1441, f) // 144.1
	f = min(1489, f) // 148.9
	if ((f % 2) == 0) //Ensure the last digit is an odd number
		f += 1
	return f

//Turns 1479 into 147.9
/proc/format_frequency(var/f)
	return "[round(f / 10)].[f % 10]"



//This will update a mob's name, real_name, mind.name, data_core records, pda and id
//Calling this proc without an oldname will only update the mob and skip updating the pda, id and records ~Carn
/mob/proc/fully_replace_character_name(var/oldname,var/newname)
	if(!newname)	return 0
	real_name = newname
	name = newname
	if(mind)
		mind.name = newname
	if(dna)
		dna.real_name = real_name

	if(oldname)
		//update the datacore records! This is goig to be a bit costly.
		for(var/list/L in list(data_core.general,data_core.medical,data_core.security,data_core.locked))
			for(var/datum/data/record/R in L)
				if(R.fields["name"] == oldname)
					R.fields["name"] = newname
					break

		//update our pda and id if we have them on our person
		var/list/searching = GetAllContents(searchDepth = 3)
		var/search_id = 1
		var/search_pda = 1

		for(var/A in searching)
			if( search_id && istype(A,/obj/item/weapon/card/id) )
				var/obj/item/weapon/card/id/ID = A
				if(ID.registered_name == oldname)
					ID.registered_name = newname
					ID.name = "[newname]'s ID Card ([ID.assignment])"
					if(!search_pda)	break
					search_id = 0

			else if( search_pda && istype(A,/obj/item/device/pda) )
				var/obj/item/device/pda/PDA = A
				if(PDA.owner == oldname)
					PDA.owner = newname
					PDA.name = "PDA-[newname] ([PDA.ownjob])"
					if(!search_id)	break
					search_pda = 0
	return 1



//Generalised helper proc for letting mobs rename themselves. Used to be clname() and ainame()
//Last modified by Carn
/mob/proc/rename_self(var/role, var/allow_numbers=0)
	spawn(0)
		var/oldname = real_name

		var/time_passed = world.time
		var/newname

		for(var/i=1,i<=3,i++)	//we get 3 attempts to pick a suitable name.
			newname = input(src,"You are \a [role]. Would you like to change your name to something else?", "Name change",oldname) as text
			if((world.time-time_passed)>3000)
				return	//took too long
			newname = sanitizeName(newname, ,allow_numbers)	//returns null if the name doesn't meet some basic requirements. Tidies up a few other things like bad-characters.

			for(var/mob/living/M in player_list)
				if(M == src)
					continue
				if(!newname || M.real_name == newname)
					newname = null
					break
			if(newname)
				break	//That's a suitable name!
			src << "Sorry, that [role]-name wasn't appropriate, please try another. It's possibly too long/short, has bad characters or is already taken."

		if(!newname)	//we'll stick with the oldname then
			return

		if(cmptext("ai",role))
			if(isAI(src))
				var/mob/living/silicon/ai/A = src
				oldname = null//don't bother with the records update crap
				//world << "<b>[newname] is the AI!</b>"
				//world << sound('sound/AI/newAI.ogg')
				// Set eyeobj name
				A.SetName(newname)


		fully_replace_character_name(oldname,newname)



//Picks a string of symbols to display as the law number for hacked or ion laws
/proc/ionnum()
	return "[pick("1","2","3","4","5","6","7","8","9","0")][pick("!","@","#","$","%","^","&","*")][pick("!","@","#","$","%","^","&","*")][pick("!","@","#","$","%","^","&","*")]"

//When an AI is activated, it can choose from a list of non-slaved borgs to have as a slave.
/proc/freeborg()
	var/select = null
	var/list/borgs = list()
	for (var/mob/living/silicon/robot/A in player_list)
		if (A.stat == 2 || A.connected_ai || A.scrambledcodes || istype(A,/mob/living/silicon/robot/drone))
			continue
		var/name = "[A.real_name] ([A.modtype] [A.braintype])"
		borgs[name] = A

	if (borgs.len)
		select = input("Unshackled borg signals detected:", "Borg selection", null, null) as null|anything in borgs
		return borgs[select]

//When a borg is activated, it can choose which AI it wants to be slaved to
/proc/active_ais()
	. = list()
	for(var/mob/living/silicon/ai/A in living_mob_list)
		if(A.stat == DEAD)
			continue
		if(A.control_disabled == 1)
			continue
		. += A
	return .

//Find an active ai with the least borgs. VERBOSE PROCNAME HUH!
/proc/select_active_ai_with_fewest_borgs()
	var/mob/living/silicon/ai/selected
	var/list/active = active_ais()
	for(var/mob/living/silicon/ai/A in active)
		if(!selected || (selected.connected_robots.len > A.connected_robots.len))
			selected = A

	return selected

/proc/select_active_ai(var/mob/user)
	var/list/ais = active_ais()
	if(ais.len)
		if(user)	. = input(usr,"AI signals detected:", "AI selection") in ais
		else		. = pick(ais)
	return .

/proc/get_sorted_mobs()
	var/list/old_list = getmobs()
	var/list/AI_list = list()
	var/list/Dead_list = list()
	var/list/keyclient_list = list()
	var/list/key_list = list()
	var/list/logged_list = list()
	for(var/named in old_list)
		var/mob/M = old_list[named]
		if(issilicon(M))
			AI_list |= M
		else if(isobserver(M) || M.stat == 2)
			Dead_list |= M
		else if(M.key && M.client)
			keyclient_list |= M
		else if(M.key)
			key_list |= M
		else
			logged_list |= M
		old_list.Remove(named)
	var/list/new_list = list()
	new_list += AI_list
	new_list += keyclient_list
	new_list += key_list
	new_list += logged_list
	new_list += Dead_list
	return new_list

//Returns a list of all mobs with their name
/proc/getmobs()

	var/list/mobs = sortmobs()
	var/list/names = list()
	var/list/creatures = list()
	var/list/namecounts = list()
	for(var/mob/M in mobs)
		var/name = M.name
		if (name in names)
			namecounts[name]++
			name = "[name] ([namecounts[name]])"
		else
			names.Add(name)
			namecounts[name] = 1
		if (M.real_name && M.real_name != M.name)
			name += " \[[M.real_name]\]"
		if (M.stat == 2)
			if(isobserver(M))
				name += " \[ghost\]"
			else
				name += " \[dead\]"
		creatures[name] = M

	return creatures

//Orders mobs by type then by name
/proc/sortmobs()
	var/list/moblist = list()
	var/list/sortmob = sortAtom(mob_list)
	for(var/mob/observer/eye/M in sortmob)
		moblist.Add(M)
	for(var/mob/living/silicon/ai/M in sortmob)
		moblist.Add(M)
	for(var/mob/living/silicon/pai/M in sortmob)
		moblist.Add(M)
	for(var/mob/living/silicon/robot/M in sortmob)
		moblist.Add(M)
	for(var/mob/living/carbon/human/M in sortmob)
		moblist.Add(M)
	for(var/mob/living/carbon/brain/M in sortmob)
		moblist.Add(M)
	for(var/mob/living/carbon/alien/M in sortmob)
		moblist.Add(M)
	for(var/mob/observer/dead/M in sortmob)
		moblist.Add(M)
	for(var/mob/new_player/M in sortmob)
		moblist.Add(M)
	for(var/mob/living/carbon/slime/M in sortmob)
		moblist.Add(M)
	for(var/mob/living/simple_animal/M in sortmob)
		moblist.Add(M)
//	for(var/mob/living/silicon/hivebot/M in world)
//		mob_list.Add(M)
//	for(var/mob/living/silicon/hive_mainframe/M in world)
//		mob_list.Add(M)
	return moblist

//E = MC^2
/proc/convert2energy(var/M)
	var/E = M*(SPEED_OF_LIGHT_SQ)
	return E

//M = E/C^2
/proc/convert2mass(var/E)
	var/M = E/(SPEED_OF_LIGHT_SQ)
	return M

/proc/cmp_numeric_dsc(a,b)
	return b - a

/proc/cmp_numeric_asc(a,b)
	return a - b

/proc/cmp_text_asc(a,b)
	return sorttext(b,a)

	//These are macros used to reduce on proc calls
#define fetchElement(L, i) (associative) ? L[L[i]] : L[i]

	//Minimum sized sequence that will be merged. Anything smaller than this will use binary-insertion sort.
	//Should be a power of 2
#define MIN_MERGE 32

	//When we get into galloping mode, we stay there until both runs win less often than MIN_GALLOP consecutive times.
#define MIN_GALLOP 7

	//This is a global instance to allow much of this code to be reused. The interfaces are kept seperately
var/datum/sortInstance/sortInstance = new()
/datum/sortInstance
	//The array being sorted.
	var/list/L

	//The comparator proc-reference
	var/cmp = /proc/cmp_numeric_asc

	//whether we are sorting list keys (0: L[i]) or associated values (1: L[L[i]])
	var/associative = 0

	//This controls when we get *into* galloping mode.  It is initialized	to MIN_GALLOP.
	//The mergeLo and mergeHi methods nudge it higher for random data, and lower for highly structured data.
	var/minGallop = MIN_GALLOP

	//Stores information regarding runs yet to be merged.
	//Run i starts at runBase[i] and extends for runLen[i] elements.
	//runBase[i] + runLen[i] == runBase[i+1]
	//var/stackSize
	var/list/runBases = list()
	var/list/runLens = list()


	proc/timSort(start, end)
		runBases.Cut()
		runLens.Cut()

		var/remaining = end - start

		//If array is small, do a 'mini-TimSort' with no merges
		if(remaining < MIN_MERGE)
			var/initRunLen = countRunAndMakeAscending(start, end)
			binarySort(start, end, start+initRunLen)
			return

		//March over the array finding natural runs
		//Extend any short natural runs to runs of length minRun
		var/minRun = minRunLength(remaining)

		do
				//identify next run
			var/runLen = countRunAndMakeAscending(start, end)

				//if run is short, extend to min(minRun, remaining)
			if(runLen < minRun)
				var/force = (remaining <= minRun) ? remaining : minRun

				binarySort(start, start+force, start+runLen)
				runLen = force

				//add data about run to queue
			runBases.Add(start)
			runLens.Add(runLen)

				//maybe merge
			mergeCollapse()

				//Advance to find next run
			start += runLen
			remaining -= runLen

		while(remaining > 0)


			//Merge all remaining runs to complete sort
		//ASSERT(start == end)
		mergeForceCollapse();
		//ASSERT(runBases.len == 1)

			//reset minGallop, for successive calls
		minGallop = MIN_GALLOP

		return L

	/*
	Sorts the specified portion of the specified array using a binary
	insertion sort.  This is the best method for sorting small numbers
	of elements.  It requires O(n log n) compares, but O(n^2) data
	movement (worst case).

	If the initial part of the specified range is already sorted,
	this method can take advantage of it: the method assumes that the
	elements in range [lo,start) are already sorted

	lo		the index of the first element in the range to be sorted
	hi		the index after the last element in the range to be sorted
	start	the index of the first element in the range that is	not already known to be sorted
	*/
	proc/binarySort(lo, hi, start)
		//ASSERT(lo <= start && start <= hi)
		if(start <= lo)
			start = lo + 1

		for(,start < hi, ++start)
			var/pivot = fetchElement(L,start)

			//set left and right to the index where pivot belongs
			var/left = lo
			var/right = start
			//ASSERT(left <= right)

			//[lo, left) elements <= pivot < [right, start) elements
			//in other words, find where the pivot element should go using bisection search
			while(left < right)
				var/mid = (left + right) >> 1	//round((left+right)/2)
				if(call(cmp)(fetchElement(L,mid), pivot) > 0)
					right = mid
				else
					left = mid+1

			//ASSERT(left == right)
			moveElement(L, start, left)	//move pivot element to correct location in the sorted range

	/*
	Returns the length of the run beginning at the specified position and reverses the run if it is back-to-front

	A run is the longest ascending sequence with:
		a[lo] <= a[lo + 1] <= a[lo + 2] <= ...
	or the longest descending sequence with:
		a[lo] >  a[lo + 1] >  a[lo + 2] >  ...

	For its intended use in a stable mergesort, the strictness of the
	definition of "descending" is needed so that the call can safely
	reverse a descending sequence without violating stability.
	*/
	proc/countRunAndMakeAscending(lo, hi)
		//ASSERT(lo < hi)

		var/runHi = lo + 1
		if(runHi >= hi)
			return 1

		var/last = fetchElement(L,lo)
		var/current = fetchElement(L,runHi++)

		if(call(cmp)(current, last) < 0)
			while(runHi < hi)
				last = current
				current = fetchElement(L,runHi)
				if(call(cmp)(current, last) >= 0)
					break
				++runHi
			reverseRange(L, lo, runHi)
		else
			while(runHi < hi)
				last = current
				current = fetchElement(L,runHi)
				if(call(cmp)(current, last) < 0)
					break
				++runHi

		return runHi - lo

	//Returns the minimum acceptable run length for an array of the specified length.
	//Natural runs shorter than this will be extended with binarySort
	proc/minRunLength(n)
		//ASSERT(n >= 0)
		var/r = 0	//becomes 1 if any bits are shifted off
		while(n >= MIN_MERGE)
			r |= (n & 1)
			n >>= 1
		return n + r

	//Examines the stack of runs waiting to be merged and merges adjacent runs until the stack invariants are reestablished:
	//	runLen[i-3] > runLen[i-2] + runLen[i-1]
	//	runLen[i-2] > runLen[i-1]
	//This method is called each time a new run is pushed onto the stack.
	//So the invariants are guaranteed to hold for i<stackSize upon entry to the method
	proc/mergeCollapse()
		while(runBases.len >= 2)
			var/n = runBases.len - 1
			if(n > 1 && runLens[n-1] <= runLens[n] + runLens[n+1])
				if(runLens[n-1] < runLens[n+1])
					--n
				mergeAt(n)
			else if(runLens[n] <= runLens[n+1])
				mergeAt(n)
			else
				break	//Invariant is established


	//Merges all runs on the stack until only one remains.
	//Called only once, to finalise the sort
	proc/mergeForceCollapse()
		while(runBases.len >= 2)
			var/n = runBases.len - 1
			if(n > 1 && runLens[n-1] < runLens[n+1])
				--n
			mergeAt(n)


	//Merges the two consecutive runs at stack indices i and i+1
	//Run i must be the penultimate or antepenultimate run on the stack
	//In other words, i must be equal to stackSize-2 or stackSize-3
	proc/mergeAt(i)
		//ASSERT(runBases.len >= 2)
		//ASSERT(i >= 1)
		//ASSERT(i == runBases.len - 1 || i == runBases.len - 2)

		var/base1 = runBases[i]
		var/base2 = runBases[i+1]
		var/len1 = runLens[i]
		var/len2 = runLens[i+1]

		//ASSERT(len1 > 0 && len2 > 0)
		//ASSERT(base1 + len1 == base2)

		//Record the legth of the combined runs. If i is the 3rd last run now, also slide over the last run
		//(which isn't involved in this merge). The current run (i+1) goes away in any case.
		runLens[i] += runLens[i+1]
		runLens.Cut(i+1, i+2)
		runBases.Cut(i+1, i+2)


		//Find where the first element of run2 goes in run1.
		//Prior elements in run1 can be ignored (because they're already in place)
		var/k = gallopRight(fetchElement(L,base2), base1, len1, 0)
		//ASSERT(k >= 0)
		base1 += k
		len1 -= k
		if(len1 == 0)
			return

		//Find where the last element of run1 goes in run2.
		//Subsequent elements in run2 can be ignored (because they're already in place)
		len2 = gallopLeft(fetchElement(L,base1 + len1 - 1), base2, len2, len2-1)
		//ASSERT(len2 >= 0)
		if(len2 == 0)
			return

		//Merge remaining runs, using tmp array with min(len1, len2) elements
		if(len1 <= len2)
			mergeLo(base1, len1, base2, len2)
		else
			mergeHi(base1, len1, base2, len2)


	/*
		Locates the position to insert key within the specified sorted range
		If the range contains elements equal to key, this will return the index of the LEFTMOST of those elements

		key		the element to be inserted into the sorted range
		base	the index of the first element of the sorted range
		len		the length of the sorted range, must be greater than 0
		hint	the offset from base at which to begin the search, such that 0 <= hint < len; i.e. base <= hint < base+hint

		Returns the index at which to insert element 'key'
	*/
	proc/gallopLeft(key, base, len, hint)
		//ASSERT(len > 0 && hint >= 0 && hint < len)

		var/lastOffset = 0
		var/offset = 1
		if(call(cmp)(key, fetchElement(L,base+hint)) > 0)
			var/maxOffset = len - hint
			while(offset < maxOffset && call(cmp)(key, fetchElement(L,base+hint+offset)) > 0)
				lastOffset = offset
				offset = (offset << 1) + 1

			if(offset > maxOffset)
				offset = maxOffset

			lastOffset += hint
			offset += hint

		else
			var/maxOffset = hint + 1
			while(offset < maxOffset && call(cmp)(key, fetchElement(L,base+hint-offset)) <= 0)
				lastOffset = offset
				offset = (offset << 1) + 1

			if(offset > maxOffset)
				offset = maxOffset

			var/temp = lastOffset
			lastOffset = hint - offset
			offset = hint - temp

			//ASSERT(-1 <= lastOffset && lastOffset < offset && offset <= len)

		//Now L[base+lastOffset] < key <= L[base+offset], so key belongs somewhere to the right of lastOffset but no farther than
		//offset. Do a binary search with invariant L[base+lastOffset-1] < key <= L[base+offset]
		++lastOffset
		while(lastOffset < offset)
			var/m = lastOffset + ((offset - lastOffset) >> 1)

			if(call(cmp)(key, fetchElement(L,base+m)) > 0)
				lastOffset = m + 1
			else
				offset = m

		//ASSERT(lastOffset == offset)
		return offset

	/**
	 * Like gallopLeft, except that if the range contains an element equal to
	 * key, gallopRight returns the index after the rightmost equal element.
	 *
	 * @param key the key whose insertion point to search for
	 * @param a the array in which to search
	 * @param base the index of the first element in the range
	 * @param len the length of the range; must be > 0
	 * @param hint the index at which to begin the search, 0 <= hint < n.
	 *	 The closer hint is to the result, the faster this method will run.
	 * @param c the comparator used to order the range, and to search
	 * @return the int k,  0 <= k <= n such that a[b + k - 1] <= key < a[b + k]
	 */
	proc/gallopRight(key, base, len, hint)
		//ASSERT(len > 0 && hint >= 0 && hint < len)

		var/offset = 1
		var/lastOffset = 0
		if(call(cmp)(key, fetchElement(L,base+hint)) < 0)	//key <= L[base+hint]
			var/maxOffset = hint + 1	//therefore we want to insert somewhere in the range [base,base+hint] = [base+,base+(hint+1))
			while(offset < maxOffset && call(cmp)(key, fetchElement(L,base+hint-offset)) < 0)	//we are iterating backwards
				lastOffset = offset
				offset = (offset << 1) + 1	//1 3 7 15
				//if(offset <= 0)	//int overflow, not an issue here since we are using floats
				//	offset = maxOffset

			if(offset > maxOffset)
				offset = maxOffset

			var/temp = lastOffset
			lastOffset = hint - offset
			offset = hint - temp

		else	//key > L[base+hint]
			var/maxOffset = len - hint	//therefore we want to insert somewhere in the range (base+hint,base+len) = [base+hint+1, base+hint+(len-hint))
			while(offset < maxOffset && call(cmp)(key, fetchElement(L,base+hint+offset)) >= 0)
				lastOffset = offset
				offset = (offset << 1) + 1
				//if(offset <= 0)	//int overflow, not an issue here since we are using floats
				//	offset = maxOffset

			if(offset > maxOffset)
				offset = maxOffset

			lastOffset += hint
			offset += hint

		//ASSERT(-1 <= lastOffset && lastOffset < offset && offset <= len)

		++lastOffset
		while(lastOffset < offset)
			var/m = lastOffset + ((offset - lastOffset) >> 1)

			if(call(cmp)(key, fetchElement(L,base+m)) < 0)	//key <= L[base+m]
				offset = m
			else							//key > L[base+m]
				lastOffset = m + 1

		//ASSERT(lastOffset == offset)

		return offset


	//Merges two adjacent runs in-place in a stable fashion.
	//For performance this method should only be called when len1 <= len2!
	proc/mergeLo(base1, len1, base2, len2)
		//ASSERT(len1 > 0 && len2 > 0 && base1 + len1 == base2)

		var/cursor1 = base1
		var/cursor2 = base2

		//degenerate cases
		if(len2 == 1)
			moveElement(L, cursor2, cursor1)
			return

		if(len1 == 1)
			moveElement(L, cursor1, cursor2+len2)
			return


		//Move first element of second run
		moveElement(L, cursor2++, cursor1++)
		--len2

		outer:
			while(1)
				var/count1 = 0	//# of times in a row that first run won
				var/count2 = 0	//	"	"	"	"	"	"  second run won

				//do the straightfoward thin until one run starts winning consistently

				do
					//ASSERT(len1 > 1 && len2 > 0)
					if(call(cmp)(fetchElement(L,cursor2), fetchElement(L,cursor1)) < 0)
						moveElement(L, cursor2++, cursor1++)
						--len2

						++count2
						count1 = 0

						if(len2 == 0)
							break outer
					else
						++cursor1

						++count1
						count2 = 0

						if(--len1 == 1)
							break outer

				while((count1 | count2) < minGallop)


				//one run is winning consistently so galloping may provide huge benifits
				//so try galloping, until such time as the run is no longer consistently winning
				do
					//ASSERT(len1 > 1 && len2 > 0)

					count1 = gallopRight(fetchElement(L,cursor2), cursor1, len1, 0)
					if(count1)
						cursor1 += count1
						len1 -= count1

						if(len1 <= 1)
							break outer

					moveElement(L, cursor2, cursor1)
					++cursor2
					++cursor1
					if(--len2 == 0)
						break outer

					count2 = gallopLeft(fetchElement(L,cursor1), cursor2, len2, 0)
					if(count2)
						moveRange(L, cursor2, cursor1, count2)

						cursor2 += count2
						cursor1 += count2
						len2 -= count2

						if(len2 == 0)
							break outer

					++cursor1
					if(--len1 == 1)
						break outer

					--minGallop

				while((count1|count2) > MIN_GALLOP)

				if(minGallop < 0)
					minGallop = 0
				minGallop += 2;  // Penalize for leaving gallop mode


		if(len1 == 1)
			//ASSERT(len2 > 0)
			moveElement(L, cursor1, cursor2+len2)

		//else
			//ASSERT(len2 == 0)
			//ASSERT(len1 > 1)


	proc/mergeHi(base1, len1, base2, len2)
		//ASSERT(len1 > 0 && len2 > 0 && base1 + len1 == base2)

		var/cursor1 = base1 + len1 - 1	//start at end of sublists
		var/cursor2 = base2 + len2 - 1

		//degenerate cases
		if(len2 == 1)
			moveElement(L, base2, base1)
			return

		if(len1 == 1)
			moveElement(L, base1, cursor2+1)
			return

		moveElement(L, cursor1--, cursor2-- + 1)
		--len1

		outer:
			while(1)
				var/count1 = 0	//# of times in a row that first run won
				var/count2 = 0	//	"	"	"	"	"	"  second run won

				//do the straightfoward thing until one run starts winning consistently
				do
					//ASSERT(len1 > 0 && len2 > 1)
					if(call(cmp)(fetchElement(L,cursor2), fetchElement(L,cursor1)) < 0)
						moveElement(L, cursor1--, cursor2-- + 1)
						--len1

						++count1
						count2 = 0

						if(len1 == 0)
							break outer
					else
						--cursor2
						--len2

						++count2
						count1 = 0

						if(len2 == 1)
							break outer
				while((count1 | count2) < minGallop)

				//one run is winning consistently so galloping may provide huge benifits
				//so try galloping, until such time as the run is no longer consistently winning
				do
					//ASSERT(len1 > 0 && len2 > 1)

					count1 = len1 - gallopRight(fetchElement(L,cursor2), base1, len1, len1-1)	//should cursor1 be base1?
					if(count1)
						cursor1 -= count1

						moveRange(L, cursor1+1, cursor2+1, count1)	//cursor1+1 == cursor2 by definition

						cursor2 -= count1
						len1 -= count1

						if(len1 == 0)
							break outer

					--cursor2

					if(--len2 == 1)
						break outer

					count2 = len2 - gallopLeft(fetchElement(L,cursor1), cursor1+1, len2, len2-1)
					if(count2)
						cursor2 -= count2
						len2 -= count2

						if(len2 <= 1)
							break outer

					moveElement(L, cursor1--, cursor2-- + 1)
					--len1

					if(len1 == 0)
						break outer

					--minGallop
				while((count1|count2) > MIN_GALLOP)

				if(minGallop < 0)
					minGallop = 0
				minGallop += 2	// Penalize for leaving gallop mode

		if(len2 == 1)
			//ASSERT(len1 > 0)

			cursor1 -= len1
			moveRange(L, cursor1+1, cursor2+1, len1)

		//else
			//ASSERT(len1 == 0)
			//ASSERT(len2 > 0)


	proc/mergeSort(start, end)
		var/remaining = end - start

		//If array is small, do an insertion sort
		if(remaining < MIN_MERGE)
			//var/initRunLen = countRunAndMakeAscending(start, end)
			binarySort(start, end, start/*+initRunLen*/)
			return

		var/minRun = minRunLength(remaining)

		do
			var/runLen = (remaining <= minRun) ? remaining : minRun

			binarySort(start, start+runLen, start)

			//add data about run to queue
			runBases.Add(start)
			runLens.Add(runLen)

			//Advance to find next run
			start += runLen
			remaining -= runLen

		while(remaining > 0)

		while(runBases.len >= 2)
			var/n = runBases.len - 1
			if(n > 1 && runLens[n-1] <= runLens[n] + runLens[n+1])
				if(runLens[n-1] < runLens[n+1])
					--n
				mergeAt2(n)
			else if(runLens[n] <= runLens[n+1])
				mergeAt2(n)
			else
				break	//Invariant is established

		while(runBases.len >= 2)
			var/n = runBases.len - 1
			if(n > 1 && runLens[n-1] < runLens[n+1])
				--n
			mergeAt2(n)

		return L

	proc/mergeAt2(i)
		var/cursor1 = runBases[i]
		var/cursor2 = runBases[i+1]

		var/end1 = cursor1+runLens[i]
		var/end2 = cursor2+runLens[i+1]

		var/val1 = fetchElement(L,cursor1)
		var/val2 = fetchElement(L,cursor2)

		while(1)
			if(call(cmp)(val1,val2) < 0)
				if(++cursor1 >= end1)
					break
				val1 = fetchElement(L,cursor1)
			else
				moveElement(L,cursor2,cursor1)

				++cursor2
				if(++cursor2 >= end2)
					break
				++end1
				++cursor1
				//if(++cursor1 >= end1)
				//	break

				val2 = fetchElement(L,cursor2)


		//Record the legth of the combined runs. If i is the 3rd last run now, also slide over the last run
		//(which isn't involved in this merge). The current run (i+1) goes away in any case.
		runLens[i] += runLens[i+1]
		runLens.Cut(i+1, i+2)
		runBases.Cut(i+1, i+2)

#undef MIN_GALLOP
#undef MIN_MERGE

#undef fetchElement


/proc/sortTim(list/L, cmp=/proc/cmp_numeric_asc, associative, fromIndex=1, toIndex=0)
	if(L && L.len >= 2)
		fromIndex = fromIndex % L.len
		toIndex = toIndex % (L.len+1)
		if(fromIndex <= 0)
			fromIndex += L.len
		if(toIndex <= 0)
			toIndex += L.len + 1

		sortInstance.L = L
		sortInstance.cmp = cmp
		sortInstance.associative = associative

		sortInstance.timSort(fromIndex, toIndex)

	return L

//Forces a variable to be posative
/proc/modulus(var/M)
	if(M >= 0)
		return M
	if(M < 0)
		return -M

// returns the turf located at the map edge in the specified direction relative to A
// used for mass driver
/proc/get_edge_target_turf(var/atom/A, var/direction)

	var/turf/target = locate(A.x, A.y, A.z)
	if(!A || !target)
		return 0
		//since NORTHEAST == NORTH & EAST, etc, doing it this way allows for diagonal mass drivers in the future
		//and isn't really any more complicated

		// Note diagonal directions won't usually be accurate
	if(direction & NORTH)
		target = locate(target.x, world.maxy, target.z)
	if(direction & SOUTH)
		target = locate(target.x, 1, target.z)
	if(direction & EAST)
		target = locate(world.maxx, target.y, target.z)
	if(direction & WEST)
		target = locate(1, target.y, target.z)

	return target

// returns turf relative to A in given direction at set range
// result is bounded to map size
// note range is non-pythagorean
// used for disposal system
/proc/get_ranged_target_turf(var/atom/A, var/direction, var/range)

	var/x = A.x
	var/y = A.y
	if(direction & NORTH)
		y = min(world.maxy, y + range)
	if(direction & SOUTH)
		y = max(1, y - range)
	if(direction & EAST)
		x = min(world.maxx, x + range)
	if(direction & WEST)
		x = max(1, x - range)

	return locate(x,y,A.z)


// returns turf relative to A offset in dx and dy tiles
// bound to map limits
/proc/get_offset_target_turf(var/atom/A, var/dx, var/dy)
	var/x = min(world.maxx, max(1, A.x + dx))
	var/y = min(world.maxy, max(1, A.y + dy))
	return locate(x,y,A.z)

//Makes sure MIDDLE is between LOW and HIGH. If not, it adjusts it. Returns the adjusted value. Lower bound takes priority.
/proc/between(var/low, var/middle, var/high)
	return max(min(middle, high), low)

proc/arctan(x)
	var/y=arcsin(x/sqrt(1+x*x))
	return y

//returns random gauss number
proc/GaussRand(var/sigma)
	var/x,y,rsq
	do
		x=2*rand()-1
		y=2*rand()-1
		rsq=x*x+y*y
	while(rsq>1 || !rsq)
	return sigma*y*sqrt(-2*log(rsq)/rsq)

//returns random gauss number, rounded to 'roundto'
proc/GaussRandRound(var/sigma,var/roundto)
	return round(GaussRand(sigma),roundto)

//Will return the contents of an atom recursivly to a depth of 'searchDepth'
/atom/proc/GetAllContents(searchDepth = 5)
	var/list/toReturn = list()

	for(var/atom/part in contents)
		toReturn += part
		if(part.contents.len && searchDepth)
			toReturn += part.GetAllContents(searchDepth - 1)

	return toReturn

//Step-towards method of determining whether one atom can see another. Similar to viewers()
/proc/can_see(var/atom/source, var/atom/target, var/length=5) // I couldnt be arsed to do actual raycasting :I This is horribly inaccurate.
	var/turf/current = get_turf(source)
	var/turf/target_turf = get_turf(target)
	var/steps = 0

	while(current != target_turf)
		if(steps > length) return 0
		if(current.opacity) return 0
		for(var/atom/A in current)
			if(A.opacity) return 0
		current = get_step_towards(current, target_turf)
		steps++

	return 1

/proc/is_blocked_turf(var/turf/T)
	var/cant_pass = 0
	if(T.density) cant_pass = 1
	for(var/atom/A in T)
		if(A.density)//&&A.anchored
			cant_pass = 1
	return cant_pass

/proc/get_step_towards2(var/atom/ref , var/atom/trg)
	var/base_dir = get_dir(ref, get_step_towards(ref,trg))
	var/turf/temp = get_step_towards(ref,trg)

	if(is_blocked_turf(temp))
		var/dir_alt1 = turn(base_dir, 90)
		var/dir_alt2 = turn(base_dir, -90)
		var/turf/turf_last1 = temp
		var/turf/turf_last2 = temp
		var/free_tile = null
		var/breakpoint = 0

		while(!free_tile && breakpoint < 10)
			if(!is_blocked_turf(turf_last1))
				free_tile = turf_last1
				break
			if(!is_blocked_turf(turf_last2))
				free_tile = turf_last2
				break
			turf_last1 = get_step(turf_last1,dir_alt1)
			turf_last2 = get_step(turf_last2,dir_alt2)
			breakpoint++

		if(!free_tile) return get_step(ref, base_dir)
		else return get_step_towards(ref,free_tile)

	else return get_step(ref, base_dir)

//Takes: Anything that could possibly have variables and a varname to check.
//Returns: 1 if found, 0 if not.
/proc/hasvar(var/datum/A, var/varname)
	if(A.vars.Find(lowertext(varname))) return 1
	else return 0

//Returns: all the areas in the world
/proc/return_areas()
	var/list/area/areas = list()
	for(var/area/A in world)
		areas += A
	return areas

//Returns: all the areas in the world, sorted.
/proc/return_sorted_areas()
	return sortAtom(return_areas())

//Takes: Area type as text string or as typepath OR an instance of the area.
//Returns: A list of all areas of that type in the world.
/proc/get_areas(var/areatype)
	if(!areatype) return null
	if(istext(areatype)) areatype = text2path(areatype)
	if(isarea(areatype))
		var/area/areatemp = areatype
		areatype = areatemp.type

	var/list/areas = new/list()
	for(var/area/N in world)
		if(istype(N, areatype)) areas += N
	return areas

//Takes: Area type as text string or as typepath OR an instance of the area.
//Returns: A list of all turfs in areas of that type of that type in the world.
/proc/get_area_turfs(var/areatype)
	if(!areatype) return null
	if(istext(areatype)) areatype = text2path(areatype)
	if(isarea(areatype))
		var/area/areatemp = areatype
		areatype = areatemp.type

	var/list/turfs = new/list()
	for(var/area/N in world)
		if(istype(N, areatype))
			for(var/turf/T in N) turfs += T
	return turfs

//Takes: Area type as text string or as typepath OR an instance of the area.
//Returns: A list of all atoms	(objs, turfs, mobs) in areas of that type of that type in the world.
/proc/get_area_all_atoms(var/areatype)
	if(!areatype) return null
	if(istext(areatype)) areatype = text2path(areatype)
	if(isarea(areatype))
		var/area/areatemp = areatype
		areatype = areatemp.type

	var/list/atoms = new/list()
	for(var/area/N in world)
		if(istype(N, areatype))
			for(var/atom/A in N)
				atoms += A
	return atoms

/datum/coords //Simple datum for storing coordinates.
	var/x_pos = null
	var/y_pos = null
	var/z_pos = null

/area/proc/move_contents_to(var/area/A, var/turftoleave=null, var/direction = null)
	//Takes: Area. Optional: turf type to leave behind.
	//Returns: Nothing.
	//Notes: Attempts to move the contents of one area to another area.
	//       Movement based on lower left corner. Tiles that do not fit
	//		 into the new area will not be moved.

	if(!A || !src) return 0

	var/list/turfs_src = get_area_turfs(src.type)
	var/list/turfs_trg = get_area_turfs(A.type)

	var/src_min_x = 0
	var/src_min_y = 0
	for (var/turf/T in turfs_src)
		if(T.x < src_min_x || !src_min_x) src_min_x	= T.x
		if(T.y < src_min_y || !src_min_y) src_min_y	= T.y

	var/trg_min_x = 0
	var/trg_min_y = 0
	for (var/turf/T in turfs_trg)
		if(T.x < trg_min_x || !trg_min_x) trg_min_x	= T.x
		if(T.y < trg_min_y || !trg_min_y) trg_min_y	= T.y

	var/list/refined_src = new/list()
	for(var/turf/T in turfs_src)
		refined_src += T
		refined_src[T] = new/datum/coords
		var/datum/coords/C = refined_src[T]
		C.x_pos = (T.x - src_min_x)
		C.y_pos = (T.y - src_min_y)

	var/list/refined_trg = new/list()
	for(var/turf/T in turfs_trg)
		refined_trg += T
		refined_trg[T] = new/datum/coords
		var/datum/coords/C = refined_trg[T]
		C.x_pos = (T.x - trg_min_x)
		C.y_pos = (T.y - trg_min_y)

	var/list/fromupdate = new/list()
	var/list/toupdate = new/list()

	moving:
		for (var/turf/T in refined_src)
			var/datum/coords/C_src = refined_src[T]
			for (var/turf/B in refined_trg)
				var/datum/coords/C_trg = refined_trg[B]
				if(C_src.x_pos == C_trg.x_pos && C_src.y_pos == C_trg.y_pos)

					var/old_dir1 = T.dir
					var/old_icon_state1 = T.icon_state
					var/old_icon1 = T.icon

					var/turf/X = B.ChangeTurf(T.type)
					X.set_dir(old_dir1)
					X.icon_state = old_icon_state1
					X.icon = old_icon1 //Shuttle floors are in shuttle.dmi while the defaults are floors.dmi

					var/turf/simulated/ST = T
					if(istype(ST) && ST.zone)
						var/turf/simulated/SX = X
						if(!SX.air)
							SX.make_air()
						SX.air.copy_from(ST.zone.air)
						ST.zone.remove(ST)

					/* Quick visual fix for some weird shuttle corner artefacts when on transit space tiles */
					if(direction && findtext(X.icon_state, "swall_s"))

						// Spawn a new shuttle corner object
						var/obj/corner = new()
						corner.loc = X
						corner.density = 1
						corner.anchored = 1
						corner.icon = X.icon
						corner.icon_state = replacetext(X.icon_state, "_s", "_f")
						corner.tag = "delete me"
						corner.name = "wall"

						// Find a new turf to take on the property of
						var/turf/nextturf = get_step(corner, direction)
						if(!nextturf || !istype(nextturf, /turf/space))
							nextturf = get_step(corner, turn(direction, 180))


						// Take on the icon of a neighboring scrolling space icon
						X.icon = nextturf.icon
						X.icon_state = nextturf.icon_state


					for(var/obj/O in T)

						// Reset the shuttle corners
						if(O.tag == "delete me")
							X.icon = 'icons/turf/shuttle.dmi'
							X.icon_state = replacetext(O.icon_state, "_f", "_s") // revert the turf to the old icon_state
							X.name = "wall"
							qdel(O) // prevents multiple shuttle corners from stacking
							continue
						if(!istype(O,/obj)) continue
						O.loc = X
					for(var/mob/M in T)
						if(!istype(M,/mob) || isEye(M)) continue // If we need to check for more mobs, I'll add a variable
						M.loc = X

//					var/area/AR = X.loc

//					if(AR.lighting_use_dynamic)							//TODO: rewrite this code so it's not messed by lighting ~Carn
//						X.opacity = !X.opacity
//						X.SetOpacity(!X.opacity)

					toupdate += X

					if(turftoleave)
						fromupdate += T.ChangeTurf(turftoleave)
					else
						T.ChangeTurf(/turf/space)

					refined_src -= T
					refined_trg -= B
					continue moving


proc/DuplicateObject(obj/original, var/perfectcopy = 0 , var/sameloc = 0)
	if(!original)
		return null

	var/obj/O = null

	if(sameloc)
		O=new original.type(original.loc)
	else
		O=new original.type(locate(0,0,0))

	if(perfectcopy)
		if((O) && (original))
			for(var/V in original.vars)
				if(!(V in list("type","loc","locs","vars", "parent", "parent_type","verbs","ckey","key")))
					O.vars[V] = original.vars[V]
	return O


/area/proc/copy_contents_to(var/area/A , var/platingRequired = 0 )
	//Takes: Area. Optional: If it should copy to areas that don't have plating
	//Returns: Nothing.
	//Notes: Attempts to move the contents of one area to another area.
	//       Movement based on lower left corner. Tiles that do not fit
	//		 into the new area will not be moved.

	// Does *not* affect gases etc; copied turfs will be changed via ChangeTurf, and the dir, icon, and icon_state copied. All other vars will remain default.

	if(!A || !src) return 0

	var/list/turfs_src = get_area_turfs(src.type)
	var/list/turfs_trg = get_area_turfs(A.type)

	var/src_min_x = 0
	var/src_min_y = 0
	for (var/turf/T in turfs_src)
		if(T.x < src_min_x || !src_min_x) src_min_x	= T.x
		if(T.y < src_min_y || !src_min_y) src_min_y	= T.y

	var/trg_min_x = 0
	var/trg_min_y = 0
	for (var/turf/T in turfs_trg)
		if(T.x < trg_min_x || !trg_min_x) trg_min_x	= T.x
		if(T.y < trg_min_y || !trg_min_y) trg_min_y	= T.y

	var/list/refined_src = new/list()
	for(var/turf/T in turfs_src)
		refined_src += T
		refined_src[T] = new/datum/coords
		var/datum/coords/C = refined_src[T]
		C.x_pos = (T.x - src_min_x)
		C.y_pos = (T.y - src_min_y)

	var/list/refined_trg = new/list()
	for(var/turf/T in turfs_trg)
		refined_trg += T
		refined_trg[T] = new/datum/coords
		var/datum/coords/C = refined_trg[T]
		C.x_pos = (T.x - trg_min_x)
		C.y_pos = (T.y - trg_min_y)

	var/list/toupdate = new/list()

	var/copiedobjs = list()


	moving:
		for (var/turf/T in refined_src)
			var/datum/coords/C_src = refined_src[T]
			for (var/turf/B in refined_trg)
				var/datum/coords/C_trg = refined_trg[B]
				if(C_src.x_pos == C_trg.x_pos && C_src.y_pos == C_trg.y_pos)

					var/old_dir1 = T.dir
					var/old_icon_state1 = T.icon_state
					var/old_icon1 = T.icon

					if(platingRequired)
						if(istype(B, /turf/space))
							continue moving

					var/turf/X = B
					X.ChangeTurf(T.type)
					X.set_dir(old_dir1)
					X.icon_state = old_icon_state1
					X.icon = old_icon1 //Shuttle floors are in shuttle.dmi while the defaults are floors.dmi


					var/list/objs = new/list()
					var/list/newobjs = new/list()
					var/list/mobs = new/list()
					var/list/newmobs = new/list()

					for(var/obj/O in T)

						if(!istype(O,/obj))
							continue

						objs += O


					for(var/obj/O in objs)
						newobjs += DuplicateObject(O , 1)


					for(var/obj/O in newobjs)
						O.loc = X

					for(var/mob/M in T)

						if(!istype(M,/mob) || isEye(M)) continue // If we need to check for more mobs, I'll add a variable
						mobs += M

					for(var/mob/M in mobs)
						newmobs += DuplicateObject(M , 1)

					for(var/mob/M in newmobs)
						M.loc = X

					copiedobjs += newobjs
					copiedobjs += newmobs

//					var/area/AR = X.loc

//					if(AR.lighting_use_dynamic)
//						X.opacity = !X.opacity
//						X.sd_SetOpacity(!X.opacity)			//TODO: rewrite this code so it's not messed by lighting ~Carn

					toupdate += X

					refined_src -= T
					refined_trg -= B
					continue moving




	if(toupdate.len)
		for(var/turf/simulated/T1 in toupdate)
			air_master.mark_for_update(T1)

	return copiedobjs



proc/get_cardinal_dir(atom/A, atom/B)
	var/dx = abs(B.x - A.x)
	var/dy = abs(B.y - A.y)
	return get_dir(A, B) & (rand() * (dx+dy) < dy ? 3 : 12)

//chances are 1:value. anyprob(1) will always return true
proc/anyprob(value)
	return (rand(1,value)==value)

proc/view_or_range(distance = world.view , center = usr , type)
	switch(type)
		if("view")
			. = view(distance,center)
		if("range")
			. = range(distance,center)
	return

proc/oview_or_orange(distance = world.view , center = usr , type)
	switch(type)
		if("view")
			. = oview(distance,center)
		if("range")
			. = orange(distance,center)
	return

proc/get_mob_with_client_list()
	var/list/mobs = list()
	for(var/mob/M in mob_list)
		if (M.client)
			mobs += M
	return mobs


/proc/parse_zone(zone)
	switch(zone)
		if(BP_L_HAND) return "left hand"
		if(BP_R_HAND) return "right hand"
		if(BP_L_ARM)  return "left arm"
		if(BP_R_ARM)  return "right arm"
		if(BP_L_LEG)  return "left leg"
		if(BP_R_LEG)  return "right leg"
		if(BP_L_FOOT) return "left foot"
		if(BP_R_FOOT) return "right foot"
	return zone

/proc/get(atom/loc, type)
	while(loc)
		if(istype(loc, type))
			return loc
		loc = loc.loc
	return null

/proc/get_turf_or_move(turf/location)
	return get_turf(location)


//Quick type checks for some tools
var/global/list/common_tools = list(
	/obj/item/stack/cable_coil,
	/obj/item/weapon/wrench,
	/obj/item/weapon/weldingtool,
	/obj/item/weapon/screwdriver,
	/obj/item/weapon/wirecutters,
	/obj/item/device/multitool,
	/obj/item/weapon/crowbar
)

#define istool(O) is_type_in_list(O, common_tools)

#define iswrench(O) istype(O, /obj/item/weapon/wrench)

#define iswelder(O) istype(O, /obj/item/weapon/weldingtool)

#define iscoil(O) istype(O, /obj/item/stack/cable_coil)

#define iswirecutter(O) istype(O, /obj/item/weapon/wirecutters)

#define isscrewdriver(O) istype(O, /obj/item/weapon/screwdriver)

#define ismultitool(O) istype(O, /obj/item/device/multitool)

#define iscrowbar(O) istype(O, /obj/item/weapon/crowbar)

#define iswire(O) istype(O, /obj/item/stack/cable_coil)

proc/is_hot(obj/item/W as obj)
	switch(W.type)
		if(/obj/item/weapon/weldingtool)
			var/obj/item/weapon/weldingtool/WT = W
			if(WT.isOn())
				return 3800
			else
				return 0
		if(/obj/item/weapon/flame/lighter)
			if(W:lit)
				return 1500
			else
				return 0
		if(/obj/item/weapon/flame/match)
			if(W:lit)
				return 1000
			else
				return 0
		if(/obj/item/clothing/mask/smokable/cigarette)
			if(W:lit)
				return 1000
			else
				return 0
		if(/obj/item/weapon/pickaxe/plasmacutter)
			return 3800
		if(/obj/item/weapon/melee/energy)
			return 3500
		else
			return 0

	return 0

//Whether or not the given item counts as sharp in terms of dealing damage
/proc/is_sharp(obj/O as obj)
	if (!O) return 0
	if (O.sharp) return 1
	if (O.edge) return 1
	return 0

//Whether or not the given item counts as cutting with an edge in terms of removing limbs
/proc/has_edge(obj/O as obj)
	if (!O) return 0
	if (O.edge) return 1
	return 0

//Returns 1 if the given item is capable of popping things like balloons, inflatable barriers, or cutting police tape.
/proc/can_puncture(obj/item/W as obj)		// For the record, WHAT THE HELL IS THIS METHOD OF DOING IT?
	if(!W) return 0
	if(W.sharp) return 1
	return is_type_in_list(W, list(\
		/obj/item/weapon/screwdriver,
		/obj/item/weapon/pen,
		/obj/item/weapon/weldingtool,
		/obj/item/weapon/flame/lighter/zippo,
		/obj/item/weapon/flame/match,
		/obj/item/clothing/mask/smokable/cigarette,
		/obj/item/weapon/shovel \
	) )

//check if mob is lying down on something we can operate him on.
/proc/can_operate(mob/living/carbon/M)
	return M.lying && (\
		locate(/obj/machinery/optable, M.loc) || \
		(locate(/obj/structure/bed/roller, M.loc) && prob(75)) || \
		(locate(/obj/structure/table/, M.loc) && prob(66))\
	)

/proc/reverse_direction(var/dir)
	switch(dir)
		if(NORTH)
			return SOUTH
		if(NORTHEAST)
			return SOUTHWEST
		if(EAST)
			return WEST
		if(SOUTHEAST)
			return NORTHWEST
		if(SOUTH)
			return NORTH
		if(SOUTHWEST)
			return NORTHEAST
		if(WEST)
			return EAST
		if(NORTHWEST)
			return SOUTHEAST

/*
Checks if that loc and dir has a item on the wall
*/
var/list/WALLITEMS = list(
	/obj/machinery/power/apc, /obj/machinery/alarm, /obj/item/device/radio/intercom, /obj/structure/sign,
	/obj/structure/extinguisher_cabinet, /obj/structure/reagent_dispensers, /obj/machinery/light_switch,
	/obj/machinery/status_display, /obj/machinery/requests_console, /obj/machinery/embedded_controller,
	/obj/machinery/newscaster, /obj/machinery/firealarm, /obj/structure/noticeboard, /obj/machinery/button,
	/obj/machinery/computer/security/telescreen, /obj/machinery/keycard_auth, /obj/structure/closet/fireaxecabinet,
	/obj/item/weapon/storage/secure/safe, /obj/machinery/door_timer, /obj/machinery/flasher, /obj/structure/mirror,
	/obj/machinery/computer/security/telescreen/entertainment
)

/proc/gotwallitem(loc, dir)
	for(var/obj/O in loc)
		for(var/item in WALLITEMS)
			if(istype(O, item))
				//Direction works sometimes
				if(O.dir == dir)
					return 1

				//Some stuff doesn't use dir properly, so we need to check pixel instead
				switch(dir)
					if(SOUTH)
						if(O.pixel_y > 10)
							return 1
					if(NORTH)
						if(O.pixel_y < -10)
							return 1
					if(WEST)
						if(O.pixel_x > 10)
							return 1
					if(EAST)
						if(O.pixel_x < -10)
							return 1


	//Some stuff is placed directly on the wallturf (signs)
	for(var/obj/O in get_step(loc, dir))
		for(var/item in WALLITEMS)
			if(istype(O, text2path(item)))
				if(O.pixel_x == 0 && O.pixel_y == 0)
					return 1
	return 0

/proc/format_text(text)
	return replacetext(replacetext(text,"\proper ",""),"\improper ","")

/proc/topic_link(var/datum/D, var/arglist, var/content)
	if(istype(arglist,/list))
		arglist = list2params(arglist)
	return "<a href='?src=\ref[D];[arglist]'>[content]</a>"

/proc/get_random_colour(var/simple, var/lower, var/upper)
	var/colour
	if(simple)
		colour = pick(list("FF0000","FF7F00","FFFF00","00FF00","0000FF","4B0082","8F00FF"))
	else
		for(var/i=1;i<=3;i++)
			var/temp_col = "[num2hex(rand(lower,upper))]"
			if(length(temp_col )<2)
				temp_col  = "0[temp_col]"
			colour += temp_col
	return colour

var/mob/dview/dview_mob = new

//Version of view() which ignores darkness, because BYOND doesn't have it.
/proc/dview(var/range = world.view, var/center, var/invis_flags = 0)
	if(!center)
		return

	dview_mob.loc = center

	dview_mob.see_invisible = invis_flags

	. = view(range, dview_mob)
	dview_mob.loc = null

/mob/dview
	invisibility = 101
	density = 0

	anchored = 1
	simulated = 0

	see_in_dark = 1e6

/mob/dview/New()
	// do nothing. we don't want to be in any mob lists; we're a dummy not a mob.


// call to generate a stack trace and print to runtime logs
/proc/crash_with(msg)
	CRASH(msg)

//// Player-cap ////
/proc/living_player_count()
	var/living_player_count = 0
	for(var/mob in player_list)
		if(mob in living_mob_list)
			living_player_count += 1
	return living_player_count