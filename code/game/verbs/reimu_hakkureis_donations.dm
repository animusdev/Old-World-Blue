var/const/stuff = {"
Hats
Collectable Pete Hat:/obj/item/clothing/head/collectable/petehat:150
Collectable Xeno Hat:/obj/item/clothing/head/collectable/xenom:110
Collectable Top Hat:/obj/item/clothing/head/collectable/tophat:120
Kitty Ears:/obj/item/clothing/head/kitty:100
Ushanka:/obj/item/clothing/head/ushanka:200
Beret:/obj/item/clothing/head/beret:150
Cake-Hat:/obj/item/clothing/head/cakehat:100
Wizard Hat:/obj/item/clothing/head/wizard/fake:100
Flat-Cap:/obj/item/clothing/head/flatcap:120
Collectable Rabbit ears:/obj/item/clothing/head/collectable/rabbitears:120
Cardborg Helment. Beep-boop!:/obj/item/clothing/head/cardborg:85
Sombrero:/obj/item/clothing/head/sombrero:120
Pirate Hat:/obj/item/clothing/head/pirate:120
Hair Flower:/obj/item/clothing/head/hairflower:130
Powdered Wig:/obj/item/clothing/head/powdered_wig:120
Collectable HoS hat:/obj/item/clothing/head/collectable/HoS:150
Philowopher Wig:/obj/item/clothing/head/philosopher_wig:120
Carved Pumpkin:/obj/item/clothing/head/pumpkinhead:140
Collectable Captain's hat:/obj/item/clothing/head/collectable/captain:210
Crown:/obj/item/clothing/head/collectable/crown:190
Marisa Hat!:/obj/item/clothing/head/collectable/marisa:130
Metroid Hat:/obj/item/clothing/head/collectable/metroid:140
Very Elite Top Hat:/obj/item/clothing/head/collectable/secelitetop:110


Personal Stuff
Eye patch:/obj/item/clothing/glasses/eyepatch:130
3D-glasses:/obj/item/clothing/glasses/threedglasses:120
Monocle:/obj/item/clothing/glasses/monocle:110
Cane:/obj/item/weapon/cane:130
Zippo:/obj/item/weapon/flame/lighter/zippo:130
Cigarette Packet:/obj/item/weapon/storage/fancy/cigarettes:20
DromedaryCo Packet:/obj/item/weapon/storage/fancy/cigarettes/dromedaryco:50
Premium Havanian Cigar:/obj/item/clothing/mask/smokable/cigarette/cigar/havana:130
Beer Bottle:/obj/item/weapon/reagent_containers/glass/drinks/cans/beer:80
Captain Flask:/obj/item/weapon/reagent_containers/food/drinks/flask:200
Three Mile Island Ice Tea:/obj/item/weapon/reagent_containers/glass/drinks/drinkingglass/threemileisland:100
Shiny Flask:/obj/item/weapon/reagent_containers/glass/drinks/flask/shiny:200
Leather Satchel:/obj/item/weapon/storage/backpack/satchel:190
Wallet:/obj/item/weapon/storage/wallet:90
Briefcase:/obj/item/weapon/storage/briefcase:120


Shoes
Brown Shoes:/obj/item/clothing/shoes/brown:130
Blue Shoes:/obj/item/clothing/shoes/blue:130
Leather Shoes:/obj/item/clothing/shoes/leather:130
Green Shoes:/obj/item/clothing/shoes/green:130
Black Shoes:/obj/item/clothing/shoes/black:130
Purple Shoes:/obj/item/clothing/shoes/purple:130


Coats
Leather Coat:/obj/item/clothing/suit/storage/leathercoat:160
Pirate Coat:/obj/item/clothing/suit/pirate:120
Red Poncho:/obj/item/clothing/suit/poncho/red:140
Green Poncho:/obj/item/clothing/suit/poncho/green:120
Cardborg:/obj/item/clothing/suit/cardborg:190
Judge Robe:/obj/item/clothing/suit/judgerobe:170


Jumpsuits
Vice Policeman:/obj/item/clothing/under/rank/vice:180
Pirate Outfit:/obj/item/clothing/under/pirate:130
Waiter Outfit:/obj/item/clothing/under/waiter:120
Black Suit:/obj/item/clothing/under/lawyer/blacksuit:150
Central Command Officer:/obj/item/clothing/under/rank/centcom_officer:390
Jeans:/obj/item/clothing/under/pants/jeans:160
Rainbow Suit:/obj/item/clothing/under/rainbow:130
Executive Suit:/obj/item/clothing/under/suit_jacket/really_black:130
Schoolgirl Uniform:/obj/item/clothing/under/schoolgirl:130
Tacticool Turtleneck:/obj/item/clothing/under/syndicate/tacticool:130
Soviet Uniform:/obj/item/clothing/under/soviet:130
Gemtelman:/obj/item/clothing/under/gentlesuit:140
Assistant Formal:/obj/item/clothing/under/assistantformal:140
Tan Suit:/obj/item/clothing/under/suit_jacket/tan:130
Charcoal:/obj/item/clothing/under/suit_jacket/charcoal:130
Navy Suit:/obj/item/clothing/under/suit_jacket/navy:120
Black Suit:/obj/item/clothing/under/suit_jacket:120

Gloves
White:/obj/item/clothing/gloves/white:130
Blue:/obj/item/clothing/gloves/blue:130
Brown:/obj/item/clothing/gloves/brown:130
White:/obj/item/clothing/gloves/white:130
Rainbow:/obj/item/clothing/gloves/rainbow:200
Black:/obj/item/clothing/gloves/black:160
Boxing:/obj/item/clothing/gloves/boxing:120
Green:/obj/item/clothing/gloves/green:130
Latex:/obj/item/clothing/gloves/white/latex:150

Bedsheets
Clown Bedsheet:/obj/item/weapon/bedsheet/clown:100
Mime Bedsheet:/obj/item/weapon/bedsheet/mime:100
Rainbow Bedsheet:/obj/item/weapon/bedsheet/rainbow:100
Captain Bedsheet:/obj/item/weapon/bedsheet/captain:120

Toys
Rubber Duck:/obj/item/weapon/bikehorn/rubberducky:200
Champion Belt:/obj/item/weapon/storage/belt/champion:200
Toy Sword:/obj/item/toy/sword:70
Toy Katana:/obj/item/toy/katana:100
Plush Beepsky:/obj/structure/plushie/beepsky:120
Plush Ian:/obj/structure/plushie/ian:120
Donut Box:/obj/item/weapon/storage/box/donut:450
Space Cola:/obj/item/weapon/reagent_containers/glass/drinks/cans/cola:80
Bottled Water:/obj/item/weapon/reagent_containers/glass/drinks/cans/waterbottle:40

Special Stuff
Santabag:/obj/item/weapon/storage/backpack/santabag:600
"}



var/list/datum/donator_prize/prizes = list()
var/list/datum/donator/donators = list()

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
			if (!prizes.len)
				build_prizes_list()

			var/cur_cat = "None"

			for (var/i = 1, i<=prizes.len, i++)
				var/datum/donator_prize/prize = prizes[i]
				var/cat_name = prize.category
				if (cur_cat != cat_name)
					dat += "<hr><b>[cat_name]</b><br>"
				cur_cat = cat_name
				dat += "<a href='?src=\ref[src];itemid=[i]'>[prize.item_name] : [prize.cost]</a><br>"
		usr << browse(dat, "window=donatorpanel;size=250x400")

	Topic(href, href_list)
		var/id = text2num(href_list["itemid"])
		var/datum/donator_prize/prize = prizes[id]

		var/name = prize.item_name
		var/cost = prize.cost
		var/path = prize.path_to
		var/mob/living/carbon/human/user = usr.client.mob

		var/list/slots = list (
			"backpack" = slot_in_backpack,
			"left pocket" = slot_l_store,
			"right pocket" = slot_r_store,
			"left hand" = slot_l_hand,
			"right hand" = slot_r_hand,
		)

		if(cost > money)
			usr << "<span class='warning'>You don't have enough funds.</span>"
			return 0

		if(!allowed_num_items)
			usr << "<span class='warning'>You have reached maximum amount of spawned items.</span>"
			return 0

		if(!user)
			user << "<span class='warning'>You must be a human to use this.</span>"
			return 0

		if(!ispath(path))
			return 0

		if(user.stat) return 0

		var/obj/spawned = new path

		var/where = user.equip_in_one_of_slots(spawned, slots, del_on_fail=0)

		if (!where)
			spawned.loc = user.loc
			usr << "<span class='info'>Your [name] has been spawned!</span>"
		else
			usr << "<span class='info'>Your [name] has been spawned in your [where]!</span>"

		money -= cost
		allowed_num_items--

		show()

/datum/donator_prize
	var/item_name = "Nothing"
	var/path_to = /datum/donator_prize
	var/cost = 0
	var/category = "Debug"

proc/load_donator(ckey)
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

proc/build_prizes_list()
	var/list/strings = text2list ( stuff, "\n" )
	var/cur_cat = "Miscellaneous"
	for (var/string in strings)
		if (string) //It's not a delimiter between
			var/list/item_info = text2list ( string, ":" )
			if (item_info.len==3)
				var/datum/donator_prize/prize = new
				prize.item_name = item_info[1]
				prize.path_to = text2path(item_info[2])
				prize.cost = text2num(item_info[3])
				prize.category = cur_cat
				prizes += prize
			else
				cur_cat = item_info[1]


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
