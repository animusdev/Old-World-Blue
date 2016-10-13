/obj/structure/closet/secure_closet/cabinet
	icon_state = "cabinetdetective"
	icon_opened = "cabinetdetective_open"
	icon_broken = "cabinetdetective_broken"

/obj/structure/closet/secure_closet/personal/cabinet/update_icon()
	overlays.Cut()
	if(opened)
		icon_state = icon_opened
	else
		if(broken)
			icon_state = icon_broken
		else
			icon_state = icon_closed
			if(locked)
				overlays += locked_overlay
