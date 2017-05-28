/client/verb/sim_donate()
	set name = "Simulate donation"

	var/ckey = input("Ckey") as text
	var/money = input("Money") as num
	donations.donators[ckey] = money
	return

var/datum/donations/donations = new()

/datum/donations
	var/list/donat_categoryes = list()
	var/list/donators = list()
	var/donation_cached = ""

	New()
		build_prizes_list()

	proc/show(var/mob/user)
		if(!user.ckey || !user.client)
			return

		if(!user.ckey in donators) //It doesn't exist yet
			load_donator(user.ckey)

		var/dat = "<title>Donator panel</title>"
		dat += "You have [donators[user.ckey]]<br>"
		usr << browse(dat+donation_cached, "window=donatorpanel;size=250x400")

	Topic(href, href_list)
		var/datum/donat_stuff/item = locate(href_list["item"])
		if(!istype(item))
			return
		var/mob/living/carbon/human/user = usr
		var/ckey = user.ckey
		if(!istype(user) || user.stat)
			return

		var/money = donators[ckey]
		var/list/slots = list (
			"backpack" = slot_in_backpack,
			"left pocket" = slot_l_store,
			"right pocket" = slot_r_store,
			"left hand" = slot_l_hand,
			"right hand" = slot_r_hand,
		)

		if(item.cost > money)
			user << SPAN_WARN("You don't have enough funds.")
			return 0

		donators[ckey] = max(0, money - item.cost)

		var/obj/spawned = new item.path
		var/where = user.equip_in_one_of_slots(spawned, slots, del_on_fail=0)

		if (!where)
			spawned.loc = user.loc
			user << "<span class='info'>Your [spawned.name] has been spawned!</span>"
		else
			user << "<span class='info'>Your [spawned.name] has been spawned in your [where]!</span>"

		show(user)

	proc/load_donator(ckey)
		var/DBConnection/dbcon2 = new()
		dbcon2.Connect("dbi:mysql:forum2:[sqladdress]:[sqlport]","[sqlfdbklogin]","[sqlfdbkpass]")

		if(!dbcon2.IsConnected())
			world.log << "Failed to connect to database [dbcon2.ErrorMsg()] in load_donator([ckey])."
			diary << "Failed to connect to database in load_donator([ckey])."
			return 0

		var/DBQuery/query = dbcon2.NewQuery("SELECT round(sum) FROM Z_donators WHERE byond='[ckey]'")
		query.Execute()
		var/money = 0
		while(query.NextRow())
			money = round(text2num(query.item[1]))
		donators[ckey] = money
		dbcon2.Disconnect()
		return 1

	proc/build_prizes_list()
		for(var/path in subtypesof(/datum/donat_stuff))
			var/datum/donat_stuff/T = path
			if(!initial(T.name))
				continue
			T = new path
			if(!donat_categoryes[T.category])
				donat_categoryes[T.category] = list()
			donat_categoryes[T.category] += T

		donation_cached = null
		var/list/dat = list()
		for(var/cur_cat in donat_categoryes)
			dat += "<hr><b>[cur_cat]</b><br>"
			for(var/datum/donat_stuff/item in donat_categoryes[cur_cat])
				dat += "<a href='?src=\ref[src];item=\ref[item]'>[item.name] : [item.cost]</a><br>"
		donation_cached = jointext(dat, null)

/client
	var/next_donat_check = null

/client/verb/cmd_donator_panel()
	set name = "Donator panel"
	set category = "OOC"

	if(world.time < next_donat_check)
		return
	next_donat_check = world.time + 5


	if(!ticker || ticker.current_state < 3)
		alert("Please wait until game setting up!")
		return

	donations.show(mob)