// Uniform slot
/datum/gear/uniform
	display_name = "blazer, blue"
	path = /obj/item/clothing/under/blazer
	slot = slot_w_uniform
	sort_category = "Uniforms and Dress"

/datum/gear/uniform/job_skirt
	display_name = "job, skirt"
	description = "Totally as your default uniform, but with skirt!"
	path = /obj/item/clothing/under
	allowed_roles = list("QM", "Cargo Technician","Chief Engineer","Station Engineer","Atmospheric Technician","Roboticist",\
	"Research Director","Scientist","Chief Medical Officer","Chemist","Medical Doctor","Geneticist",\
	"Head of Security","Warden","Security Officer")

/datum/gear/uniform/job_skirt/spawn_for(var/mob/living/carbon/human/H)
	if(allowed_roles && !(H.job in allowed_roles))
		H << "<span class='warning'>Your current job does not permit you to spawn with [display_name]!</span>"
		return null

	var/tmp_path = path
	switch(H.job)
		if("QM") tmp_path = /obj/item/clothing/under/rank/qm/skirt
		if("Cargo Technician") tmp_path = /obj/item/clothing/under/rank/cargo/skirt
		if("Chief Engineer") tmp_path = /obj/item/clothing/under/rank/chief_engineer/skirt
		if("Station Engineer") tmp_path = /obj/item/clothing/under/rank/engineer/skirt
		if("Atmospheric Technician") tmp_path = /obj/item/clothing/under/rank/atmospheric_technician/skirt
		if("Roboticist") tmp_path = /obj/item/clothing/under/rank/roboticist/skirt
		if("Research Director") tmp_path = /obj/item/clothing/under/rank/research_director/skirt
		if("Scientist") tmp_path = /obj/item/clothing/under/rank/scientist/skirt
		if("Chief Medical Officer") tmp_path = /obj/item/clothing/under/rank/chief_medical_officer/skirt
		if("Chemist") tmp_path = /obj/item/clothing/under/rank/chemist/skirt
		if("Medical Doctor")
			tmp_path = /obj/item/clothing/under/rank/medical/skirt
			if(H.mind && H.mind.role_alt_title == "Virologist")
				tmp_path = /obj/item/clothing/under/rank/virologist/skirt
		if("Geneticist") tmp_path = /obj/item/clothing/under/rank/geneticist/skirt
		if("Head of Security") tmp_path = /obj/item/clothing/under/rank/head_of_security/skirt
		if("Warden") tmp_path = /obj/item/clothing/under/rank/warden/skirt
		if("Security Officer") tmp_path = /obj/item/clothing/under/rank/security/skirt
		else return null

	return new tmp_path(H)


/datum/gear/uniform/job_jeans
	display_name = "job, jeans"
	description = "Totally as your default uniform, but with jeans!"
	path = /obj/item/clothing/under
	allowed_roles = list("QM", "Cargo Technician","Station Engineer","Atmospheric Technician","Detective",\
	"Research Director","Scientist","Chief Medical Officer","Chemist","Medical Doctor","Geneticist")

/datum/gear/uniform/job_jeans/spawn_for(var/mob/living/carbon/human/H)
	if(allowed_roles && !(H.job in allowed_roles))
		H << "<span class='warning'>Your current job does not permit you to spawn with [display_name]!</span>"
		return null

	var/tmp_path = path
	switch(H.job)
		if("QM") tmp_path = /obj/item/clothing/under/rank/qm/jeans
		if("Cargo Technician") tmp_path = /obj/item/clothing/under/rank/cargo/jeans
		if("Station Engineer") tmp_path = /obj/item/clothing/under/rank/engineer/jeans
		if("Atmospheric Technician") tmp_path = /obj/item/clothing/under/rank/atmospheric_technician/jeans
		if("Scientist") tmp_path = /obj/item/clothing/under/rank/scientist/jeans
		if("Chief Medical Officer") tmp_path = /obj/item/clothing/under/rank/chief_medical_officer/jeans
		if("Chemist") tmp_path = /obj/item/clothing/under/rank/chemist/jeans
		if("Medical Doctor")
			tmp_path = /obj/item/clothing/under/rank/medical/jeans
			if(H.mind && H.mind.role_alt_title == "Virologist")
				tmp_path = /obj/item/clothing/under/rank/virologist/jeans
		if("Geneticist") tmp_path = /obj/item/clothing/under/rank/geneticist/jeans
		if("Detective")  tmp_path = /obj/item/clothing/under/rank/det/jeans
		else return null

	return new tmp_path(H)


