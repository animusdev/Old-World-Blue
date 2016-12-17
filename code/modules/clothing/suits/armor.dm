/obj/item/clothing/suit/armor
	allowed = list(
		/obj/item/weapon/gun/energy, /obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/gun/projectile, /obj/item/ammo_magazine,/obj/item/ammo_casing,
		/obj/item/weapon/melee/baton, /obj/item/weapon/handcuffs,/obj/item/device/flashlight,
		/obj/item/weapon/melee/telebaton, /obj/item/clothing/head/helmet/security,
		/obj/item/clothing/mask/gas
	)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	item_flags = THICKMATERIAL

	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6


/obj/item/clothing/suit/armor/vest
	name = "armor"
	desc = "An armored vest that protects against some damage."
	icon_state = "armor"
	item_state = "armor"
	blood_overlay_type = "armor"
	armor = list(melee = 50, bullet = 15, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/vest/security
	name = "security armor"
	desc = "An armored vest that protects against some damage. This one has a NanoTrasen corporate badge."
	icon_state = "armorsec"

/obj/item/clothing/suit/armor/riot
	name = "Riot Suit"
	desc = "A suit of armor with heavy padding to protect against melee attacks. Looks like it might impair movement."
	icon_state = "riot"
	item_state = "swat_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	slowdown = 1
	armor = list(melee = 80, bullet = 10, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT
	siemens_coefficient = 0.5

/obj/item/clothing/suit/armor/bulletproof
	name = "Bulletproof Vest"
	desc = "A vest that excels in protecting the wearer against high-velocity solid projectiles."
	icon_state = "bulletproof"
	blood_overlay_type = "armor"
	armor = list(melee = 10, bullet = 80, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.7

/obj/item/clothing/suit/armor/laserproof
	name = "Ablative Armor Vest"
	desc = "A vest that excels in protecting the wearer against energy projectiles."
	icon_state = "armor_reflec"
	item_state = "armor_reflec"
	blood_overlay_type = "armor"
	armor = list(melee = 10, bullet = 10, laser = 80, energy = 50, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/knight
	name = "plate armour"
	desc = "A classic suit of plate armour, highly effective at stopping melee attacks."
	icon_state = "knight_green"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	slowdown = 1
	armor = list(melee = 50, bullet = 5, laser = 5, energy = 5, bomb = 0, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/armor/knight/yellow
	icon_state = "knight_yellow"

/obj/item/clothing/suit/armor/knight/blue
	icon_state = "knight_blue"

/obj/item/clothing/suit/armor/knight/red
	icon_state = "knight_red"

/obj/item/clothing/suit/armor/knight/green
	icon_state = "knight_green"

/obj/item/clothing/suit/armor/knight/templar
	name = "crusader armour"
	desc = "Deus Vult!"
	icon_state = "knight_templar"


/obj/item/clothing/suit/armor/swat
	name = "swat suit"
	desc = "A heavily armored suit that protects against moderate damage. Used in special operations."
	icon_state = "deathsquad"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS
	allowed = list( /obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton, \
					/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen)
	slowdown = 1
	w_class = 5
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 100)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6


/obj/item/clothing/suit/armor/swat/officer
	name = "officer jacket"
	desc = "An armored jacket used in special operations."
	icon_state = "detective"
	blood_overlay_type = "coat"
	flags_inv = 0
	body_parts_covered = UPPER_TORSO|ARMS


/obj/item/clothing/suit/armor/det_suit
	name = "armor"
	desc = "An armored vest with a detective's badge on it."
	icon_state = "detective-armor"
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	armor = list(melee = 50, bullet = 15, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)


//Reactive armor
//When the wearer gets hit, this armor will teleport the user a short distance away
//(to safety or to more danger, no one knows. That's the fun of it!)
/obj/item/clothing/suit/armor/reactive
	name = "Reactive Teleport Armor"
	desc = "Someone separated our Research Director from their own head!"
	var/active = 0.0
	icon_state = "reactiveoff"
	blood_overlay_type = "armor"
	slowdown = 1
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/reactive/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/attack_text = "the attack")
	if(prob(50)) //броня шредигера
		user.visible_message("<span class='danger'>The reactive teleport system flings [user] clear of the attack!</span>")
		var/list/turfs = new/list()
		for(var/turf/T in orange(6, user))
			if(istype(T,/turf/space)) continue
			if(T.density) continue
			if(T.x>world.maxx-6 || T.x<6)	continue
			if(T.y>world.maxy-6 || T.y<6)	continue
			turfs += T
		if(!turfs.len) turfs += pick(/turf in orange(6))
		var/turf/picked = pick(turfs)
		if(!isturf(picked)) return

		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, user.loc)
		spark_system.start()
		playsound(user.loc, "sparks", 50, 1)

		user.loc = picked
		return 1
	return 0

/obj/item/clothing/suit/armor/reactive/attack_self(mob/user as mob)
	src.active = !( src.active )
	if (src.active)
		user << "\blue The reactive armor is now active."
		src.icon_state = "reactive"
	else
		user << "\blue The reactive armor is now inactive."
		src.icon_state = "reactiveoff"
		src.add_fingerprint(user)
	return

/obj/item/clothing/suit/armor/reactive/emp_act(severity)
	active = 0
	src.icon_state = "reactiveoff"
	..()

/obj/item/clothing/suit/armor/tactical
	name = "tactical armor"
	desc = "A suit of armor most often used by Special Weapons and Tactics squads. \
			Includes padded vest with pockets along with shoulder and kneeguards."
	icon_state = "swatarmor"
	var/obj/item/weapon/gun/holstered = null
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	slowdown = 1
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 20, bio = 0, rad = 0)
	siemens_coefficient = 0.7
	var/obj/item/clothing/accessory/holster/holster = new

/obj/item/clothing/suit/armor/tactical/attackby(obj/item/W as obj, mob/user as mob)
	..()
	holster.attackby(W, user)

/obj/item/clothing/suit/armor/tactical/verb/holster()
	set name = "Holster"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living)) return
	if(usr.stat) return

	if(!holster.holstered)
		var/obj/item/W = usr.get_active_hand()
		if(!istype(W, /obj/item))
			usr << "<span class='warning'>You need your gun equiped to holster it.</span>"
			return
		holster.holster(W, usr)
	else
		holster.unholster(usr)

