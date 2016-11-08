#define GAME_STATE_PREGAME		1
#define GAME_STATE_SETTING_UP	2
#define GAME_STATE_PLAYING		3
#define GAME_STATE_FINISHED		4

// Security levels.
#define SEC_LEVEL_GREEN 0
#define SEC_LEVEL_BLUE  1
#define SEC_LEVEL_RED   2
#define SEC_LEVEL_DELTA 3

#define BE_TRAITOR    0x1
#define BE_OPERATIVE  0x2
#define BE_CHANGELING 0x4
#define BE_WIZARD     0x8
#define BE_MALF       0x10
#define BE_REV        0x20
#define BE_ALIEN      0x40
#define BE_AI         0x80
#define BE_CULTIST    0x100
#define BE_MEME       0x200
#define BE_NINJA      0x400
#define BE_RAIDER     0x800
#define BE_PLANT      0x1000
#define BE_LOYALIST   0x2000
#define BE_PAI        0x4000

var/list/be_special_flags = list(
	"Traitor"          = BE_TRAITOR,
	"Operative"        = BE_OPERATIVE,
	"Changeling"       = BE_CHANGELING,
	"Wizard"           = BE_WIZARD,
	"Malf AI"          = BE_MALF,
	"Revolutionary"    = BE_REV,
	"Xenomorph"        = BE_ALIEN,
	"Positronic Brain" = BE_AI,
	"Cultist"          = BE_CULTIST,
	"Ninja"            = BE_NINJA,
	"Raider"           = BE_RAIDER,
	"Diona"            = BE_PLANT,
	"Loyalist"         = BE_LOYALIST,
	"pAI"              = BE_PAI
)

#define IS_MODE_COMPILED(MODE) (ispath(text2path("/datum/game_mode/"+(MODE))))

// Mode/antag template macros.
#define MODE_BORER "borer"
#define MODE_XENOMORPH "xeno"
#define MODE_LOYALIST "loyalist"
#define MODE_MUTINEER "mutineer"
#define MODE_COMMANDO "commando"
#define MODE_DEATHSQUAD "deathsquad"
#define MODE_ERT "ert"
#define MODE_MERCENARY "mercenary"
#define MODE_NINJA "ninja"
#define MODE_RAIDER "raider"
#define MODE_WIZARD "wizard"
#define MODE_CHANGELING "changeling"
#define MODE_CULTIST "cultist"
#define MODE_HIGHLANDER "highlander"
#define MODE_RENEGADE "renegade"
#define MODE_REVOLUTIONARY "revolutionary"
#define MODE_LOYALIST "loyalist"
#define MODE_MALFUNCTION "malf"
#define MODE_TRAITOR "traitor"
#define MODE_MEME "meme"

/////////////////
////WIZARD //////
/////////////////

/*		WIZARD SPELL FLAGS		*/
#define GHOSTCAST		0x1		//can a ghost cast it?
#define NEEDSCLOTHES	0x2		//does it need the wizard garb to cast? Nonwizard spells should not have this
#define NEEDSHUMAN		0x4		//does it require the caster to be human?
#define Z2NOCAST		0x8		//if this is added, the spell can't be cast at centcomm
#define STATALLOWED		0x10	//if set, the user doesn't have to be conscious to cast. Required for ghost spells
#define IGNOREPREV		0x20	//if set, each new target does not overlap with the previous one
//The following flags only affect different types of spell, and therefore overlap
//Targeted spells
#define INCLUDEUSER		0x40	//does the spell include the caster in its target selection?
#define SELECTABLE		0x80	//can you select each target for the spell?
//AOE spells
#define IGNOREDENSE		0x40	//are dense turfs ignored in selection?
#define IGNORESPACE		0x80	//are space turfs ignored in selection?
//End split flags
#define CONSTRUCT_CHECK	0x100	//used by construct spells - checks for nullrods
#define NO_BUTTON		0x200	//spell won't show up in the HUD with this

//invocation
#define SpI_SHOUT	"shout"
#define SpI_WHISPER	"whisper"
#define SpI_EMOTE	"emote"
#define SpI_NONE	"none"

//upgrading
#define Sp_SPEED	"speed"
#define Sp_POWER	"power"
#define Sp_TOTAL	"total"

//casting costs
#define Sp_RECHARGE	"recharge"
#define Sp_CHARGES	"charges"
#define Sp_HOLDVAR	"holdervar"