/datum/gear/uniform/cheongsam
	display_name = "cheongsam, white"
	path = /obj/item/clothing/under/cheongsam

/datum/gear/uniform/kilt
	display_name = "kilt"
	path = /obj/item/clothing/under/kilt

/datum/gear/uniform/blackjumpskirt
	display_name = "jumpskirt, black"
	path = /obj/item/clothing/under/blackjumpskirt

/datum/gear/uniform/blackfjumpsuit
	display_name = "jumpsuit, female-black"
	path = /obj/item/clothing/under/color/blackf

/datum/gear/uniform/rainbow
	display_name = "jumpsuit, rainbow"
	path = /obj/item/clothing/under/color/rainbow

/datum/gear/uniform/SID
	display_name = "jumpsuit, SID"
	path = /obj/item/clothing/under/SID

/datum/gear/uniform/plaid_skirt
	display_name = "skirt, plaid"
	path = /obj/item/clothing/under/dress/plaid_blue
	options = list(
		"blue"   = /obj/item/clothing/under/dress/plaid_blue,
		"purple" = /obj/item/clothing/under/dress/plaid_purple,
		"red"    = /obj/item/clothing/under/dress/plaid_red,
		"black"  = /obj/item/clothing/under/dress/plaid_black
	)

/datum/gear/uniform/skirt_black
	display_name = "skirt, black"
	path = /obj/item/clothing/under/blackskirt

/datum/gear/uniform/pants
	display_name = "Pants, classic jeans"
	path = /obj/item/clothing/under/pants/classicjeans

/datum/gear/uniform/pants/blackjeans
	display_name = "Pants, black"
	path = /obj/item/clothing/under/pants/blackjeans

/datum/gear/uniform/pants/white
	display_name = "Pants, white"
	path = /obj/item/clothing/under/pants/white

/datum/gear/uniform/pants/red
	display_name = "Pants, red"
	path = /obj/item/clothing/under/pants/red

/datum/gear/uniform/pants/black
	display_name = "Pants, black"
	path = /obj/item/clothing/under/pants/black

/datum/gear/uniform/pants/track
	display_name = "Pants, track"
	path = /obj/item/clothing/under/pants/track

/datum/gear/uniform/pants/tan
	display_name = "Pants, tan"
	path = /obj/item/clothing/under/pants/tan

/datum/gear/uniform/pants/jeans
	display_name = "Pants, jeans"
	path = /obj/item/clothing/under/pants/jeans

/datum/gear/uniform/pants/khaki
	display_name = "Pants, khaki"
	path = /obj/item/clothing/under/pants/khaki

/datum/gear/uniform/pants/camo
	display_name = "Pants, camo"
	path = /obj/item/clothing/under/pants/camo


/datum/gear/uniform/suit  //amish
	display_name = "suit, amish"
	path = /obj/item/clothing/under/sl_suit

/datum/gear/uniform/suit/black
	display_name = "suit, black"
	path = /obj/item/clothing/under/suit_jacket

/datum/gear/uniform/suit/shinyblack
	display_name = "suit, shiny-black"
	path = /obj/item/clothing/under/lawyer/black

/datum/gear/uniform/suit/blue
	display_name = "suit, blue"
	path = /obj/item/clothing/under/lawyer/blue

/datum/gear/uniform/suit/burgundy
	display_name = "suit, burgundy"
	path = /obj/item/clothing/under/suit_jacket/burgundy

/datum/gear/uniform/suit/checkered
	display_name = "suit, checkered"
	path = /obj/item/clothing/under/suit_jacket/checkered

/datum/gear/uniform/suit/charcoal
	display_name = "suit, charcoal"
	path = /obj/item/clothing/under/suit_jacket/charcoal

/datum/gear/uniform/suit/exec
	display_name = "suit, executive"
	path = /obj/item/clothing/under/suit_jacket/really_black

/datum/gear/uniform/suit/femaleexec
	display_name = "suit, female-executive"
	path = /obj/item/clothing/under/suit_jacket/female

/datum/gear/uniform/suit/gentle
	display_name = "suit, gentlemen"
	path = /obj/item/clothing/under/gentlesuit

/datum/gear/uniform/suit/navy
	display_name = "suit, navy"
	path = /obj/item/clothing/under/suit_jacket/navy

