#define MOD_STD "Standard"
#define MOD_SEC "Security"
#define MOD_SRV "Service"
#define MOD_CLR "Clerical"
#define MOD_MIN "Miner"
#define MOD_MED "Medical"
#define MOD_SRG "Surgeon"
#define MOD_CMB "Combat"
#define MOD_ENG "Engineering"
#define MOD_JAN "Janitor"
#define MOD_SCI "Research"
#define MOD_SYN "Synicate"

var/global/list/borg_sprites = list(
	MOD_STD = list(), MOD_SEC = list(), MOD_SRV = list(), MOD_CLR = list(),
	MOD_MIN = list(), MOD_MED = list(), MOD_SRG = list(), MOD_CMB = list(),
	MOD_ENG = list(), MOD_JAN = list(), MOD_SCI = list(), MOD_SYN = list()
)

/hook/startup/proc/populate_cyborg_sprites()
	for(var/sprite_type in typesof(/datum/borg_sprite))
		var/datum/borg_sprite/BS = new sprite_type
		borg_sprites[BS.module][BS.name] = BS
	return 1

/datum/borg_sprite
	var/name = "Humanoid"
	var/icon_state = "human"
	var/eyes = ""
	var/eyes_color = "#ffffff"
	var/panel = "human"
	var/module = MOD_STD

/datum/borg_sprite/New()
	if(!eyes) eyes = icon_state + "-eyes"

////XENO////
/datum/borg_sprite/xeno
	name = "Xeno"
	icon_state = "xeno-research"
	panel = "xeno"
	module = MOD_SCI

////DAWG////
/datum/borg_sprite/dawg
	name = "Dog" //Have no fancy at all, yeah?
	icon_state = "dawg-security"
	panel = "dawg"
	module = MOD_SEC

/datum/borg_sprite/dawg/rhino
	name = "Rhino"
	icon_state = "rhino"
	module = MOD_SYN

////DALEK////
/datum/borg_sprite/dalek
	name = "Dalek"
	icon_state = "dalek-standard"
	panel = "dalek"

/datum/borg_sprite/dalek/security
	icon_state = "dalek-security"
	module = MOD_SEC

/datum/borg_sprite/dalek/miner
	icon_state = "dalek-miner"
	module = MOD_MIN

/datum/borg_sprite/dalek/combat
	icon_state = "dalek-combat"
	module = MOD_CMB

////HUMANOID////
/datum/borg_sprite/human
	eyes = "human-eyes"

/datum/borg_sprite/human/security
	icon_state = "human-security"
	module = MOD_SEC

/datum/borg_sprite/human/security/red
	name = "Red Knight"
	icon_state = "human-security2"

/datum/borg_sprite/human/security/black
	name = "Black Knight"
	icon_state = "human-security3"

/datum/borg_sprite/human/service
	icon_state = "human-service"
	module = MOD_SRV

/datum/borg_sprite/human/service/rich
	name = "Rich man"
	icon_state = "human-service2"

/datum/borg_sprite/human/service/proto
	name = "Proto"
	icon_state = "human-service3"

/datum/borg_sprite/human/service/bartender
	name = "Botanist"
	icon_state = "human-service4"

/datum/borg_sprite/human/clerical
	icon_state = "human-clerical"
	module = MOD_CLR

/datum/borg_sprite/human/clerical/fem
	name = "Humanoid (female)"
	icon_state = "human-clerical2"

/datum/borg_sprite/human/miner
	icon_state = "human-miner"
	module = MOD_MIN

/datum/borg_sprite/human/crisis
	icon_state = "human-crisis"
	module = MOD_MED

/datum/borg_sprite/human/crisis/adv
	name = "Humanoid (adv)"
	icon_state = "human-crisis2"

/datum/borg_sprite/human/engineering
	icon_state = "human-engineering"
	module = MOD_ENG

/datum/borg_sprite/human/engineering/adv
	name = "Humanoid (adv)"
	icon_state = "human-engineering2"

/datum/borg_sprite/human/janitor
	icon_state = "human-janitor"
	module = MOD_JAN

