/obj/structure/burning_barrel
	name = "burning barrel"
	desc = "cozy."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "barrel1"
	density = 1
	anchored = 1
	opacity = 0

	New()
		set_light(4)
		light_color = "#e58775"

		..()