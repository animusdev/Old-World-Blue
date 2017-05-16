/obj/item/weapon/dnainjector
	name = "\improper DNA injector"
	desc = "This injects the person with DNA."
	icon = 'icons/obj/items.dmi'
	icon_state = "dnainjector"
	var/block=0
	var/datum/dna2/record/buf=null
	var/s_time = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = ITEM_SIZE_TINY
	slot_flags = SLOT_EARS
	var/uses = 1
	var/nofail
	var/is_bullet = 0
	var/inuse = 0

	// USE ONLY IN PREMADE SYRINGES.  WILL NOT WORK OTHERWISE.
	var/datatype=0
	var/value=0

/obj/item/weapon/dnainjector/New()
	if(datatype && block)
		buf=new
		buf.dna=new
		buf.types = datatype
		buf.dna.ResetSE()
		//testing("[name]: DNA2 SE blocks prior to SetValue: [english_list(buf.dna.SE)]")
		SetValue(src.value)
		//testing("[name]: DNA2 SE blocks after SetValue: [english_list(buf.dna.SE)]")

/obj/item/weapon/dnainjector/proc/GetRealBlock(var/selblock)
	if(selblock==0)
		return block
	else
		return selblock

/obj/item/weapon/dnainjector/proc/GetState(var/selblock=0)
	var/real_block=GetRealBlock(selblock)
	if(buf.types&DNA2_BUF_SE)
		return buf.dna.GetSEState(real_block)
	else
		return buf.dna.GetUIState(real_block)

/obj/item/weapon/dnainjector/proc/SetState(var/on, var/selblock=0)
	var/real_block=GetRealBlock(selblock)
	if(buf.types&DNA2_BUF_SE)
		return buf.dna.SetSEState(real_block,on)
	else
		return buf.dna.SetUIState(real_block,on)

/obj/item/weapon/dnainjector/proc/GetValue(var/selblock=0)
	var/real_block=GetRealBlock(selblock)
	if(buf.types&DNA2_BUF_SE)
		return buf.dna.GetSEValue(real_block)
	else
		return buf.dna.GetUIValue(real_block)

/obj/item/weapon/dnainjector/proc/SetValue(var/val,var/selblock=0)
	var/real_block=GetRealBlock(selblock)
	if(buf.types&DNA2_BUF_SE)
		return buf.dna.SetSEValue(real_block,val)
	else
		return buf.dna.SetUIValue(real_block,val)

/obj/item/weapon/dnainjector/proc/inject(mob/living/carbon/human/H, mob/living/user)
	if(istype(H))
		H.radiation += rand(5,20)

	// prevents drained people from having their DNA changed
	if(!(NOCLONE & H.status_flags))
		if (buf.types & DNA2_BUF_UI)
			if (!block) //isolated block?
				H.UpdateAppearance(buf.dna.UI.Copy())
				if (buf.types & DNA2_BUF_UE) //unique enzymes? yes
					H.real_name = buf.dna.real_name
					H.name = buf.dna.real_name
				uses--
			else
				H.dna.SetUIValue(block,src.GetValue())
				H.UpdateAppearance()
				uses--
		if (buf.types & DNA2_BUF_SE)
			if (!block) //isolated block?
				H.dna.SE = buf.dna.SE.Copy()
				H.dna.UpdateSE()
			else
				H.dna.SetSEValue(block,src.GetValue())
			//TODO: DNA3 update_mutations
			//domutcheck(H, null, block!=null)
			uses--
			if(prob(5))
				trigger_side_effect(H)

	spawn(0)//this prevents the collapse of space-time continuum
		if (user)
			user.drop_from_inventory(src)
		qdel(src)
	return uses

/obj/item/weapon/dnainjector/attack(mob/living/M, mob/living/user)
	if (!istype(M))
		return
	if (!usr.IsAdvancedToolUser())
		return
	if(inuse)
		return 0

	user.visible_message(SPAN_DANG("\The [user] is trying to inject \the [M] with \the [src]!"))
	inuse = 1
	s_time = world.time
	spawn(50)
		inuse = 0

	if(!do_mob(user, M, 50))
		return

	user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
	user.do_attack_animation(M)

	M.visible_message(SPAN_DANG("\The [M] has been injected with \the [src] by \the [user]."))

	var/mob/living/carbon/human/H = M
	if(!istype(H))
		user << "<span class='warning'>Apparently it didn't work...</span>"
		return

	// Used by admin log.
	var/injected_with_monkey = ""
	//TODO: DNA3 logging.

	admin_attack_log(user, M,
		"Used the [name] to inject [M.name] ([M.ckey])",
		"Has been injected with [name] by [user.name] ([user.ckey])",
		"user \the [src][injected_with_monkey] to inject"
	)

	// Apply the DNA shit.
	inject(M, user)
	return