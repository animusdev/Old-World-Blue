// GENERIC MINING AREAS

/area/mine
	icon_state = "mining"
	music = 'sound/ambience/song_game.ogg'
	sound_env = 5 //stoneroom

/area/mine/explored
	name = "Mine"
	icon_state = "explored"
	ambience = list('sound/ambience/ambimine.ogg', 'sound/ambience/song_game.ogg')

/area/mine/unexplored
	name = "Mine"
	icon_state = "unexplored"
	ambience = list('sound/ambience/ambimine.ogg', 'sound/ambience/song_game.ogg')


// OUTPOSTS

// Small outposts
/area/outpost/mining_north
	name = "North Mining Outpost"
	icon_state = "outpost_mine_north"

/area/outpost/mining_west
	name = "West Mining Outpost"
	icon_state = "outpost_mine_west"

/area/outpost/abandoned
	name = "Abandoned Outpost"
	icon_state = "dark"

// Main mining outpost
/area/outpost/mining_main
	icon_state = "outpost_mine_main"

/area/outpost/mining_main/dorms
	name = "Mining Outpost Dormitory"

/area/outpost/mining_main/medbay
	name = "Mining Outpost Medical"

/area/outpost/mining_main/maintenance
	name = "Mining Outpost Maintenance"

/area/outpost/mining_main/west_hall
	name = "Mining Outpost West Hallway"

/area/outpost/mining_main/east_hall
	name = "Mining Outpost East Hallway"

/area/outpost/mining_main/eva
	name = "Mining Outpost EVA storage"

/area/outpost/mining_main/refinery
	name = "Mining Outpost Refinery"



// Engineering Outpost
/area/outpost/engineering
	icon_state = "outpost_engine"

/area/outpost/engineering/hallway
	name = "Engineering Outpost Hallway"

/area/outpost/engineering/atmospherics
	name = "Engineering Outpost Atmospherics"

/area/outpost/engineering/power
	name = "Engineering Outpost Power Distribution"

/area/outpost/engineering/telecomms
	name = "Engineering Outpost Telecommunications"

/area/outpost/engineering/storage
	name = "Engineering Outpost Storage"

/area/outpost/engineering/meeting
	name = "Engineering Outpost Meeting Room"



// Research Outpost
/area/outpost/research
	icon_state = "outpost_research"

/area/outpost/research/hallway
	name = "Research Outpost Hallway"
	icon_state = "OR_hallway"

/area/outpost/research/dock
	name = "Research Outpost Shuttle Dock"
	icon_state = "OR_dock"

/area/outpost/research/eva
	name = "Research Outpost EVA"
	icon_state = "OR_EVA"

/area/outpost/research/analysis
	name = "Research Outpost Sample Analysis"
	icon_state = "anosample"

/area/outpost/research/chemistry
	name = "Research Outpost Chemistry"
	icon_state = "OR_chem"

/area/outpost/research/medical
	name = "Research Outpost Medical"
	icon_state = "medbay"

/area/outpost/research/power
	name = "Research Outpost Maintenance"
	icon_state = "OR_power"

/area/outpost/research/isolation_a
	name = "Research Outpost Isolation A"
	icon_state = "iso1"

/area/outpost/research/isolation_b
	name = "Research Outpost Isolation B"
	icon_state = "iso2"

/area/outpost/research/isolation_c
	name = "Research Outpost Isolation C"
	icon_state = "iso3"

/area/outpost/research/isolation_monitoring
	name = "Research Outpost Isolation Monitoring"
	icon_state = "OR_monitor"

/area/outpost/research/lab
	name = "Research Outpost Laboratory"
	icon_state = "anolab"

/area/outpost/research/emergency_storage
	name = "Research Outpost Emergency Storage"
	icon_state = "emergencystorage"

/area/outpost/research/anomaly_storage
	name = "Research Outpost Anomalous Storage"

/area/outpost/research/anomaly_analysis
	name = "Research Outpost Anomaly Analysis"
	icon_state = "anomaly"

/area/outpost/research/kitchen
	name = "Research Outpost Kitchen"
	icon_state = "cafeteria"

/area/outpost/research/disposal
	name = "Research Outpost Waste Disposal"
	icon_state = "disposal"
