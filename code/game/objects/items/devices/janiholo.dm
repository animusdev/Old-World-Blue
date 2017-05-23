/obj/item/device/janiholo
	icon = 'icons/obj/janitor.dmi'
	name = "Holosign controller"
	icon_state = "janiholo"
	desc = "Up to date way for marking wet floor."
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_SMALL
	var/life_time = 300
	var/on = FALSE
	var/max_holos = 8
	var/list/holos = list()

/obj/item/device/janiholo/attack_self(var/mob/living/user)
	on = !on
	if(on)
		user << SPAN_NOTE("[src] in now on")
		icon_state = "[initial(icon_state)]_on"
	else
		user << SPAN_NOTE("[src] in now off")
		icon_state = initial(icon_state)

/obj/item/device/janiholo/verb/set_lifetime()
	set name = "Set holo life time"
	set category = "Objects"
	set src in usr

	if(!isliving(usr))
		return

	var/list/values = list("Short" = 100, "Medium" = 300, "Long" = 500)
	var/NLT = input("Select new lifetime for holos") in values
	if(NLT && (usr.get_active_hand() == src || usr.get_inactive_hand() == src))
		life_time = values[NLT]
		usr << SPAN_NOTE("[src] life time switch set to [lowertext(NLT)].")

/obj/item/device/janiholo/afterattack(var/atom/A, var/mob/living/user)
	if(!on || !(isturf(A) || isturf(A.loc)))
		return
	var/obj/effect/overlay/janiholo/JH = locate() in get_turf(A)
	if(JH)
		qdel(JH)
		return
	if(holos.len >= max_holos)
		user << SPAN_NOTE("\The [src] is recharging!")
		return
	PoolOrNew(/obj/effect/overlay/janiholo, list(get_turf(A), src))

/obj/effect/overlay/janiholo
	name = "Holographic sign"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "janihologram"
	anchored = 1
	var/lifetime = 500
	var/obj/item/device/janiholo/creator = null

/obj/effect/overlay/janiholo/attackby()
	return

/obj/effect/overlay/janiholo/New(var/turf/location, var/obj/item/device/janiholo/JH)
	..(location)
	processing_objects |= src
	if(JH)
		creator = JH
		creator.holos |= src
		lifetime = creator.life_time

/obj/effect/overlay/janiholo/process()
	if(lifetime > 0)
		lifetime -= 1
	else
		qdel(src)

/obj/effect/overlay/janiholo/Destroy()
	. = ..()
	processing_objects -= src
	if(creator)
		creator.holos -= src
