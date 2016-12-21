var/list/donat_categoryes = list()
var/list/donators = list()
/*
/client/verb/sim_donate()
	set name = "Simulate donation"

	var/ckey = input("Ckey") as text
	var/money = input("Money") as num
	new /datum/donator(ckey, money)
	return
*/

/datum/donator
	var/ownerkey
	var/money = 0
	var/maxmoney = 0
	var/allowed_num_items = 1000

	New(ckey, money)
		..()
		ownerkey = ckey
		src.money = money
		maxmoney = money
		donators[ckey] = src

	proc/show()
		var/dat = "<title>Donator panel</title>"
		dat += "You have [money] / [maxmoney]<br>"
		dat += "You can spawn [ allowed_num_items ? allowed_num_items : "no" ] more items.<br><br>"

		if (allowed_num_items)
			if (!donat_categoryes.len)
				build_prizes_list()

			for(var/cur_cat in donat_categoryes)
				dat += "<hr><b>[cur_cat]</b><br>"
				for(var/datum/donat_stuff/item in donat_categoryes[cur_cat])
					dat += "<a href='?src=\ref[src];item=\ref[item]'>[item.name] : [item.cost]</a><br>"
		usr << browse(dat, "window=donatorpanel;size=250x400")

	Topic(href, href_list)
		var/datum/donat_stuff/item = locate(href_list["item"])

		var/mob/living/carbon/human/user = usr.client.mob

		var/list/slots = list (
			"backpack" = slot_in_backpack,
			"left pocket" = slot_l_store,
			"right pocket" = slot_r_store,
			"left hand" = slot_l_hand,
			"right hand" = slot_r_hand,
		)

		if(item.cost > money)
			usr << "<span class='warning'>You don't have enough funds.</span>"
			return 0

		if(!allowed_num_items)
			usr << "<span class='warning'>You have reached maximum amount of spawned items.</span>"
			return 0

		if(!user)
			user << "<span class='warning'>You must be a human to use this.</span>"
			return 0

		if(user.stat) return 0

		var/obj/spawned = new item.path

		var/where = user.equip_in_one_of_slots(spawned, slots, del_on_fail=0)

		if (!where)
			spawned.loc = user.loc
			usr << "<span class='info'>Your [spawned.name] has been spawned!</span>"
		else
			usr << "<span class='info'>Your [spawned.name] has been spawned in your [where]!</span>"

		money -= item.cost
		allowed_num_items--

		show()

/proc/load_donator(ckey)
	var/DBConnection/dbcon2 = new()
	dbcon2.Connect("dbi:mysql:forum2:[sqladdress]:[sqlport]","[sqlfdbklogin]","[sqlfdbkpass]")

	if(!dbcon2.IsConnected())
		world.log << "Failed to connect to database [dbcon2.ErrorMsg()] in load_donator([ckey])."
		diary << "Failed to connect to database in load_donator([ckey])."
		return 0

	var/DBQuery/query = dbcon2.NewQuery("SELECT round(sum) FROM Z_donators WHERE byond='[ckey]'")
	query.Execute()
	while(query.NextRow())
		var/money = round(text2num(query.item[1]))
		new /datum/donator(ckey, money)
	dbcon2.Disconnect()
	return 1

/proc/build_prizes_list()
	for(var/path in subtypesof(/datum/donat_stuff))
		var/datum/donat_stuff/T = path
		if(!initial(T.name))
			continue
		T = new path
		if(!donat_categoryes[T.category])
			donat_categoryes[T.category] = list()
		donat_categoryes[T.category] += T

/client/verb/cmd_donator_panel()
	set name = "Donator panel"
	set category = "OOC"

	if(!ticker || ticker.current_state < 3)
		alert("Please wait until game setting up!")
		return

	if (!donators[ckey]) //It doesn't exist yet
		if (load_donator(ckey))
			var/datum/donator/D = donators[ckey]
			if(D)
				D.show()
			else
				usr << browse ("<b>You have not donated or the database is inaccessible.</b>", "window=donatorpanel")
		else
			usr << browse ("<b>You have not donated or the database is inaccessible.</b>", "window=donatorpanel")
	else
		var/datum/donator/D = donators[ckey]
		D.show()

//SPECIAL ITEMS
/obj/item/weapon/reagent_containers/glass/drinks/drinkingglass/threemileisland
	New()
		..()
		reagents.add_reagent("threemileisland", 50)
		on_reagent_change()



/datum/donat_stuff
	var/category = ""
	var/name = ""
	var/path = null
	var/cost = 0

/datum/donat_stuff/hat
	category = "Hats"

/datum/donat_stuff/hat/pete
	name = "Collectable Pete Hat"
	path = /obj/item/clothing/head/collectable/petehat
	cost = 150

