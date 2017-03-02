/datum/species_abilities/arachna
	var/purchased_powers = list()
	var/EvolvPoint = 10
	var/mob/living/carbon/human/MyMob

/datum/species_abilities/arachna/New()
	..()
	usr.verbs += /datum/species_abilities/arachna/proc/EvolutionMenu
	MyMob = usr

/datum/species_abilities/arachna/proc/EvolutionMenu()//The new one
	set name = "-Evolution Menu-"
	set category = "Arachna"
	set desc = "Adapt yourself carefully."

	if(!usr || !usr.mind)	return
	var/mob/living/carbon/human/H = usr
	src = H.species_abilities

	if(!arachna_powerinstances.len)
		for(var/P in arachna_powers)
//			world << P
			arachna_powerinstances += new P()

	var/dat = "<html><head><title>Changling Evolution Menu</title></head>"

	//javascript, the part that does most of the work~
	dat += {"

		<head>
			<script type='text/javascript'>

				var locked_tabs = new Array();

				function updateSearch(){


					var filter_text = document.getElementById('filter');
					var filter = filter_text.value.toLowerCase();

					if(complete_list != null && complete_list != ""){
						var mtbl = document.getElementById("maintable_data_archive");
						mtbl.innerHTML = complete_list;
					}

					if(filter.value == ""){
						return;
					}else{

						var maintable_data = document.getElementById('maintable_data');
						var ltr = maintable_data.getElementsByTagName("tr");
						for ( var i = 0; i < ltr.length; ++i )
						{
							try{
								var tr = ltr\[i\];
								if(tr.getAttribute("id").indexOf("data") != 0){
									continue;
								}
								var ltd = tr.getElementsByTagName("td");
								var td = ltd\[0\];
								var lsearch = td.getElementsByTagName("b");
								var search = lsearch\[0\];
								//var inner_span = li.getElementsByTagName("span")\[1\] //Should only ever contain one element.
								//document.write("<p>"+search.innerText+"<br>"+filter+"<br>"+search.innerText.indexOf(filter))
								if ( search.innerText.toLowerCase().indexOf(filter) == -1 )
								{
									//document.write("a");
									//ltr.removeChild(tr);
									td.innerHTML = "";
									i--;
								}
							}catch(err) {   }
						}
					}

					var count = 0;
					var index = -1;
					var debug = document.getElementById("debug");

					locked_tabs = new Array();

				}

				function expand(id,name,desc,helptext,power,ownsthis){

					clearAll();

					var span = document.getElementById(id);

					body = "<table><tr><td>";

					body += "</td><td align='center'>";

					body += "<font size='2'><b>"+desc+"</b></font> <BR>"

					body += "<font size='2'><font color = 'red'><b>"+helptext+"</b></font> <BR>"

					if(!ownsthis)
					{
						body += "<a href='?src=\ref[src];P="+power+"'>Evolve</a>"
					}

					body += "</td><td align='center'>";

					body += "</td></tr></table>";


					span.innerHTML = body
				}

				function clearAll(){
					var spans = document.getElementsByTagName('span');
					for(var i = 0; i < spans.length; i++){
						var span = spans\[i\];

						var id = span.getAttribute("id");

						if(!(id.indexOf("item")==0))
							continue;

						var pass = 1;

						for(var j = 0; j < locked_tabs.length; j++){
							if(locked_tabs\[j\]==id){
								pass = 0;
								break;
							}
						}

						if(pass != 1)
							continue;




						span.innerHTML = "";
					}
				}

				function addToLocked(id,link_id,notice_span_id){
					var link = document.getElementById(link_id);
					var decision = link.getAttribute("name");
					if(decision == "1"){
						link.setAttribute("name","2");
					}else{
						link.setAttribute("name","1");
						removeFromLocked(id,link_id,notice_span_id);
						return;
					}

					var pass = 1;
					for(var j = 0; j < locked_tabs.length; j++){
						if(locked_tabs\[j\]==id){
							pass = 0;
							break;
						}
					}
					if(!pass)
						return;
					locked_tabs.push(id);
					var notice_span = document.getElementById(notice_span_id);
					notice_span.innerHTML = "<font color='red'>Locked</font> ";
					//link.setAttribute("onClick","attempt('"+id+"','"+link_id+"','"+notice_span_id+"');");
					//document.write("removeFromLocked('"+id+"','"+link_id+"','"+notice_span_id+"')");
					//document.write("aa - "+link.getAttribute("onClick"));
				}

				function attempt(ab){
					return ab;
				}

				function removeFromLocked(id,link_id,notice_span_id){
					//document.write("a");
					var index = 0;
					var pass = 0;
					for(var j = 0; j < locked_tabs.length; j++){
						if(locked_tabs\[j\]==id){
							pass = 1;
							index = j;
							break;
						}
					}
					if(!pass)
						return;
					locked_tabs\[index\] = "";
					var notice_span = document.getElementById(notice_span_id);
					notice_span.innerHTML = "";
					//var link = document.getElementById(link_id);
					//link.setAttribute("onClick","addToLocked('"+id+"','"+link_id+"','"+notice_span_id+"')");
				}

				function selectTextField(){
					var filter_text = document.getElementById('filter');
					filter_text.focus();
					filter_text.select();
				}

			</script>
		</head>


	"}

	//body tag start + onload and onkeypress (onkeyup) javascript event calls
	dat += "<body onload='selectTextField(); updateSearch();' onkeyup='updateSearch();'>"

	//title + search bar
	dat += {"

		<table width='560' align='center' cellspacing='0' cellpadding='5' id='maintable'>
			<tr id='title_tr'>
				<td align='center'>
					<font size='5'><b>Changling Evolution Menu</b></font><br>
					Hover over a power to see more information<br>
					Current evolution points left to evolve with: [EvolvPoint]<br>
					Absorb genomes to acquire more evolution points
					<p>
				</td>
			</tr>
			<tr id='search_tr'>
				<td align='center'>
					<b>Search:</b> <input type='text' id='filter' value='' style='width:300px;'>
				</td>
			</tr>
	</table>

	"}

	//player table header
	dat += {"
		<span id='maintable_data_archive'>
		<table width='560' align='center' cellspacing='0' cellpadding='5' id='maintable_data'>"}

	var/i = 1
	for(var/datum/power/arachna/P in arachna_powerinstances)
		var/ownsthis = 0

		if(P in purchased_powers)
			ownsthis = 1


		var/color = "#e6e6e6"
		if(i%2 == 0)
			color = "#f2f2f2"


		dat += {"

			<tr id='data[i]' name='[i]' onClick="addToLocked('item[i]','data[i]','notice_span[i]')">
				<td align='center' bgcolor='[color]'>
					<span id='notice_span[i]'></span>
					<a id='link[i]'
					onmouseover='expand("item[i]","[P.name]","[P.desc]","[P.helptext]","[P]",[ownsthis])'
					>
					<b id='search[i]'>Evolve [P] - Cost: [ownsthis ? "Purchased" : P.cost]</b>
					</a>
					<br><span id='item[i]'></span>
				</td>
			</tr>

		"}

		i++


	//player table ending
	dat += {"
		</table>
		</span>

		<script type='text/javascript'>
			var maintable = document.getElementById("maintable_data_archive");
			var complete_list = maintable.innerHTML;
		</script>
	</body></html>
	"}

	usr << browse(dat, "window=powers;size=900x480")


/datum/species_abilities/arachna/Topic(href, href_list)
	..()
	if(!ismob(usr))
		return

	if(href_list["P"])
//		var/datum/mind/M = usr.mind
//		if(!istype(M))
//			return
		purchasePower(usr, href_list["P"])
		call(/datum/species_abilities/arachna/proc/EvolutionMenu)()


/datum/species_abilities/arachna/proc/purchasePower(var/mob/living/carbon/M, var/Pname, var/remake_verbs = 1)
	if(!M)
		return

	var/datum/power/arachna/Thepower = Pname


	for (var/datum/power/arachna/P in arachna_powerinstances)
		//world << "[P] - [Pname] = [P.name == Pname ? "True" : "False"]"
		if(P.name == Pname)
			Thepower = P
			break


	if(Thepower == null)
		M << "This is awkward.  Arachna power purchase failed, please report this bug to a coder!"
		return

	if(Thepower in purchased_powers)
		M << "We have already evolved this ability!"
		return


	if(EvolvPoint < Thepower.cost)
		M << "We cannot evolve this..."
		return

	EvolvPoint -= Thepower.cost

	purchased_powers += Thepower

//	if(Thepower.genomecost > 0)
//		purchased_powers_history.Add("[Pname] ([Thepower.genomecost] points)")

	if(!Thepower.isVerb && Thepower.verbpath)
/*		if (!Thepower.extra_data)
			call(M, Thepower.verbpath)()
		else
			call(M, Thepower.verbpath)(Thepower.extra_data)*/
		Thepower.extra_data ? call(M, Thepower.verbpath)(Thepower.extra_data) : call(M, Thepower.verbpath)()
	else
		M.verbs += Thepower.verbpath




/mob/proc/arachna_power(var/needweb=0, var/needfood=0)
	var/mob/living/carbon/human/M = src
	var/obj/item/organ/internal/arachna/silk_gland/P = M.internal_organs_by_name["silk_gland"]
	if(!P)
		src << "<span class='warning'>Problem witch silk gland.</span>"
		return 0
	else if (P.silk < needweb)
		src << "<span class='warning'>Need more silk.</span>"
		return 0
	P.silk -= needweb
//	src << "[src] you pass!"
	return 1

/mob/proc/silk_net()
	set category = "Arachna"
	set name = "Net"

	if(!arachna_power(25))
		return

	var/mob/living/M = src

	if(M.l_hand && M.r_hand)
		M << "<span class='danger'>Your hands are full.</span>"
		return

	var/obj/item/weapon/energy_net/arachna_net/net = new(M)
	//net.creator = M
	M.put_in_hands(net)

/*/mob/proc/arachna_prepare_jump()
	set category = "Arachna"
	set name = "Leap"
	set desc = "Leap at a target and grab them aggressively."

	if(stat || paralysis || stunned || weakened || lying || restrained() || buckled)
		src << "You cannot leap in your current state."
		return*/


/mob/living/carbon/human/proc/arachna_prepare_jump()
	set name = "Prepare Jump"
	set desc = "Prepare for jump on someone"
	set category = "Arachna"

	if(stat || paralysis || stunned || weakened || lying || restrained() || buckled)
		src << "You cannot leap in your current state."
		return

	if(!src.client.CH || src.client.CH.handler_name != "Arachna Jump")
		src.client.CH = PoolOrNew(/datum/click_handler/human/arachna_leap)
		src << "<span class='warning'>You prepare for jump.</span>"
	else
		src.client.CH = null
		src << "<span class='notice'>You unprepare for jump.</span>"
	return

/mob/living/carbon/human/proc/arachna_jump(atom/A)
	if (A == src ||(!ishuman(A) && !isturf(A)))
		A.Click()
		return 0
	if(last_special > world.time)
		src << "You are tired, wait some time."
		return 0
	if(stat || paralysis || stunned || weakened || lying || restrained() || buckled)
		src << "You cannot leap in your current state."
//		src.client.CH = null
		return 0

	if(get_dist(get_turf(A), get_turf(src)) > 4)
		src << "Too Far"
		return 0


/*	var/list/choices = list()
	for(var/mob/living/M in view(6,src))
		if(!istype(M,/mob/living/silicon))
			choices += M
	choices -= src*/

//	var/mob/living/T = input(src,"Who do you wish to leap at?") as null|anything in choices

//	if(!T || !src || src.stat) return/




	last_special = world.time + 75
	status_flags |= LEAPING
//	src.client.CH = null

	src.visible_message("<span class='danger'>\The [src] leaps at [A]!</span>")
	src.throw_at(get_step(get_turf(A),get_turf(src)), 4, 1, src)
//	playsound(src.loc, 'sound/voice/shriek1.ogg', 50, 1)
	if(isturf(A))
		return 1

	var/mob/living/T = A
	sleep(5)

	if(status_flags & LEAPING) status_flags &= ~LEAPING

	if(!src.Adjacent(T))
		src << "<span class='warning'>You miss!</span>"
		return 1

	T.Weaken(3)

	var/use_hand = "left"
	if(l_hand)
		if(r_hand)
			src << "<span class='danger'>You need to have one hand free to grab someone.</span>"
			return 1
		else
			use_hand = "right"

	src.visible_message("<span class='warning'><b>\The [src]</b> seizes [T] aggressively!</span>")

	var/obj/item/weapon/grab/G = new(src,T)
	if(use_hand == "left")
		l_hand = G
	else
		r_hand = G

	G.state = GRAB_PASSIVE
	G.icon_state = "grabbed1"
	G.synch()

	return 1