/datum/borg_sprite/human/janitor/adv
	name = "Humanoid (adv)"
	icon_state = "human-janitor2"

////ROBOCOP////
/datum/borg_sprite/robocop
	name = "Robocop"
	icon_state = "robocop"
	module = MOD_SEC

/datum/borg_sprite/robocop/red
	name = "Robocop (red)"
	icon_state = "robocop_red"

////LITTLE_DROID////
/datum/borg_sprite/littledroid
	name = "Little droid"
	icon_state = "droid"

////CONSTRUCTOR////
/datum/borg_sprite/constructor
	name = "Constructor"
	icon_state = "constructiondrone"
	module = MOD_ENG

////ENGINEER////
/datum/borg_sprite/engineer
	name = "Engineer"
	icon_state = "engineer"
	module = MOD_ENG

////ARTIFICER////
/datum/borg_sprite/artificer
	name = "Artificer"
	icon_state = "artificer"
	module = MOD_ENG

////SLEEK////
/datum/borg_sprite/sleek
	name = "Sleek"
	icon_state = "sleek"

////SQUATS////
/datum/borg_sprite/squats
	name = "Squats"
	icon_state = "squats"
	module = MOD_CMB

////KODIAK////
/datum/borg_sprite/kodiak
	name = "Kodiak"
	icon_state = "kodiak-standard"

/datum/borg_sprite/kodiak/security
	icon_state = "kodiak-security"
	module = MOD_SEC

/datum/borg_sprite/kodiak/service
	icon_state = "kodiak-service"
	module = MOD_SRV

////DROID////
/datum/borg_sprite/droid
	name = "Droid"
	icon_state = "droid-standard"

/datum/borg_sprite/droid/security
	icon_state = "droid-security"
	module = MOD_SEC

/datum/borg_sprite/droid/security/tread
	name = "Droid tread"
	icon_state = "droid-security-tread"

/datum/borg_sprite/droid/service
	icon_state = "droid-service"
	module = MOD_SRV

/datum/borg_sprite/droid/miner
	icon_state = "droid-miner"
	module = MOD_MIN

/datum/borg_sprite/droid/miner/tread
	name = "Droid tread"
	icon_state = "droid-miner-tread"

/datum/borg_sprite/droid/crisis
	icon_state = "droid-crisis"
	eyes = "droid-service-eyes"
	module = MOD_MED

/datum/borg_sprite/droid/surgeon
	icon_state = "droid-surgeon"
	eyes_color = "#02DAD8"
	module = MOD_SRG

/datum/borg_sprite/droid/combat
	icon_state = "droid-combat"
	module = MOD_CMB

/datum/borg_sprite/droid/engineering
	icon_state = "droid-engineering"
	module = MOD_ENG

/datum/borg_sprite/droid/engineering/tread
	name = "Droid tread"
	icon_state = "droid-engineering-tread"

/datum/borg_sprite/droid/janitor
	icon_state = "droid-janitor"
	module = MOD_JAN

/datum/borg_sprite/droid/research
	icon_state = "droid-research"
	eyes = "droid-surgeon-eyes"
	eyes_color = "#cc33cc"
	module = MOD_SCI

/datum/borg_sprite/droid/syndie
	icon_state = "droid-syndie"
	module = MOD_SYN

/datum/borg_sprite/droid/syndie/tread
	name = "Droid tread"
	icon_state = "droid-syndie-tread"

/datum/borg_sprite/droid/syndie/med
	icon_state = "droid-syndi-medi"
	name = "Droid alt"

////MARINA////
/datum/borg_sprite/marina
	name = "Marina"
	icon_state = "marina-standard"
	panel = "marina"

/datum/borg_sprite/marina/security
	icon_state = "marina-security"
	module = MOD_SEC

/datum/borg_sprite/marina/service
	icon_state = "marina-service"
	module = MOD_SRV

/datum/borg_sprite/marina/miner
	icon_state = "marina-miner"
	module = MOD_MIN

/datum/borg_sprite/marina/combat
	icon_state = "marina-combat"
	module = MOD_CMB

/datum/borg_sprite/marina/engineering
	icon_state = "marina-engineering"
	module = MOD_ENG