//Non-hardsuit ERT armor.
/obj/item/clothing/suit/armor/vest/ert
	name = "emergency response team armor"
	desc = "A set of armor worn by members of the NanoTrasen Emergency Response Team."
	icon_state = "ertarmor_cmd"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 20, bio = 0, rad = 0)

//Commander
/obj/item/clothing/suit/armor/vest/ert/command
	name = "emergency response team commander armor"
	desc = "A set of armor worn by the commander of a NanoTrasen Emergency Response Team. Has blue highlights."

//Security
/obj/item/clothing/suit/armor/vest/ert/security
	name = "emergency response team security armor"
	desc = "A set of armor worn by security members of the NanoTrasen Emergency Response Team. Has red highlights."
	icon_state = "ertarmor_sec"

//Engineer
/obj/item/clothing/suit/armor/vest/ert/engineer
	name = "emergency response team engineer armor"
	desc = "A set of armor worn by engineering members of the NanoTrasen Emergency Response Team. \
			Has orange highlights."
	icon_state = "ertarmor_eng"

//Medical
/obj/item/clothing/suit/armor/vest/ert/medical
	name = "emergency response team medical armor"
	desc = "A set of armor worn by medical members of the NanoTrasen Emergency Response Team. \
			Has red and white highlights."
	icon_state = "ertarmor_med"

