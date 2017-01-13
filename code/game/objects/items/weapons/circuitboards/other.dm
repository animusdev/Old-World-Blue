#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

//Stuff that doesn't fit into any category goes here

/obj/item/weapon/circuitboard/aicore
	name = T_BOARD("AI core")
	origin_tech = list(TECH_DATA = 4, TECH_BIO = 2)
	board_type = "other"

/obj/item/weapon/circuitboard/pdapainter
	name = T_BOARD("PDA painter")
	build_path = /obj/machinery/pdapainter
	board_type = "machine"
	origin_tech = list(TECH_DATA = 2)
//	frame_desc = "1 Micro Manipulator, 1 Micro-Laser, and 1 Console Screen."
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 1,
		/obj/item/weapon/stock_parts/micro_laser = 1,
		/obj/item/weapon/stock_parts/console_screen = 1)