/datum/borg_sprite/marina/janitor
	icon_state = "marina-janitor"
	module = MOD_JAN

////BIG-BRO////
/datum/borg_sprite/bigbro
	name = "BigBro"
	icon_state = "bigbro-standard"
	eyes = "bigbro-eyes"
	panel = "bigbro"

/datum/borg_sprite/bigbro/security
	icon_state = "bigbro-security"
	eyes = ""
	module = MOD_SEC

/datum/borg_sprite/bigbro/service
	icon_state = "bigbro-service"
	module = MOD_SRV

/datum/borg_sprite/bigbro/miner
	icon_state = "bigbro-miner"
	eyes = ""
	module = MOD_MIN

/datum/borg_sprite/bigbro/crisis
	icon_state = "bigbro-crisis"
	eyes = ""
	module = MOD_MED

/datum/borg_sprite/bigbro/engineering
	icon_state = "bigbro-engineering"
	eyes = ""
	module = MOD_ENG

/datum/borg_sprite/bigbro/janitor
	icon_state = "bigbro-janitor"
	eyes = ""
	module = MOD_JAN

////DRONES////
/datum/borg_sprite/drone
	name = "Drone"
	icon_state = "drone-standard"
	eyes = "drone-eyes"
	eyes_color = "#00a7b9"
	panel = "drone"

/datum/borg_sprite/drone/security
	icon_state = "drone-security"
	eyes_color = "#ff0000"
	module = MOD_SEC

/datum/borg_sprite/drone/service
	icon_state = "drone-service"
	eyes_color = "#00ffff"
	module = MOD_SRV

/datum/borg_sprite/drone/clerical
	icon_state = "drone-clerical"
	eyes_color = "#ffff00"
	module = MOD_CLR

/datum/borg_sprite/drone/miner
	icon_state = "drone-miner"
	eyes_color = "#cc33cc"
	module = MOD_MIN

/datum/borg_sprite/drone/crisis
	icon_state = "drone-crisis"
	eyes_color = "#00ff00"
	module = MOD_MED

/datum/borg_sprite/drone/surgery
	icon_state = "drone-surgery"
	eyes_color = "#ff0000"
	module = MOD_SRG

/datum/borg_sprite/drone/combat
	icon_state = "drone-combat"
	eyes_color = "#ff0000"
	module = MOD_CMB

/datum/borg_sprite/drone/engineering
	icon_state = "drone-engineering"
	eyes_color = "#ffff00"
	module = MOD_ENG

/datum/borg_sprite/drone/janitor
	icon_state = "drone-janitor"
	eyes_color = "#00ffff"
	module = MOD_JAN

/datum/borg_sprite/drone/research
	icon_state = "drone-research"
	eyes_color = "#cc33cc"
	module = MOD_SCI

////SPIDERS////
/datum/borg_sprite/spider
	name = "Spider"
	icon_state = "spider-standard"
	panel = "spider"

/datum/borg_sprite/spider/security
	icon_state = "spider-security"
	module = MOD_SEC

/datum/borg_sprite/spider/service
	icon_state = "spider-service"
	panel = "spider2"
	module = MOD_SRV

/datum/borg_sprite/spider/miner
	icon_state = "spider-miner"
	module = MOD_MIN

/datum/borg_sprite/spider/crisis
	icon_state = "spider-crisis"
	panel = "spider2"
	module = MOD_MED

/datum/borg_sprite/spider/surgeon
	icon_state = "spider-surgeon"
	panel = "spider2"
	module = MOD_SRG

/datum/borg_sprite/spider/combat
	icon_state = "spider-combat"
	module = MOD_CMB

/datum/borg_sprite/spider/engineering
	icon_state = "spider-engineering"
	module = MOD_ENG

/datum/borg_sprite/spider/janitor
	icon_state = "spider-janitor"
	panel = "spider2"
	module = MOD_JAN

/datum/borg_sprite/spider/research
	icon_state = "spider-research"
	module = MOD_SCI

////FEM-BOT////
/datum/borg_sprite/fembot
	name = "Fembot"
	icon_state = "fembot-security"
	eyes = "fembot-eyes"
	eyes_color = "#ff0000"
	panel = "fembot"
	module = MOD_SEC

