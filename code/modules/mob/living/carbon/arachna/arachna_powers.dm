/datum/species_abilities/arachna
	var/purchased_powers = list()
	var/EvolvPoint = 10

/datum/species_abilities/arachna/New(var/gender=FEMALE)
	..()
	usr.verbs += /datum/species_abilities/arachna/proc/EvolutionMenu

/datum/species_abilities/arachna/proc/EvolutionMenu()//The new one
	set name = "-Evolution Menu-"
	set category = "Arachna"
	set desc = "Adapt yourself carefully."

	if(!usr || !usr.mind)	return
	var/mob/living/carbon/human/H = usr
	src = H.species_abilities

	if(!arachna_powerinstances.len)
		for(var/P in arachna_powers)
			world << P
			arachna_powerinstances += new P()

	var/dat = "<html><head><title>Arachna Evolution Menu</title></head>"

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

				function expand(id,name,desc,helptext,enhancedtext,power,ownsthis){

					clearAll();

					var span = document.getElementById(id);

					body = "<table><tr><td>";

					body += "</td><td align='center'>";

					body += "<font size='2'><b>"+desc+"</b></font> <BR>"

					body += "<font size='2' color = 'red'><b>"+helptext+"</b></font><BR>"

					if(enhancedtext)
						body += "<font size='2' color = 'blue'>Recursive Enhancement Effect: <b>"+enhancedtext+"</b></font><BR>"

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
					Absorb other changelings to acquire more evolution points
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
					<span id='search[i]'><b>Evolve [P] - Cost: [ownsthis ? "Purchased" : P.cost]</b></span>
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
		call(M, Thepower.verbpath)()
//	else if(remake_verbs)
//		M.current.make_changeling()




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
	set category = "Abilities"
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

/mob/proc/jump()
	src << "Not work right now!"
	return 0