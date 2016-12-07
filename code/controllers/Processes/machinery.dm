/var/global/machinery_sort_required = 0

/datum/controller/process/machinery/setup()
	name = "machinery"
	schedule_interval = 20 // every 2 seconds

/datum/controller/process/machinery/doWork()
	internal_sort()
	internal_process_pipenets()
	internal_process_machinery()
	internal_process_power()
	internal_process_power_drain()

/datum/controller/process/machinery/proc/internal_sort()
	if(machinery_sort_required)
		machinery_sort_required = 0
		machines = dd_sortedObjectList(machines)

/datum/controller/process/machinery/proc/internal_process_machinery()
	for(last_object in machines)
		var/obj/machinery/M = last_object
		if(M && !M.gcDestroyed)
			if(M.process() == PROCESS_KILL)
				//M.inMachineList = 0 We don't use this debugging function
				machines.Remove(M)
				continue

			if(M && M.use_power)
				M.auto_use_power()

		SCHECK

/datum/controller/process/machinery/proc/internal_process_power()
	for(last_object in powernets)
		var/datum/powernet/powerNetwork = last_object
		if(istype(powerNetwork) && isnull(powerNetwork.gcDestroyed))
			powerNetwork.reset()
			SCHECK
			continue

		powernets.Remove(powerNetwork)

/datum/controller/process/machinery/proc/internal_process_power_drain()
	// Currently only used by powersinks. These items get priority processed before machinery
	for(var/obj/item/I in processing_power_items)
		if(!I.pwr_drain()) // 0 = Process Kill, remove from processing list.
			processing_power_items.Remove(I)
		SCHECK

/datum/controller/process/machinery/proc/internal_process_pipenets()
	for(var/datum/pipe_network/pipeNetwork in pipe_networks)
		if(istype(pipeNetwork) && isnull(pipeNetwork.gcDestroyed))
			pipeNetwork.process()
			SCHECK
			continue

		pipe_networks.Remove(pipeNetwork)

/datum/controller/process/machinery/getStatName()
	return ..()+"(MCH:[machines.len] PWR:[powernets.len] PIP:[pipe_networks.len])"
