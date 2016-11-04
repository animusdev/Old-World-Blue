/obj/structure/slotmachine
	name = "slotmachine"
	desc = "Where does the money come out? Usually at the ATM."
	icon = 'icons/obj/bluestuff/slotmachine.dmi'
	icon_state = "slotmachine"
	density = 1
	anchored = 1.0
	var/spinning = 0
	var/bet = 0
	var/jackpot = 0
	var/plays = 0
	var/slots = list()
	//var/list/fruits = list("Cherry","Apple","Blueberry","Bell","Watermelon","JACKPOT")

/obj/structure/slotmachine/New()
	..()
	jackpot = rand(1000,50000);
	plays = rand(1,50)
	slots = list("1" = "Cherry","2" = "Cherry","3" = "Cherry")
	update_icon()

///obj/structure/slotmachine/Destroy()
//	return ..()

/obj/structure/slotmachine/update_icon()
	overlays.Cut()
	//From left to right
	var/offset = -6
	var/image/img
	for(var/slot in slots)
		img = new/image(src.icon, "slot_[slots[slot]]")
		img.pixel_x += offset
		overlays += img
		offset += 6
	return

/obj/structure/slotmachine/proc/check_win()
	var/win_slot = null
	for(var/slot in slots)
		if(win_slot == null)
			win_slot = slots[slot]
		else if (win_slot != slots[slot])
			return 0
	return 1

/obj/structure/slotmachine/attack_hand(mob/user as mob)
	if (spinning)
		usr << "\red It's active."
		return
	if (bet == 0)
		usr << "\blue Today's jackpot: $[jackpot]. Insert 1-100 Thalers."
	else
		spinning = 1
		plays++
		for(var/slot in slots)
			slots[slot] = "spin"
		update_icon()
		src.visible_message("<b>[name]</b> states, \"Your bet is $[bet]. Goodluck, buddy!\"")
		playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
		var/last_slot = null
		for(var/slot in slots)
			sleep(10)
			if(prob(plays) && (last_slot != null))
				plays = 0
				slots[slot] = last_slot
			else
				slots[slot] = pick("Cherry","Apple","Blueberry","Bell","Watermelon","JACKPOT")
				last_slot = slots[slot]
			update_icon()
			src.visible_message("<span class='notice'>Reel stops.. \the [slots[slot]].</span>")
			playsound(src.loc, 'sound/machines/ping.ogg', 50, 1)
		sleep(5)
		if (check_win())
			playsound(src.loc, 'sound/machines/ping.ogg', 50, 1)
			var/list/fruits = list("Cherry" = 2,"Apple" = 6,"Blueberry" = 10,"Bell" = 16,"Watermelon" = 24,"JACKPOT" = 1)
			var/prize = bet*fruits[slots["1"]]
			if (slots["1"] == "JACKPOT")
				prize = jackpot
				jackpot = 0
				src.visible_message("<b>[name]</b> states, \"Damn son! JACKPOT!!! Congratulations!\"")
			else
				src.visible_message("<b>[name]</b> states, \"Congratulations! You won [prize] Thalers!\"")
			spawn_money(prize,src.loc,user)
		else
			playsound(src.loc, 'sound/machines/buzz-sigh.ogg', 50, 1)
			src.visible_message("<b>[name]</b> states, \"Sorry, maybe, next time..\"")
			jackpot += bet

	src.add_fingerprint(user)
	update_icon()
	bet = 0
	spinning = 0

/obj/structure/slotmachine/attackby(obj/item/S as obj, mob/user as mob)
	if (spinning)
		return
	if (istype(S, /obj/item/weapon/spacecash))
		var/obj/item/weapon/spacecash/cash = S
		if ((cash.worth > 0) && (cash.worth<=100) && (bet + cash.worth <= 100))
			user << "<span class='info'>You insert [cash.worth] Thalers into [src].</span>"
			bet += cash.worth
			user.drop_from_inventory(cash)
			qdel(cash)
		else
			user << "\red You must bet 1-100 Thalers!"
	else if (istype(S, /obj/item/weapon/coin))
		user << "\blue You add the [S.name] into the [src]. It will slightly increase chance to win."
		user.drop_from_inventory(S)
		bet = 100
		plays = 45
		qdel(S)
	src.add_fingerprint(user)
	return

/*
/obj/effect/slotmachine_slot
	name = "slot"
	icon = 'icons/obj/bluestuff/slotmachine.dmi'
	icon_state = "slot_Cherry"
	invisibility = 60
	var/slot = "Cherry"

/obj/effect/slotmachine_slot/Destroy()
	..()
*/