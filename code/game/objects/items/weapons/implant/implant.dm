#define MALFUNCTION_TEMPORARY 1
#define MALFUNCTION_PERMANENT 2


/obj/item/weapon/implant
	name = "implant"
	icon = 'icons/obj/device.dmi'
	icon_state = "implant"
	w_class = ITEM_SIZE_TINY
	var/implanted = null
	var/mob/imp_in = null
	var/obj/item/organ/external/part = null
	var/implant_color = "b"
	var/allow_reagents = 0
	var/malfunction = 0

	proc/trigger(emote, mob/living/source)
	proc/activate()

	// What does the implant do upon injection?
	// return FALSE if the implant fails (ex. Revhead and loyalty implant.)
	// return TRUE  if the implant succeeds (ex. Nonrevhead and loyalty implant.)
	proc/implanted(var/mob/living/source, var/obj/item/organ/external/affected)
		forceMove(source)
		imp_in = source
		implanted = TRUE
		if(affected)
			affected.implants += src
			part = affected
			BITSET(source.hud_updateflag, IMPLOYAL_HUD)
		on_implanted(source, affected)
		return TRUE

	proc/on_implanted(var/mob/living/source, var/obj/item/organ/external/E)

	proc/get_data()
		return "No information available"

	proc/hear(message, mob/living/source)

	proc/islegal()
		return FALSE

	proc/meltdown()	//breaks it down, making implant unrecongizible
		imp_in << SPAN_WARN("You feel something melting inside [part ? "your [part.name]" : "you"]!")
		if (part)
			part.take_damage(burn = 15, used_weapon = "Electronics meltdown")
		else
			var/mob/living/M = imp_in
			M.apply_damage(15,BURN)
		name = "melted implant"
		desc = "Charred circuit in melted plastic case. Wonder what that used to be..."
		icon_state = "implant_melted"
		malfunction = MALFUNCTION_PERMANENT

	Destroy()
		if(part)
			part.implants.Remove(src)
		..()