/datum/donat_stuff/hat/xeno
	name = "Collectable Xeno Hat"
	path = /obj/item/clothing/head/collectable/xenom
	cost = 110

/datum/donat_stuff/hat/top
	name = "Collectable Top Hat"
	path = /obj/item/clothing/head/collectable/tophat
	cost = 120

/datum/donat_stuff/hat/kitty
	name = "Kitty Ears"
	path = /obj/item/clothing/head/kitty
	cost = 100

/datum/donat_stuff/hat/ushanka
	name = "Ushanka"
	path = /obj/item/clothing/head/ushanka
	cost = 200

/datum/donat_stuff/hat/beret
	name = "Beret"
	path = /obj/item/clothing/head/beret
	cost = 150

/datum/donat_stuff/hat/cake
	name  = "Cake-Hat"
	path = /obj/item/clothing/head/cakehat
	cost = 100

/datum/donat_stuff/hat/wizard
	name = "Wizard Hat"
	path = /obj/item/clothing/head/wizard/fake
	cost = 100

/datum/donat_stuff/hat/flat
	name = "Flat-Cap"
	path = /obj/item/clothing/head/flatcap
	cost = 120

/datum/donat_stuff/hat/rabbt
	name = "Collectable Rabbit ears"
	path = /obj/item/clothing/head/collectable/rabbitears
	cost = 120

/datum/donat_stuff/hat/cadborg
	name = "Cardborg Helment. Beep-boop!"
	path = /obj/item/clothing/head/cardborg
	cost = 85

/datum/donat_stuff/hat/sombrero
	name = "Sombrero"
	path = /obj/item/clothing/head/sombrero
	cost = 120

/datum/donat_stuff/hat/pirate
	name = "Pirate Hat"
	path = /obj/item/clothing/head/pirate
	cost = 120

/datum/donat_stuff/hat/flower
	name = "Hair Flower"
	path = /obj/item/clothing/head/hairflower
	cost = 130

/datum/donat_stuff/hat/powdered
	name = "Powdered Wig"
	path = /obj/item/clothing/head/powdered_wig
	cost = 120

/datum/donat_stuff/hat/hos
	name = "Collectable HoS hat"
	path = /obj/item/clothing/head/collectable/HoS
	cost = 150

/datum/donat_stuff/hat/philowopher
	name = "Philowopher Wig"
	path = /obj/item/clothing/head/philosopher_wig
	cost = 120

/datum/donat_stuff/hat/pumpkin
	name = "Carved Pumpkin"
	path = /obj/item/clothing/head/pumpkinhead
	cost = 140

/datum/donat_stuff/hat/captain
	name = "Collectable Captain's hat"
	path = /obj/item/clothing/head/collectable/captain
	cost = 210

/datum/donat_stuff/hat/crown
	name = "Crown"
	path = /obj/item/clothing/head/collectable/crown
	cost = 190

/datum/donat_stuff/hat/marisa
	name = "Marisa Hat!"
	path = /obj/item/clothing/head/collectable/marisa
	cost = 130

/datum/donat_stuff/hat/metroid
	name = "Metroid Hat"
	path = /obj/item/clothing/head/collectable/metroid
	cost = 140

/datum/donat_stuff/hat/elite_top
	name = "Very Elite Top Hat"
	path = /obj/item/clothing/head/collectable/secelitetop
	cost = 110

/datum/donat_stuff/personal
	category = "Personal Stuff"

/datum/donat_stuff/personal/eyepatch
	name = "Eye patch"
	path = /obj/item/clothing/glasses/eyepatch
	cost = 130

/datum/donat_stuff/personal/threed
	name = "3D-glasses"
	path = /obj/item/clothing/glasses/threedglasses
	cost = 120

/datum/donat_stuff/personal/monocle
	name = "Monocle"
	path = /obj/item/clothing/glasses/monocle
	cost = 110

/datum/donat_stuff/personal/cane
	name = "Cane"
	path = /obj/item/weapon/cane
	cost = 130

/datum/donat_stuff/personal/zippo
	name = "Zippo"
	path = /obj/item/weapon/flame/lighter/zippo
	cost = 130

/datum/donat_stuff/personal/cigarette
	name = "Cigarette Packet"
	path = /obj/item/weapon/storage/fancy/cigarettes
	cost = 20

/datum/donat_stuff/personal/cigarette_alt
	name = "DromedaryCo Packet"
	path = /obj/item/weapon/storage/fancy/cigarettes/dromedaryco
	cost = 50

/datum/donat_stuff/personal/cigar
	name = "Premium Havanian Cigar"
	path = /obj/item/clothing/mask/smokable/cigarette/cigar/havana
	cost = 130

