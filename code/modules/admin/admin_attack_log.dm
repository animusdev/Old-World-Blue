/mob/var/lastattacker = null
/mob/var/lastattacked = null
/mob/var/attack_log = list( )

proc/log_and_message_admins(var/message as text, var/mob/user = usr)
	log_admin(user ? "[key_name(user)] [message]" : "EVENT [message]")

proc/log_and_message_admins_many(var/list/mob/users, var/message)
	if(!users || !users.len)
		return

	var/list/user_keys = list()
	for(var/mob/user in users)
		user_keys += key_name(user)

	log_admin("[english_list(user_keys)] [message]", null, 1)

proc/add_attack_log(var/mob/attacker, var/mob/victim, var/attacker_message, var/victim_message, var/log_message)
	if(victim)
		victim.attack_log   += "\[[time_stamp()]\] <font color='orange'>[key_name(attacker)] - [victim_message]</font>"
	if(attacker)
		attacker.attack_log += "\[[time_stamp()]\] <font color='red'>[key_name(victim)] - [attacker_message]</font>"
	log_attack("[key_name(attacker)] [log_message] [key_name(victim)] ([attacker? uppertext(attacker.a_intent) : "N/A"])", attacker, 0)

proc/admin_attack_log(var/mob/attacker, var/mob/victim, var/attacker_message, var/victim_message, var/admin_message)
	if(victim)
		victim.attack_log   += "\[[time_stamp()]\] <font color='orange'>[key_name(attacker)] - [victim_message]</font>"
	if(attacker)
		attacker.attack_log += "\[[time_stamp()]\] <font color='red'>[key_name(victim)] - [attacker_message]</font>"
	log_attack("[key_name(attacker)] [admin_message] [key_name(victim)] ([attacker? uppertext(attacker.a_intent) : "N/A"])", victim)


proc/admin_attacker_log_many_victims(var/mob/attacker, var/list/mob/victims, var/attacker_message, var/victim_message, var/admin_message)
	if(!victims || !victims.len)
		return

	for(var/mob/victim in victims)
		admin_attack_log(attacker, victim, attacker_message, victim_message, admin_message)

proc/self_attack_log(var/mob/affected, var/attack_message, var/danger)
	var/message = "\[[time_stamp()]] <font color='[danger?"red":"orange"]'>[attack_message]</font>"
	affected.attack_log += message
	log_attack("[key_name(affected)] [attack_message].", affected)

proc/admin_inject_log(mob/attacker, mob/victim, obj/item/weapon, reagents, amount_transferred, violent=0)
	if(violent)
		violent = "violently "
	else
		violent = ""
	admin_attack_log(
		attacker, victim,
		"used \the [weapon] to [violent]inject - [reagents] - [amount_transferred]u transferred",
		"was [violent]injected with \the [weapon] - [reagents] - [amount_transferred]u transferred",
		"used \the [weapon] to [violent]inject [reagents] ([amount_transferred]u transferred) into"
	)
