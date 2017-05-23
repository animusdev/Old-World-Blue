#define GAME_STATE_PREGAME		1
#define GAME_STATE_SETTING_UP	2
#define GAME_STATE_PLAYING		3
#define GAME_STATE_FINISHED		4

// Security levels.
#define SEC_LEVEL_GREEN 0
#define SEC_LEVEL_BLUE  1
#define SEC_LEVEL_RED   2
#define SEC_LEVEL_DELTA 3

// Mode/antag template macros.
#define ROLE_BORER "borer"
#define ROLE_ALIEN "xenomorph"
#define ROLE_MUTINEER "mutineer"
#define ROLE_COMMANDO "commando"
#define ROLE_DEATHSQUAD "deathsquad"
#define ROLE_ERT "ert"
#define ROLE_MERCENARY "mercenary"
#define ROLE_NINJA "ninja"
#define ROLE_RAIDER "raider"
#define ROLE_WIZARD "wizard"
#define ROLE_CHANGELING "changeling"
#define ROLE_CULTIST "cultist"
#define ROLE_HIGHLANDER "highlander"
#define ROLE_RENEGADE "renegade"
#define ROLE_REVOLUTIONARY "revolutionary"
#define ROLE_LOYALIST "loyalist"
#define ROLE_MALFUNCTION "malf"
#define ROLE_TRAITOR "traitor"
#define ROLE_MEME "meme"
#define ROLE_DIONA "diona"
#define ROLE_PAI "pAI"
#define ROLE_POSIBRAIN "positronic"

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