/datum/donat_stuff/personal/beer
	name = "Beer Bottle"
	path = /obj/item/weapon/reagent_containers/glass/drinks/cans/beer
	cost = 80

/datum/donat_stuff/personal/cap_flask
	name = "Captain Flask"
	path = /obj/item/weapon/reagent_containers/glass/drinks/flask
	cost = 200

/datum/donat_stuff/personal/tea
	name = "Three Mile Island Ice Tea"
	path = /obj/item/weapon/reagent_containers/glass/drinks/drinkingglass/threemileisland
	cost = 100

/datum/donat_stuff/personal/shiny_flask
	name = "Shiny Flask"
	path = /obj/item/weapon/reagent_containers/glass/drinks/flask/shiny
	cost = 200

/datum/donat_stuff/personal/leather_satchel
	name = "Leather Satchel"
	path = /obj/item/weapon/storage/backpack/satchel
	cost = 190

/datum/donat_stuff/personal/wallet
	name = "Wallet"
	path = /obj/item/weapon/storage/wallet
	cost = 90

/datum/donat_stuff/personal/briefcase
	name = "Briefcase"
	path = /obj/item/weapon/storage/briefcase
	cost = 120

/datum/donat_stuff/shoes
	category = "Shoes"

/datum/donat_stuff/shoes/brown
	name = "Brown Shoes"
	path = /obj/item/clothing/shoes/brown
	cost = 130

/datum/donat_stuff/shoes/blue
	name = "Blue Shoes"
	path = /obj/item/clothing/shoes/blue
	cost = 130

/datum/donat_stuff/shoes/leather
	name = "Leather Shoes"
	path = /obj/item/clothing/shoes/leather
	cost = 130

/datum/donat_stuff/shoes/green
	name = "Green Shoes"
	path = /obj/item/clothing/shoes/green
	cost = 130

/datum/donat_stuff/shoes/black
	name = "Black Shoes"
	path = /obj/item/clothing/shoes/black
	cost = 130

/datum/donat_stuff/shoes/purple
	name = "Purple Shoes"
	path = /obj/item/clothing/shoes/purple
	cost = 130

/datum/donat_stuff/coat
	category = "Coats"

/datum/donat_stuff/coat/leather
	name = "Leather Coat"
	path = /obj/item/clothing/suit/storage/leathercoat
	cost = 160

/datum/donat_stuff/coat/pirate
	name = "Pirate Coat"
	path = /obj/item/clothing/suit/storage/pirate
	cost = 120

/datum/donat_stuff/coat/poncho
	name = "Red Poncho"
	path = /obj/item/clothing/suit/poncho/red
	cost = 140

/datum/donat_stuff/coat/poncho/green
	name = "Green Poncho"
	path = /obj/item/clothing/suit/poncho/green
	cost = 120

/datum/donat_stuff/coat/cardborg
	name = "Cardborg"
	path = /obj/item/clothing/suit/cardborg
	cost = 190

/datum/donat_stuff/coat/judge
	name = "Judge Robe"
	path = /obj/item/clothing/suit/judgerobe
	cost = 170

/datum/donat_stuff/uniform
	category = "Jumpsuits"

/datum/donat_stuff/uniform/vice_policeman
	name = "Vice Policeman"
	path = /obj/item/clothing/under/rank/vice
	cost = 180

/datum/donat_stuff/uniform/pirate
	name = "Pirate Outfit"
	path = /obj/item/clothing/under/pirate
	cost = 130

/datum/donat_stuff/uniform/waiter
	name = "Waiter Outfit"
	path = /obj/item/clothing/under/waiter
	cost = 120

/datum/donat_stuff/uniform/black_suit
	name = "Black Suit"
	path = /obj/item/clothing/under/lawyer/black
	cost = 150
/*
/datum/donat_stuff/uniform/centcom_officer
	name = "Central Command Officer"
	path = /obj/item/clothing/under/rank/centcom_officer
	cost = 390
*/

/datum/donat_stuff/uniform/jeans
	name = "Jeans"
	path = /obj/item/clothing/under/pants/jeans
	cost = 160

/datum/donat_stuff/uniform/rainbow
	name = "Rainbow Suit"
	path = /obj/item/clothing/under/color/rainbow
	cost = 130

/datum/donat_stuff/uniform/really_black
	name = "Executive Suit"
	path = /obj/item/clothing/under/suit_jacket/really_black
	cost = 130

/datum/donat_stuff/uniform/schoolgirl
	name = "Schoolgirl Uniform"
	path = /obj/item/clothing/under/schoolgirl
	cost = 130