/datum/gear/uniform/suit/red
	display_name = "suit, red"
	path = /obj/item/clothing/under/suit_jacket/red

/datum/gear/uniform/suit/redlawyer
	display_name = "suit, lawyer-red"
	path = /obj/item/clothing/under/lawyer/red

/datum/gear/uniform/suit/oldman
	display_name = "suit, old-man"
	path = /obj/item/clothing/under/lawyer/oldman

/datum/gear/uniform/suit/purple
	display_name = "suit, purple"
	path = /obj/item/clothing/under/lawyer/purpsuit

/datum/gear/uniform/suit/tan
	display_name = "suit, tan"
	path = /obj/item/clothing/under/suit_jacket/tan

/datum/gear/uniform/suit/white
	display_name = "suit, white"
	path = /obj/item/clothing/under/scratch

/datum/gear/uniform/suit/whiteblue
	display_name = "suit, white-blue"
	path = /obj/item/clothing/under/lawyer/bluesuit

/datum/gear/uniform/sundress
	display_name = "sundress"
	path = /obj/item/clothing/under/sundress

/datum/gear/uniform/sundress/white
	display_name = "sundress, white"
	path = /obj/item/clothing/under/sundress_white

/datum/gear/uniform/dress_fire
	display_name = "flame dress"
	path = /obj/item/clothing/under/dress/dress_fire

/datum/gear/uniform/uniform_captain
	display_name = "uniform, captain's dress"
	path = /obj/item/clothing/under/dress/dress_cap
	allowed_roles = list("Captain")

/datum/gear/uniform/corpsecsuit
	display_name = "uniform, corporate (Security)"
	path = /obj/item/clothing/under/rank/security/corp
	allowed_roles = list("Head of Security","Warden","Security Officer","Detective")

/datum/gear/uniform/corpsecsuit/spawn_for(var/mob/living/carbon/human/H)
	if(allowed_roles && !(H.job in allowed_roles))
		H << "<span class='warning'>Your current job does not permit you to spawn with [display_name]!</span>"
		return null

	var/tmp_path = path
	switch(H.job)
		if("Head of Security")
			tmp_path = /obj/item/clothing/under/rank/head_of_security/corp
		if("Warden")
			tmp_path = /obj/item/clothing/under/rank/warden/corp
		if("Detective")
			tmp_path = /obj/item/clothing/under/rank/det/corp
	return new tmp_path ()

/datum/gear/uniform/uniform_hop
	display_name = "uniform, HoP's dress"
	path = /obj/item/clothing/under/dress/dress_hop
	allowed_roles = list("Head of Personnel")

/datum/gear/uniform/uniform_hr
	display_name = "uniform, HR director (HoP)"
	path = /obj/item/clothing/under/dress/dress_hr
	allowed_roles = list("Head of Personnel")

/datum/gear/uniform/navysecsuit
	display_name = "uniform, navy blue (Security)"
	path = /obj/item/clothing/under/rank/security/navyblue
	allowed_roles = list("Head of Security","Warden", "Security Officer")

/datum/gear/uniform/navysecsuit/spawn_for(var/mob/living/carbon/human/H)
	if(allowed_roles && !(H.job in allowed_roles))
		H << "<span class='warning'>Your current job does not permit you to spawn with [display_name]!</span>"
		return null

	var/tmp_path = path
	switch(H.job)
		if("Head of Security")
			tmp_path = /obj/item/clothing/under/rank/head_of_security/navyblue
		if("Warden")
			tmp_path = /obj/item/clothing/under/rank/warden/navyblue
	return new tmp_path ()

/datum/gear/uniform/dnavysecsuit
	display_name = "uniform, deep navy (Security)"
	path = /obj/item/clothing/under/rank/security/dnavy
	allowed_roles = list("Head of Security","Warden", "Security Officer")

/datum/gear/uniform/dnavysecsuit/spawn_for(var/mob/living/carbon/human/H)
	if(allowed_roles && !(H.job in allowed_roles))
		H << "<span class='warning'>Your current job does not permit you to spawn with [display_name]!</span>"
		return null

	var/tmp_path = path
	switch(H.job)
		if("Head of Security")
			tmp_path = /obj/item/clothing/under/rank/head_of_security/dnavy
		if("Warden")
			tmp_path = /obj/item/clothing/under/rank/warden/dnavy
	return new tmp_path ()

/datum/gear/uniform/squatter_outfit
	display_name = "slav squatter tracksuit"
	path = /obj/item/clothing/under/squatter_outfit
