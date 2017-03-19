/obj/structure/closet/secure_closet/captains
	name = "captain's locker"
	req_access = list(access_captain)
	icon_state = "capsecure"
	icon_opened = "capsecureopen"
	icon_broken = "capsecurebroken"

	New()
		..()
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/dufflebag/cap(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/cap(src)
			if(3) new /obj/item/weapon/storage/backpack/captain(src)
		new /obj/item/clothing/suit/captunic(src)
		new /obj/item/clothing/suit/captunic/capjacket(src)
		new /obj/item/clothing/head/cap(src)
		new /obj/item/clothing/under/rank/captain(src)
		new /obj/item/clothing/suit/storage/vest(src)
		new /obj/item/weapon/cartridge/captain(src)
		new /obj/item/clothing/head/helmet/swat(src)
		new /obj/item/weapon/storage/lockbox/medal(src)
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/device/radio/headset/heads/captain/alt(src)
		new /obj/item/clothing/gloves/captain(src)
		new /obj/item/weapon/gun/energy/gun(src)
		new /obj/item/weapon/melee/baton/shocker/loaded(src)
		new /obj/item/weapon/melee/telebaton(src)
		new /obj/item/clothing/under/dress/dress_cap(src)
		new /obj/item/clothing/head/captain/formal(src)
		new /obj/item/clothing/under/captainformal(src)
		return



/obj/structure/closet/secure_closet/hop
	name = "head of personnel's locker"
	req_access = list(access_hop)
	icon_state = "hopsecure"
	icon_opened = "hopsecureopen"
	icon_broken = "hopsecurebroken"

	New()
		..()
		new /obj/item/clothing/glasses/sunglasses(src)
		new /obj/item/clothing/suit/storage/vest(src)
		new /obj/item/clothing/head/helmet/security(src)
		new /obj/item/weapon/cartridge/hop(src)
		new /obj/item/device/radio/headset/com/alt(src)
		new /obj/item/weapon/storage/box/ids(src)
		new /obj/item/weapon/storage/box/ids(src)
		new /obj/item/weapon/gun/energy/gun(src)
		new /obj/item/weapon/gun/projectile/sec/flash(src)
		new /obj/item/weapon/melee/baton/shocker/loaded(src)
		new /obj/item/device/flash(src)
		return

/obj/structure/closet/secure_closet/hop2
	name = "head of personnel's attire"
	req_access = list(access_hop)
	icon_state = "hopsecure"
	icon_opened = "hopsecureopen"
	icon_broken = "hopsecurebroken"

	New()
		..()
		new /obj/item/clothing/under/rank/hop(src)
		new /obj/item/clothing/under/dress/dress_hop(src)
		new /obj/item/clothing/under/dress/dress_hr(src)
		new /obj/item/clothing/under/lawyer/female(src)
		new /obj/item/clothing/under/lawyer/black(src)
		new /obj/item/clothing/under/lawyer/red(src)
		new /obj/item/clothing/under/lawyer/oldman(src)
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/clothing/shoes/black(src)
		new /obj/item/clothing/shoes/leather(src)
		new /obj/item/clothing/shoes/white(src)
		new /obj/item/clothing/under/rank/hop/whimsy(src)
		new /obj/item/clothing/under/rank/hop/dark(src)
		new /obj/item/clothing/under/rank/hop/doctor(src)
		new /obj/item/clothing/suit/storage/toggle/hop(src)
		new /obj/item/clothing/head/hop(src)
		return



/obj/structure/closet/secure_closet/hos
	name = "head of security's locker"
	req_access = list(access_hos)
	icon_state = "hossecure"
	icon_opened = "hossecureopen"
	icon_broken = "hossecurebroken"

	New()
		..()
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/security(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/sec(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/sec(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/sec(src)
		new /obj/item/clothing/head/HoS(src)
		new /obj/item/clothing/suit/storage/vest/hos(src)
		new /obj/item/clothing/under/rank/head_of_security/jensen(src)
		new /obj/item/clothing/under/rank/head_of_security/corp(src)
		new /obj/item/clothing/suit/storage/hos/jensen(src)
		new /obj/item/clothing/suit/storage/hos(src)
		new /obj/item/clothing/head/helmet/dermal(src)
		new /obj/item/weapon/cartridge/hos(src)
		new /obj/item/device/radio/headset/heads/hos/alt(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll(src)
		new /obj/item/weapon/shield/riot(src)
		new /obj/item/weapon/storage/box/holobadge/hos(src)
		new /obj/item/clothing/accessory/badge/holo/hos(src)
		new /obj/item/weapon/reagent_containers/spray/pepper(src)
		new /obj/item/weapon/crowbar/red(src)
		new /obj/item/weapon/storage/box/flashbangs(src)
		new /obj/item/weapon/storage/belt/security(src)
		new /obj/item/device/flash(src)
		new /obj/item/weapon/melee/baton/loaded(src)
		new /obj/item/weapon/gun/energy/gun(src)
		new /obj/item/clothing/accessory/holster/gun/waist(src)
		new /obj/item/weapon/melee/telebaton(src)
		new /obj/item/clothing/head/beret/sec/hos(src)
		new /obj/item/clothing/under/rank/head_of_security/dnavy(src)
		new/obj/item/clothing/suit/storage/security/dnavyhos(src)
		return



/obj/structure/closet/secure_closet/warden
	name = "warden's locker"
	req_access = list(access_armory)
	icon_state = "wardensecure"
	icon_opened = "wardensecureopen"
	icon_broken = "wardensecurebroken"


	New()
		..()
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/security(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/sec(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/sec(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/sec(src)
		new /obj/item/clothing/suit/storage/vest/warden(src)
		new /obj/item/clothing/under/rank/warden(src)
		new /obj/item/clothing/under/rank/warden/corp(src)
		new /obj/item/clothing/under/rank/warden/dnavy(src)
		new /obj/item/clothing/suit/storage/vest/warden(src)
		new /obj/item/clothing/head/helmet/warden(src)
		new /obj/item/clothing/head/helmet/warden/alt(src)
		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/device/radio/headset/sec/alt(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll(src)
		new /obj/item/weapon/storage/box/flashbangs(src)
		new /obj/item/weapon/storage/belt/security(src)
		new /obj/item/weapon/reagent_containers/spray/pepper(src)
		new /obj/item/weapon/melee/baton/loaded(src)
		new /obj/item/weapon/gun/energy/gun(src)
		new /obj/item/weapon/storage/box/holobadge(src)
		new /obj/item/clothing/head/beret/sec/warden(src)
		new /obj/item/clothing/head/helmet/warden/drill(src)
		new /obj/item/clothing/accessory/storage/black_vest(src)
		new/obj/item/clothing/suit/storage/security/dnavywarden(src)
		return



/obj/structure/closet/secure_closet/security
	name = "security officer's locker"
	req_access = list(access_brig)
	icon_state = "sec"
	icon_opened = "secopen"
	icon_broken = "secbroken"

	New()
		..()
		switch(rand(4))
			if(1) new /obj/item/weapon/storage/backpack/security(src)
			if(2) new /obj/item/weapon/storage/backpack/satchel/sec(src)
			if(3) new /obj/item/weapon/storage/backpack/dufflebag/sec(src)
			if(4) new /obj/item/weapon/storage/backpack/messenger/sec(src)
		new /obj/item/clothing/suit/storage/vest/officer(src)
		new /obj/item/clothing/head/helmet/security(src)
//		new /obj/item/weapon/cartridge/security(src)
		new /obj/item/device/radio/headset/sec/alt(src)
		new /obj/item/weapon/storage/belt/security(src)
		new /obj/item/device/flash(src)
		new /obj/item/weapon/reagent_containers/spray/pepper(src)
		new /obj/item/weapon/grenade/flashbang(src)
		new /obj/item/weapon/melee/baton/loaded(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll(src)
		new /obj/item/device/hailer(src)
		new /obj/item/clothing/accessory/storage/black_vest(src)
		new /obj/item/clothing/head/soft/sec/corp(src)
		new /obj/item/clothing/under/rank/security/corp(src)
		new /obj/item/ammo_magazine/c45m/rubber(src)
		new /obj/item/weapon/gun/energy/taser(src)
		new /obj/item/clothing/gloves/black(src)
		new /obj/item/clothing/under/rank/security/dnavy(src)
		new /obj/item/clothing/suit/storage/security/dnavyofficer(src)
		return


/obj/structure/closet/secure_closet/security/cargo

	New()
		..()
		new /obj/item/clothing/accessory/armband/cargo(src)
		new /obj/item/device/encryptionkey/cargo(src)
		return

/obj/structure/closet/secure_closet/security/engine

	New()
		..()
		new /obj/item/clothing/accessory/armband/engine(src)
		new /obj/item/device/encryptionkey/eng(src)
		return

/obj/structure/closet/secure_closet/security/science

	New()
		..()
		new /obj/item/clothing/accessory/armband/science(src)
		new /obj/item/device/encryptionkey/sci(src)
		return

/obj/structure/closet/secure_closet/security/med

	New()
		..()
		new /obj/item/clothing/accessory/armband/medgreen(src)
		new /obj/item/device/encryptionkey/med(src)
		return


/obj/structure/closet/secure_closet/cabinet/detective
	name = "detective's cabinet"
	req_access = list(access_forensics_lockers)

	New()
		..()
		new /obj/item/clothing/under/rank/det/jeans(src)
		new /obj/item/clothing/suit/storage/toggle/investigator(src)
		new /obj/item/clothing/suit/storage/toggle/investigator/alt(src)
		if(prob(50))
			new /obj/item/clothing/head/det_hat(src)
			new /obj/item/clothing/under/rank/det(src)
			new /obj/item/clothing/shoes/brown(src)
			new /obj/item/clothing/suit/storage/det_suit(src)
		else
			new /obj/item/clothing/head/det_hat/black(src)
			new /obj/item/clothing/under/rank/det/black(src)
			new /obj/item/clothing/shoes/laceup(src)
			new /obj/item/clothing/suit/storage/det_suit/black(src)
		new /obj/item/weapon/storage/box/evidence(src)
		new /obj/item/device/radio/headset/sec/alt(src)
		new /obj/item/clothing/suit/storage/vest/detective(src)
		new /obj/item/ammo_magazine/c45m(src)
		new /obj/item/ammo_magazine/c45m(src)
		new /obj/item/taperoll(src)
		new /obj/item/weapon/gun/projectile/colt/detective(src)
		new /obj/item/clothing/accessory/holster/gun/armpit(src)
		new /obj/item/weapon/storage/belt/detective(src)
		new /obj/item/clothing/accessory/badge/sec/detective(src)
		new /obj/item/clothing/gloves/black(src)
		new /obj/item/clothing/glasses/hud/security(src)
		return

/obj/structure/closet/secure_closet/cabinet/forentech
	name = "forensic technician's cabinet"
	req_access = list(access_forensics_lockers)

	New()
		..()
		new /obj/item/clothing/suit/storage/det_suit/seven(src)
		new /obj/item/clothing/under/rank/forentech(src)
		new /obj/item/clothing/suit/storage/forensics/blue(src)
		new /obj/item/clothing/suit/storage/forensics/red(src)
		new /obj/item/clothing/suit/storage/toggle/labcoat/forensic(src)
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/clothing/accessory/badge/sec/detective(src)
		new /obj/item/clothing/gloves/latex(src)
		new /obj/item/weapon/storage/box/evidence(src)
		new /obj/item/device/radio/headset/sec(src)
		new /obj/item/device/radio/headset/sec/alt(src)
		new /obj/item/clothing/suit/storage/toggle/labcoat/forensic(src)
		new /obj/item/clothing/under/rank/forensic(src)
		new /obj/item/weapon/storage/belt/detective(src)
		new /obj/item/taperoll(src)
		new /obj/item/weapon/storage/briefcase/crimekit(src)
		return


/obj/structure/closet/secure_closet/injection
	name = "lethal injections locker"
	req_access = list(access_captain)

	New()
		..()
		new /obj/item/weapon/reagent_containers/syringe/ld50_syringe/choral(src)
		new /obj/item/weapon/reagent_containers/syringe/ld50_syringe/choral(src)
		return



/obj/structure/closet/secure_closet/brig
	name = "brig locker"
	req_access = list(access_brig)
	anchored = 1
	var/id = null

	New()
		..()
		new /obj/item/clothing/under/color/orange( src )
		new /obj/item/clothing/shoes/orange( src )
		return



/obj/structure/closet/secure_closet/courtroom
	name = "courtroom locker"
	req_access = list(access_court)

	New()
		..()
		new /obj/item/clothing/shoes/brown(src)
		new /obj/item/weapon/paper/Court (src)
		new /obj/item/weapon/paper/Court (src)
		new /obj/item/weapon/paper/Court (src)
		new /obj/item/weapon/pen (src)
		new /obj/item/clothing/suit/judgerobe (src)
		new /obj/item/clothing/head/powdered_wig (src)
		new /obj/item/weapon/storage/briefcase(src)
		return

/obj/structure/closet/secure_closet/wall/batman
	name = "head of personnel's emergency suit"
	desc = "It's a secure wall-mounted storage unit for justice."
	icon_state = "batman_wall_closed"
	icon_opened = "batman_wall_open"
	icon_broken = "batman_wall_broken"
	req_access = list(access_hop)

	New()
		..()
		new /obj/item/clothing/mask/gas/batman(src)
		new /obj/item/clothing/under/batman(src)
		new /obj/item/clothing/gloves/black/batman(src)
		new /obj/item/clothing/shoes/swat/batman(src)
		new /obj/item/weapon/storage/belt/security/batman(src)
		return