/datum/donat_stuff/uniform/tacticool
	name = "Tacticool Turtleneck"
	path = /obj/item/clothing/under/syndicate/tacticool
	cost = 130

/datum/donat_stuff/uniform/soviet
	name = "Soviet Uniform"
	path = /obj/item/clothing/under/soviet
	cost = 130

/datum/donat_stuff/uniform/gentle
	name = "Gemtelman"
	path = /obj/item/clothing/under/gentlesuit
	cost = 140

/datum/donat_stuff/uniform/assistantformal
	name = "Assistant Formal"
	path = /obj/item/clothing/under/assistantformal
	cost = 140

/datum/donat_stuff/uniform/tan
	name = "Tan Suit"
	path = /obj/item/clothing/under/suit_jacket/tan
	cost = 130

/datum/donat_stuff/uniform/charcoal
	name = "Charcoal"
	path = /obj/item/clothing/under/suit_jacket/charcoal
	cost = 130

/datum/donat_stuff/uniform/navy
	name = "Navy Suit"
	path = /obj/item/clothing/under/suit_jacket/navy
	cost = 120

/datum/donat_stuff/uniform/suit_jacket
	name = "Black Suit"
	path = /obj/item/clothing/under/suit_jacket
	cost = 120

/datum/donat_stuff/gloves
	category = "Gloves"

/datum/donat_stuff/gloves/white
	name = "White"
	path = /obj/item/clothing/gloves/white
	cost = 130

/datum/donat_stuff/gloves/blue
	name = "Blue"
	path = /obj/item/clothing/gloves/blue
	cost = 130

/datum/donat_stuff/gloves/brown
	name = "Brown"
	path = /obj/item/clothing/gloves/brown
	cost = 130

/datum/donat_stuff/gloves/rainbow
	name = "Rainbow"
	path = /obj/item/clothing/gloves/rainbow
	cost = 200

/datum/donat_stuff/gloves/black
	name = "Black"
	path = /obj/item/clothing/gloves/black
	cost = 160

/datum/donat_stuff/gloves/boxing
	name = "Boxing"
	path = /obj/item/clothing/gloves/boxing
	cost = 120

/datum/donat_stuff/gloves/green
	name = "Green"
	path = /obj/item/clothing/gloves/green
	cost = 130

/datum/donat_stuff/gloves/latex
	name = "Latex"
	path = /obj/item/clothing/gloves/white/latex
	cost = 150

/datum/donat_stuff/bedsheet
	category = "Bedsheets"

/datum/donat_stuff/bedsheet/clown
	name = "Clown Bedsheet"
	path = /obj/item/weapon/bedsheet/clown
	cost = 100

/datum/donat_stuff/bedsheet/mime
	name = "Mime Bedsheet"
	path = /obj/item/weapon/bedsheet/mime
	cost = 100

/datum/donat_stuff/bedsheet/rainbow
	name = "Rainbow Bedsheet"
	path = /obj/item/weapon/bedsheet/rainbow
	cost = 100

/datum/donat_stuff/bedsheet/captain
	name = "Captain Bedsheet"
	path = /obj/item/weapon/bedsheet/captain
	cost = 120

/datum/donat_stuff/toy
	category = "Toys"

/datum/donat_stuff/toy/duck
	name = "Rubber Duck"
	path = /obj/item/weapon/bikehorn/rubberducky
	cost = 200

/datum/donat_stuff/toy/belt
	name = "Champion Belt"
	path = /obj/item/weapon/storage/belt/champion
	cost = 200

/datum/donat_stuff/toy/sword
	name = "Toy Sword"
	path = /obj/item/toy/sword
	cost = 70

/datum/donat_stuff/toy/katana
	name = "Toy Katana"
	path = /obj/item/toy/katana
	cost = 100

/datum/donat_stuff/toy/beepsky
	name = "Plush Beepsky"
	path = /obj/structure/plushie/beepsky
	cost = 120

/datum/donat_stuff/toy/ian
	name = "Plush Ian"
	path = /obj/structure/plushie/ian
	cost = 120

/datum/donat_stuff/toy/donut
	name = "Donut Box"
	path = /obj/item/weapon/storage/box/donut
	cost = 450

/datum/donat_stuff/toy/cola
	name = "Space Cola"
	path = /obj/item/weapon/reagent_containers/glass/drinks/cans/cola
	cost = 80

/datum/donat_stuff/toy/water
	name = "Bottled Water"
	path = /obj/item/weapon/reagent_containers/glass/drinks/cans/waterbottle
	cost = 40

/datum/donat_stuff/special
	category = "Special Stuff"

/datum/donat_stuff/special/
	name = "Santabag"
	path = /obj/item/weapon/storage/backpack/santabag
	cost = 600