//New Vests
/obj/item/clothing/suit/storage/vest
	name = "armor vest"
	desc = "A simple kevlar plate carrier."
	icon_state = "kvest"
	armor = list(melee = 50, bullet = 15, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	allowed = list( /obj/item/weapon/gun, /obj/item/weapon/reagent_containers/spray/pepper, /obj/item/ammo_magazine,\
					/obj/item/ammo_casing, /obj/item/weapon/melee/baton, /obj/item/weapon/handcuffs, \
					/obj/item/device/flashlight, /obj/item/weapon/melee/telebaton, \
					/obj/item/clothing/head/helmet/security, /obj/item/clothing/mask/gas)

/obj/item/clothing/suit/storage/vest/warden
	name = "Warden's jacket"
	desc = "An armoured jacket with silver rank pips and livery."
	icon_state = "warden_jacket"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/suit/storage/hos
	name = "armored coat"
	desc = "A greatcoat enhanced with a special alloy for some protection and style."
	icon_state = "hos"
	item_state = "jensencoat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	armor = list(melee = 65, bullet = 30, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT
	siemens_coefficient = 0.6

/obj/item/clothing/suit/storage/hos/solyarkin
	name = "Internal Security coat"
	desc = "A lot of time ago this coat worn only internal security members. \
			But now, nobody remember about those great men"
	icon_state = "commi_coat"

/obj/item/clothing/suit/storage/hos/jensen
	name = "armored trenchcoat"
	desc = "A trenchcoat augmented with a special alloy for some protection and style."
	icon_state = "jensencoat"

/obj/item/clothing/suit/storage/vest/seclight
	name = "lightened plate carrier"
	desc = "That's a light plate carrier without groin plate and additional pouches."
	icon_state = "seclightvest_nobadge"
	icon_badge = "seclightvest_badge"
	icon_nobadge = "seclightvest_nobadge"
	armor = list(melee = 55, bullet = 35, laser = 55, energy = 10, bomb = 35, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/vest/ems
	name = "EMS armor vest"
	desc = "That's a light plate carrier with additional pouches and EMS sign."
	icon_state = "emsarmorvest_nobadge"
	icon_badge = "emsarmorvest_badge"
	icon_nobadge = "emsarmorvest_nobadge"
	allowed = list( /obj/item/device/analyzer, /obj/item/stack/medical, /obj/item/weapon/dnainjector,\
					/obj/item/weapon/reagent_containers/dropper, /obj/item/weapon/reagent_containers/syringe, \
					/obj/item/weapon/reagent_containers/hypospray, /obj/item/device/healthanalyzer, \
					/obj/item/device/flashlight/pen, /obj/item/weapon/tank/emergency_oxygen, /obj/item/device/radio, /obj/item/clothing/mask/gas)

/obj/item/clothing/suit/storage/vest/officer
	name = "officer armor vest"
	desc = "A simple kevlar plate carrier belonging to Nanotrasen. \
			This one has a security holobadge clipped to the chest."
	icon_state = "officervest_nobadge"
	icon_badge = "officervest_badge"
	icon_nobadge = "officervest_nobadge"

/obj/item/clothing/suit/storage/vest/warden
	name = "warden armor vest"
	desc = "A simple kevlar plate carrier belonging to Nanotrasen. This one has a silver badge clipped to the chest."
	icon_state = "wardenvest_nobadge"
	icon_badge = "wardenvest_badge"
	icon_nobadge = "wardenvest_nobadge"

/obj/item/clothing/suit/storage/vest/hos
	name = "commander armor vest"
	desc = "A simple kevlar plate carrier belonging to Nanotrasen. This one has a gold badge clipped to the chest."
	icon_state = "hosvest_nobadge"
	icon_badge = "hosvest_badge"
	icon_nobadge = "hosvest_nobadge"

/obj/item/clothing/suit/storage/vest/pcrc
	name = "PCRC armor vest"
	desc = "A simple kevlar plate carrier belonging to Proxima Centauri Risk Control. \
			This one has a PCRC crest clipped to the chest."
	icon_state = "pcrcvest_nobadge"
	icon_badge = "pcrcvest_badge"
	icon_nobadge = "pcrcvest_nobadge"

/obj/item/clothing/suit/storage/vest/detective
	name = "detective armor vest"
	desc = "A simple kevlar plate carrier in a vintage brown, it has a badge clipped to the chest that reads, \
			'Private investigator'."
	icon_state = "detectivevest_nobadge"
	icon_badge = "detectivevest_badge"
	icon_nobadge = "detectivevest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy
	name = "heavy armor vest"
	desc = "A heavy kevlar plate carrier with webbing attached."
	icon_state = "webvest"
	armor = list(melee = 50, bullet = 40, laser = 50, energy = 25, bomb = 30, bio = 0, rad = 0)
	slowdown = 1

/obj/item/clothing/suit/storage/vest/heavy/officer
	name = "officer heavy armor vest"
	desc = "A heavy kevlar plate carrier belonging to Nanotrasen with webbing attached. \
			This one has a security holobadge clipped to the chest."
	icon_state = "officerwebvest_nobadge"
	icon_badge = "officerwebvest_badge"
	icon_nobadge = "officerwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/security
	name = "heavy plate carrier"
	desc = "A very heavy plate carrier belonging to Nanotrasen with webbing and groin armor plate attached. \
			This one has a security holobadge clipped to the chest."
	icon_state = "secheavyvest_nobadge"
	icon_badge = "secheavyvest_badge"
	icon_nobadge = "secheavyvest_nobadge"
	armor = list(melee = 65, bullet = 55, laser = 65, energy = 50, bomb = 55, bio = 0, rad = 0)
	slowdown = 2
	w_class = 4
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/obj/item/clothing/suit/storage/vest/heavy/securitymedium
	name = "plate carrier"
	desc = "A medium-armoured plate carrier belonging to Nanotrasen with webbing and groin armor plate attached. \
			This one has a security holobadge clipped to the chest."
	icon_state = "secmediumvest_nobadge"
	icon_badge = "secmediumvest_badge"
	icon_nobadge = "secmediumvest_nobadge"
	armor = list(melee = 60, bullet = 45, laser = 50, energy = 40, bomb = 40, bio = 0, rad = 0)
	slowdown = 1
	w_class = 4
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/suit/storage/vest/heavy/warden
	name = "warden heavy armor vest"
	desc = "A heavy kevlar plate carrier belonging to Nanotrasen with webbing attached. \
			This one has a silver badge clipped to the chest."
	icon_state = "wardenwebvest_nobadge"
	icon_badge = "wardenwebvest_badge"
	icon_nobadge = "wardenwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/hos
	name = "commander heavy armor vest"
	desc = "A heavy kevlar plate carrier belonging to Nanotrasen with webbing attached. \
			This one has a gold badge clipped to the chest."
	icon_state = "hoswebvest_nobadge"
	icon_badge = "hoswebvest_badge"
	icon_nobadge = "hoswebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/pcrc
	name = "PCRC heavy armor vest"
	desc = "A heavy kevlar plate carrier belonging to Proxima Centauri Risk Control with webbing attached. \
			This one has a PCRC crest clipped to the chest."
	icon_state = "pcrcwebvest_nobadge"
	icon_badge = "pcrcwebvest_badge"
	icon_nobadge = "pcrcwebvest_nobadge"

//Provides the protection of a merc voidsuit, but only covers the chest/groin, and also takes up a suit slot.
//In exchange it has no slowdown and provides storage.
/obj/item/clothing/suit/storage/vest/heavy/merc
	name = "heavy armor vest"
	desc = "A high-quality heavy kevlar plate carrier in a fetching tan. \
			The vest is surprisingly flexible, and possibly made of an advanced material."
	icon_state = "mercwebvest"
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)
	slowdown = 0

//All of the armor below is mostly unused


/obj/item/clothing/suit/armor/centcomm
	name = "Cent. Com. armor"
	desc = "A suit that protects against some damage."
	icon_state = "centcom"
	item_state = "centcom"
	w_class = 4//bulky item
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	allowed = list( /obj/item/weapon/gun/energy, /obj/item/weapon/melee/baton, /obj/item/weapon/handcuffs,\
					/obj/item/weapon/tank/emergency_oxygen)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/heavy
	name = "heavy armor"
	desc = "A heavily armored suit that protects against moderate damage."
	icon_state = "heavy"
	item_state = "swat_suit"
	w_class = 4//bulky item
	gas_transfer_coefficient = 0.90
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	slowdown = 3
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/armor/tdome/red
	name = "Thunderdome suit (red)"
	desc = "Reddish armor."
	icon_state = "tdred"
	item_state = "tdred"
	siemens_coefficient = 1

/obj/item/clothing/suit/armor/tdome/green
	name = "Thunderdome suit (green)"
	desc = "Pukish armor."
	icon_state = "tdgreen"
	item_state = "tdgreen"
	siemens_coefficient = 1

/obj/item/clothing/suit/storage/vest/heavy/army
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	name = "armor rig vest"
	desc = "That's the tan armor vest with a lot of pockets."
	icon_state = "armorarmy"
	item_state = "swat_suit"
	armor = list(melee = 30, bullet = 55, laser = 55, energy = 40, bomb = 40, bio = 0, rad = 0)
	slowdown = 1

/obj/item/clothing/suit/storage/vest/heavy/army/medic
	body_parts_covered = UPPER_TORSO|ARMS
	icon_state = "armorarmy_medic"
	armor = list(melee = 25, bullet = 50, laser = 50, energy = 40, bomb = 40, bio = 0, rad = 0)
	slowdown = 0

/obj/item/clothing/suit/storage/vest/heavy/army/corporal
	icon_state = "armorarmy_corporal"
	armor = list(melee = 35, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)
	slowdown = 1

/obj/item/clothing/suit/storage/vest/heavy/army/sergeant
	icon_state = "armorarmy_sergeant"
	armor = list(melee = 35, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)
	slowdown = 1
