/obj/structure/table

	standard
		icon_state = "plain_preview"
		color = "#EEEEEE"
		New()
			material = get_material_by_name(DEFAULT_TABLE_MATERIAL)
			..()

	steel
		icon_state = "plain_preview"
		color = "#666666"
		New()
			material = get_material_by_name(MATERIAL_STEEL)
			..()

	marble
		icon_state = "stone_preview"
		color = "#CCCCCC"
		New()
			material = get_material_by_name(MATERIAL_MARBLE)
			..()

	reinforced
		icon_state = "reinf_preview"
		color = "#EEEEEE"
		New()
			material = get_material_by_name(DEFAULT_TABLE_MATERIAL)
			reinforced = get_material_by_name(DEFAULT_WALL_MATERIAL)
			..()

	steel_reinforced
		icon_state = "reinf_preview"
		color = "#666666"
		New()
			material = get_material_by_name(MATERIAL_STEEL)
			reinforced = get_material_by_name(MATERIAL_STEEL)
			..()

	wooden_reinforced
		icon_state = "reinf_wood_preview"
		color = "#CF570D"
		New()
			material = get_material_by_name(MATERIAL_WOOD)
			reinforced = get_material_by_name(MATERIAL_WOOD)
			..()

	woodentable
		icon_state = "plain_preview"
		color = "#824B28"
		New()
			material = get_material_by_name(MATERIAL_WOOD)
			..()

	gamblingtable
		icon_state = "gamble_preview"
		New()
			material = get_material_by_name(MATERIAL_WOOD)
			carpeted = 1
			..()

	glass
		icon_state = "plain_preview"
		color = "#00E1FF"
		alpha = 77 // 0.3 * 255
		New()
			material = get_material_by_name(MATERIAL_GLASS)
			..()

	holotable
		icon_state = "holo_preview"
		color = "#EEEEEE"
		New()
			material = get_material_by_name("holo[MATERIAL_STEEL]")
			..()

	holotable/wood
		color = "#824B28"
		New()
			..()
			material = get_material_by_name("holowood")