/datum/borg_sprite/fembot/service
	icon_state = "fembot-service"
	module = MOD_SRV

/datum/borg_sprite/fembot/clerical
	icon_state = "fembot-clerical"
	module = MOD_CLR

/datum/borg_sprite/fembot/miner
	icon_state = "fembot-miner"
	eyes_color = "#ef7ade"
	module = MOD_MIN

/datum/borg_sprite/fembot/crisis
	icon_state = "fembot-crisis"
	eyes_color = "#0099cc"
	module = MOD_MED

/datum/borg_sprite/fembot/engineering
	icon_state = "fembot-engineering"
	eyes_color = "#ffee00"
	module = MOD_ENG

/datum/borg_sprite/fembot/janitor
	icon_state = "fembot-janitor"
	eyes_color = "#a747c0"
	module = MOD_JAN

/datum/borg_sprite/fembot/research
	icon_state = "fembot-research"
	eyes_color = "#a747c0"
	module = MOD_SCI

////ED////
/datum/borg_sprite/ed
	name = "ED"
	icon_state = "ed-standard"
	eyes = "ed-eyes"
	eyes_color = "#00e51a"
	panel = "ed"

/datum/borg_sprite/ed/security
	icon_state = "ed-security"
	eyes_color = "#ff0000"
	module = MOD_SEC

/datum/borg_sprite/ed/service
	icon_state = "ed-service"
	module = MOD_SRV

/datum/borg_sprite/ed/miner
	icon_state = "ed-miner"
	module = MOD_MIN

/datum/borg_sprite/ed/crisis
	icon_state = "ed-miner"
	eyes_color = "#0094e1"
	module = MOD_MED

/datum/borg_sprite/ed/surgeon
	icon_state = "ed-surgeon"
	eyes_color = "#0094ff"
	module = MOD_SRG

/datum/borg_sprite/ed/engineering
	icon_state = "ed-engineering"
	eyes_color = "#ffd800"
	module = MOD_ENG

/datum/borg_sprite/ed/janitor
	icon_state = "ed-janitor"
	eyes_color = "#d160ff"
	module = MOD_JAN

/datum/borg_sprite/ed/research
	icon_state = "ed-research"
	eyes_color = "#cc60ff"
	module = MOD_SCI

////CYBER-FLOWER////
/datum/borg_sprite/cyberflower
	name = "CyberFlower"
	icon_state = "cyberflower-standard"
	panel = "cyberflower"

/datum/borg_sprite/cyberflower/security
	icon_state = "cyberflower-security"
	module = MOD_SEC

/datum/borg_sprite/cyberflower/service
	icon_state = "cyberflower-service"
	module = MOD_SRV

/datum/borg_sprite/cyberflower/clerical
	icon_state = "cyberflower-clerical"
	module = MOD_CLR

/datum/borg_sprite/cyberflower/miner
	icon_state = "cyberflower-miner"
	module = MOD_MIN

/datum/borg_sprite/cyberflower/crisis
	icon_state = "cyberflower-crisis"
	module = MOD_MED

/datum/borg_sprite/cyberflower/surgeon
	icon_state = "cyberflower-surgeon"
	module = MOD_SRG

/datum/borg_sprite/cyberflower/engineering
	icon_state = "cyberflower-engineering"
	module = MOD_ENG

/datum/borg_sprite/cyberflower/janitor
	icon_state = "cyberflower-janitor"
	module = MOD_JAN

////MOTILE////
/datum/borg_sprite/motile
	name = "Motile"
	icon_state = "motile"

/datum/borg_sprite/motile/security
	icon_state = "motile-security"
	module = MOD_SEC

/datum/borg_sprite/motile/combat
	icon_state = "motile-combat"
	module = MOD_CMB

#undef MOD_STD
#undef MOD_SEC
#undef MOD_SRV
#undef MOD_CLR
#undef MOD_MIN
#undef MOD_MED
#undef MOD_SRG
#undef MOD_CMB
#undef MOD_ENG
#undef MOD_JAN
#undef MOD_SCI