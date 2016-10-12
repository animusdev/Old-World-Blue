#define DEBUG

#define GAME_STATE_PREGAME		1
#define GAME_STATE_SETTING_UP	2
#define GAME_STATE_PLAYING		3
#define GAME_STATE_FINISHED		4

#define PRESSURE_DAMAGE_COEFFICIENT 4 // The amount of pressure damage someone takes is equal to (pressure / HAZARD_HIGH_PRESSURE)*PRESSURE_DAMAGE_COEFFICIENT, with the maximum of MAX_PRESSURE_DAMAGE.
#define    MAX_HIGH_PRESSURE_DAMAGE 7 // This used to be 20... I got this much random rage for some retarded decision by polymorph?! Polymorph now lies in a pool of blood with a katana jammed in his spleen. ~Errorage --PS: The katana did less than 20 damage to him :(
#define         LOW_PRESSURE_DAMAGE 5 // The amount of damage someone takes when in a low pressure area. (The pressure threshold is so low that it doesn't make sense to do any calculations, so it just applies this flat value).

// Doors!
#define DOOR_CRUSH_DAMAGE 10

#define HUNGER_FACTOR              0.05 // Factor of how fast mob nutrition decreases
#define REM 0.2 // Means 'Reagent Effect Multiplier'. This is how many units of reagent are consumed per tick
#define CHEM_TOUCH 1
#define CHEM_INGEST 2
#define CHEM_BLOOD 3
#define MINIMUM_CHEMICAL_VOLUME 0.01
#define SOLID 1
#define LIQUID 2
#define GAS 3
#define REAGENTS_OVERDOSE 30

#define ALIEN_SELECT_AFK_BUFFER  1    // How many minutes that a person can be AFK before not being allowed to be an alien.
#define NORMPIPERATE             30   // Pipe-insulation rate divisor.
#define HEATPIPERATE             8    // Heat-exchange pipe insulation.
#define FLOWFRAC                 0.99 // Fraction of gas transfered per process.

// Flags bitmasks.
#define STOPPRESSUREDAMAGE 1 // This flag is used on the flags variable for SUIT and HEAD items which stop pressure damage. Note that the flag 1 was previous used as ONBACK, so it is possible for some code to use (flags & 1) when checking if something can be put on your back. Replace this code with (inv_flags & SLOT_BACK) if you see it anywhere
                             // To successfully stop you taking all pressure damage you must have both a suit and head item with this flag.
#define NOBLUDGEON         2    // When an item has this it produces no "X has been hit by Y with Z" message with the default handler.
#define AIRTIGHT           4    // Functions with internals.
#define USEDELAY           8    // 1 second extra delay on use. (Can be used once every 2s)
#define NOSHIELD           16   // Weapon not affected by shield.
#define CONDUCT            32   // Conducts electricity. (metal etc.)
#define ON_BORDER          64   // Item has priority to check when entering or leaving.
#define NOBLOODY           512  // Used for items if they don't want to get a blood overlay.
#define NODELAY            8192 // 1 second attack-by delay skipped (Can be used once every 0.2s). Most objects have a 1s attack-by delay, which doesn't require a flag.

//Use these flags to indicate if an item obscures the specified slots from view, whereas body_parts_covered seems to be used to indicate what body parts the item protects.
#define GLASSESCOVERSEYES 256
#define    MASKCOVERSEYES 256 // Get rid of some of the other retardation in these flags.
#define    HEADCOVERSEYES 256 // Feel free to reallocate these numbers for other purposes.
#define   MASKCOVERSMOUTH 512 // On other items, these are just for mask/head.
#define   HEADCOVERSMOUTH 512

#define THICKMATERIAL          256  // From /tg/station: prevents syringes, parapens and hyposprays if the external suit or helmet (if targeting head) has this flag. Example: space suits, biosuit, bombsuits, thick suits that cover your body. (NOTE: flag shared with NOSLIP for shoes)
#define NOSLIP                 256  // Prevents from slipping on wet floors, in space, etc.
#define OPENCONTAINER          1024 // Is an open container for chemistry purposes.
#define BLOCK_GAS_SMOKE_EFFECT 2048 // Blocks the effect that chemical clouds would have on a mob -- glasses, mask and helmets ONLY! (NOTE: flag shared with ONESIZEFITSALL)
#define ONESIZEFITSALL         2048
#define PHORONGUARD            4096 // Does not get contaminated by phoron.
#define	NOREACT                4096 // Reagents don't react inside this container.
#define BLOCKHEADHAIR          4    // Temporarily removes the user's hair overlay. Leaves facial hair.
#define BLOCKHAIR              8192 // Temporarily removes the user's hair, facial and otherwise.

// Turf-only flags.
#define NOJAUNT 1 // This is used in literally one place, turf.dm, to block ethereal jaunt.


// Bitflags for mutations.
#define STRUCDNASIZE 27
#define   UNIDNASIZE 13

// Generic mutations:
#define TK              1
#define COLD_RESISTANCE 2
#define XRAY            3
#define HULK            4
#define CLUMSY          5
#define FAT             6
#define HUSK            7
#define NOCLONE         8
#define LASER           9  // Harm intent - click anywhere to shoot lasers from eyes.
#define HEAL            10 // Healing people with hands.

#define SKELETON      29
#define PLANT         30

// Other Mutations:
#define mNobreath      100 // No need to breathe.
#define mRemote        101 // Remote viewing.
#define mRegen         102 // Health regeneration.
#define mRun           103 // No slowdown.
#define mRemotetalk    104 // Remote talking.
#define mMorph         105 // Hanging appearance.
#define mBlend         106 // Nothing. (seriously nothing)
#define mHallucination 107 // Hallucinations.
#define mFingerprints  108 // No fingerprints.
#define mShock         109 // Insulated hands.
#define mSmallsize     110 // Table climbing.

// disabilities
#define NEARSIGHTED 1
#define EPILEPSY    2
#define COUGHING    4
#define TOURETTES   8
#define NERVOUS     16
#define PARAPLEGIA  32

// sdisabilities
#define BLIND 1
#define MUTE  2
#define DEAF  4

// /mob/var/stat things.
#define CONSCIOUS   0
#define UNCONSCIOUS 1
#define DEAD        2

// Channel numbers for power.
#define EQUIP   1
#define LIGHT   2
#define ENVIRON 3
#define TOTAL   4 // For total power used only.

// Bitflags for machine stat variable.
#define BROKEN   1
#define NOPOWER  2
#define POWEROFF 4  // TBD.
#define MAINT    8  // Under maintenance.
#define EMPED    16 // Temporary broken by EMP pulse.

// Bitmasks for door switches.
#define OPEN   1
#define IDSCAN 2
#define BOLTS  4
#define SHOCK  8
#define SAFE   16

// Metal sheets, glass sheets, and rod stacks.
#define MAX_STACK_AMOUNT_METAL 50
#define MAX_STACK_AMOUNT_GLASS 50
#define MAX_STACK_AMOUNT_RODS  60

#define GAS_O2  (1 << 0)
#define GAS_N2  (1 << 1)
#define GAS_PL  (1 << 2)
#define GAS_CO2 (1 << 3)
#define GAS_N2O (1 << 4)

#define IS_MODE_COMPILED(MODE) (ispath(text2path("/datum/game_mode/"+(MODE))))

// Damage things. TODO: Merge these down to reduce on defines.
// Way to waste perfectly good damage-type names (BRUTE) on this... If you were really worried about case sensitivity, you could have just used lowertext(damagetype) in the proc.
#define BRUTE     "brute"
#define BURN      "fire"
#define TOX       "tox"
#define OXY       "oxy"
#define CLONE     "clone"
#define HALLOSS   "halloss"

#define CUT       "cut"
#define BRUISE    "bruise"
#define PIERCE    "pierce"

#define STUN      "stun"
#define WEAKEN    "weaken"
#define PARALYZE  "paralize"
#define IRRADIATE "irradiate"
#define AGONY     "agony"     // Added in PAIN!
#define SLUR      "slur"
#define STUTTER   "stutter"
#define EYE_BLUR  "eye_blur"
#define DROWSY    "drowsy"

// I hate adding defines like this but I'd much rather deal with bitflags than lists and string searches.
#define BRUTELOSS 1
#define FIRELOSS  2
#define TOXLOSS   4
#define OXYLOSS   8

// Bitflags defining which status effects could be or are inflicted on a mob.
#define CANSTUN     1
#define CANWEAKEN   2
#define CANPARALYSE 4
#define CANPUSH     8
#define LEAPING     16
#define PASSEMOTES  32    // Mob has a cortical borer or holders inside of it that need to see emotes.
#define GODMODE     4096
#define FAKEDEATH   8192  // Replaces stuff like changeling.changeling_fakedeath.
#define DISFIGURED  16384 // I'll probably move this elsewhere if I ever get wround to writing a bitflag mob-damage system.
#define XENO_HOST   32768 // Tracks whether we're gonna be a baby alien's mummy.

// Grab levels.
#define GRAB_PASSIVE    1
#define GRAB_AGGRESSIVE 2
#define GRAB_NECK       3
#define GRAB_UPGRADING  4
#define GRAB_KILL       5

// Security levels.
#define SEC_LEVEL_GREEN 0
#define SEC_LEVEL_BLUE  1
#define SEC_LEVEL_RED   2
#define SEC_LEVEL_DELTA 3

#define TRANSITIONEDGE 7 // Distance from edge to move to another z-level.

// Number of identical messages required to get the spam-prevention auto-mute thing to trigger warnings and automutes.
#define SPAM_TRIGGER_WARNING  5
#define SPAM_TRIGGER_AUTOMUTE 10

// Invisibility constants.
#define INVISIBILITY_LIGHTING             20
#define INVISIBILITY_LEVEL_ONE            35
#define INVISIBILITY_LEVEL_TWO            45
#define INVISIBILITY_OBSERVER             60
#define INVISIBILITY_EYE		          61

#define SEE_INVISIBLE_LIVING              25
#define SEE_INVISIBLE_OBSERVER_NOLIGHTING 15
#define SEE_INVISIBLE_LEVEL_ONE           35
#define SEE_INVISIBLE_LEVEL_TWO           45
#define SEE_INVISIBLE_CULT		          60
#define SEE_INVISIBLE_OBSERVER            61

#define SEE_INVISIBLE_MINIMUM 5
#define INVISIBILITY_MAXIMUM 100

//Some mob defines below
#define AI_CAMERA_LUMINOSITY 6

#define BORGMESON 1
#define BORGTHERM 2
#define BORGXRAY  4

// Some arbitrary defines to be used by self-pruning global lists. (see master_controller)
#define PROCESS_KILL 26 // Used to trigger removal from a processing list.

#define HOSTILE_STANCE_IDLE      1
#define HOSTILE_STANCE_ALERT     2
#define HOSTILE_STANCE_ATTACK    3
#define HOSTILE_STANCE_ATTACKING 4
#define HOSTILE_STANCE_TIRED     5

#define ROUNDSTART_LOGOUT_REPORT_TIME 6000 // Amount of time (in deciseconds) after the rounds starts, that the player disconnect report is issued.

// Organ defines.
#define ORGAN_CUT_AWAY   1
#define ORGAN_GAUZED     2
#define ORGAN_ATTACHABLE 4
#define ORGAN_BLEEDING   8
#define ORGAN_BROKEN     32
#define ORGAN_DESTROYED  64
#define ORGAN_ROBOT      128
#define ORGAN_SPLINTED   256
#define SALVED           512
#define ORGAN_DEAD       1024
#define ORGAN_MUTATED    2048
#define ORGAN_ASSISTED   4096

// Preference toggles.
#define SOUND_ADMINHELP 1
#define SOUND_MIDI      2
#define SOUND_AMBIENCE  4
#define SOUND_LOBBY     8
#define SHOW_TYPING     16
#define CHAT_NOICONS    32
#define RUS_AUTOEMOTES  64
#define HIDE_MOTD       128
#define PREFER_NEWSETUP 256

// Preference chat.
#define CHAT_OOC          1
#define CHAT_DEAD         2
#define CHAT_GHOSTEARS    4
#define CHAT_GHOSTSIGHT   8
#define CHAT_PRAYER       16
#define CHAT_RADIO        32
#define CHAT_ATTACKLOGS   64
#define CHAT_DEBUGLOGS    128
#define CHAT_ADMINLOGS    256
#define CHAT_GAMEMODELOGS 512
#define CHAT_LOOC         1024
#define CHAT_GHOSTRADIO   2048
#define CHAT_GHOSTANONIM  4096

#define TOGGLES_DEFAULT (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY)
#define CHAT_TOGGLES_DEFAULT (CHAT_OOC|CHAT_DEAD|CHAT_GHOSTEARS|CHAT_GHOSTSIGHT|CHAT_PRAYER|CHAT_RADIO|CHAT_ATTACKLOGS|CHAT_ADMINLOGS|CHAT_LOOC)

#define BE_TRAITOR    1
#define BE_OPERATIVE  2
#define BE_CHANGELING 4
#define BE_MEME       8
#define BE_WIZARD     16
#define BE_MALF       32
#define BE_REV        64
#define BE_ALIEN      128
#define BE_AI         256
#define BE_CULTIST    512
#define BE_MONKEY     1024
#define BE_NINJA      2048
#define BE_RAIDER     4096
#define BE_PLANT      8192
#define BE_LOYALIST   16384
#define BE_PAI        32768

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
	"Monkey"           = BE_MONKEY,
	"Ninja"            = BE_NINJA,
	"Raider"           = BE_RAIDER,
	"Diona"            = BE_PLANT,
	"Loyalist"         = BE_LOYALIST,
	"pAI"              = BE_PAI
)

// Languages.
#define LANGUAGE_HUMAN  1
#define LANGUAGE_ALIEN  2
#define LANGUAGE_DOG    4
#define LANGUAGE_CAT    8
#define LANGUAGE_BINARY 16
#define LANGUAGE_OTHER  32768

#define LANGUAGE_UNIVERSAL 65535

#define LEFT  1
#define RIGHT 2

// For secHUDs and medHUDs and variants. The number is the location of the image on the list hud_list of humans.
#define      HEALTH_HUD 1 // A simple line rounding the mob's number health.
#define      STATUS_HUD 2 // Alive, dead, diseased, etc.
#define          ID_HUD 3 // The job asigned to your ID.
#define      WANTED_HUD 4 // Wanted, released, paroled, security status.
#define    IMPLOYAL_HUD 5 // Loyality implant.
#define     IMPCHEM_HUD 6 // Chemical implant.
#define    IMPTRACK_HUD 7 // Tracking implant.
#define SPECIALROLE_HUD 8 // AntagHUD image.
#define  STATUS_HUD_OOC 9 // STATUS_HUD without virus DB check for someone being ill.
#define 	  LIFE_HUD 10 // STATUS_HUD that only reports dead or alive

// Pulse levels, very simplified.
#define PULSE_NONE    0 // So !M.pulse checks would be possible.
#define PULSE_SLOW    1 // <60     bpm
#define PULSE_NORM    2 //  60-90  bpm
#define PULSE_FAST    3 //  90-120 bpm
#define PULSE_2FAST   4 // >120    bpm
#define PULSE_THREADY 5 // Occurs during hypovolemic shock
#define GETPULSE_HAND 0 // Less accurate. (hand)
#define GETPULSE_TOOL 1 // More accurate. (med scanner, sleeper, etc.)

// Body builds
#define BODY_DEFAULT	0	// Default body build
#define BODY_SLIM		1	// Slim body build

// Species flags.
#define NO_BLOOD          1     // Vessel var is not filled with blood, cannot bleed out.
#define NO_BREATHE        2     // Cannot suffocate or take oxygen loss.
#define NO_SCAN           4     // Cannot be scanned in a DNA machine/genome-stolen.
#define NO_PAIN           8     // Cannot suffer halloss/recieves deceptive health indicator.
#define NO_SLIP           16    // Cannot fall over.
#define NO_POISON         32    // Cannot not suffer toxloss.
#define HAS_SKIN_TONE     64    // Skin tone selectable in chargen. (0-255)
#define HAS_SKIN_COLOR    128   // Skin colour selectable in chargen. (RGB)
#define HAS_LIPS          256   // Lips are drawn onto the mob icon. (lipstick)
#define HAS_UNDERWEAR     512   // Underwear is drawn onto the mob icon.
#define IS_PLANT          1024  // Is a treeperson.
#define IS_WHITELISTED    2048  // Must be whitelisted to play.
#define IS_SYNTHETIC      4096  // Is a machine race.
#define HAS_EYE_COLOR     8192  // Eye colour selectable in chargen. (RGB)
#define CAN_JOIN          16384 // Species is selectable in chargen.
#define IS_RESTRICTED     32768 // Is not a core/normally playable species. (castes, mutantraces)
#define REGENERATES_LIMBS 65536 // Attempts to regenerate unamputated limbs.

//Species size
#define SMALL  1 //mouse
#define MEDIUM 2 // human
#define LARGE  4 //2 humans )

// Language flags.
#define WHITELISTED 1   // Language is available if the speaker is whitelisted.
#define PUBLIC      2   // Language can be accquired by anybody without restriction.
#define NONVERBAL   4   // Language has a significant non-verbal component. Speech is garbled without line-of-sight.
#define SIGNLANG    8   // Language is completely non-verbal. Speech is displayed through emotes for those who can understand.
#define HIVEMIND    16  // Broadcast to all mobs with this language.
#define NONGLOBAL   32  // Do not add to general languages list.
#define INNATE      64  // All mobs can be assumed to speak and understand this language. (audible emotes)
#define NO_TALK_MSG 128 // Do not show the "\The [speaker] talks into \the [radio]" message
#define NO_STUTTER  256 // No stuttering, slurring, or other speech problems
#define COMMON_VERBS 512 // Robots will apply regular verbs to this.
//Flags for zone sleeping
#define ZONE_ACTIVE   1
#define ZONE_SLEEPING 0

/*
 *	Germs and infections.
*/

#define GERM_LEVEL_AMBIENT  110 // Maximum germ level you can reach by standing still.
#define GERM_LEVEL_MOVE_CAP 200 // Maximum germ level you can reach by running around.

#define INFECTION_LEVEL_ONE   100
#define INFECTION_LEVEL_TWO   500
#define INFECTION_LEVEL_THREE 1000

/*
 *	Shuttles.
*/

// These define the time taken for the shuttle to get to the space station, and the time before it leaves again.
#define SHUTTLE_PREPTIME                300 // 5 minutes = 300 seconds - after this time, the shuttle departs centcom and cannot be recalled.
#define SHUTTLE_LEAVETIME               180 // 3 minutes = 180 seconds - the duration for which the shuttle will wait at the station after arriving.
#define SHUTTLE_TRANSIT_DURATION        300 // 5 minutes = 300 seconds - how long it takes for the shuttle to get to the station.
#define SHUTTLE_TRANSIT_DURATION_RETURN 120 // 2 minutes = 120 seconds - for some reason it takes less time to come back, go figure.

// Shuttle moving status.
#define SHUTTLE_IDLE      0
#define SHUTTLE_WARMUP    1
#define SHUTTLE_INTRANSIT 2

// Ferry shuttle processing status.
#define IDLE_STATE   0
#define WAIT_LAUNCH  1
#define FORCE_LAUNCH 2
#define WAIT_ARRIVE  3
#define WAIT_FINISH  4

// computer3 error codes, move lower in the file when it passes dev -Sayu
#define PROG_CRASH          1  // Generic crash.
#define MISSING_PERIPHERAL  2  // Missing hardware.
#define BUSTED_ASS_COMPUTER 4  // Self-perpetuating error.  BAC will continue to crash forever.
#define MISSING_PROGRAM     8  // Some files try to automatically launch a program. This is that failing.
#define FILE_DRM            16 // Some files want to not be copied/moved. This is them complaining that you tried.
#define NETWORK_FAILURE     32

// Special return values from bullet_act(). Positive return values are already used to indicate the blocked level of the projectile.
#define PROJECTILE_CONTINUE   -1 //if the projectile should continue flying after calling bullet_act()
#define PROJECTILE_FORCE_MISS -2 //if the projectile should treat the attack as a miss (suppresses attack and admin logs) - only applies to mobs.

// Some on_mob_life() procs check for alien races.
#define IS_DIONA  1
#define IS_VOX    2
#define IS_SKRELL 3
#define IS_UNATHI 4
#define IS_XENOS  5
#define IS_ARACHNA 6

#define MAX_GEAR_COST 10 // Used in chargen for accessory loadout limit.

/*
 *	Atmospherics Machinery.
*/
#define MAX_SIPHON_FLOWRATE   2500 // L/s. This can be used to balance how fast a room is siphoned. Anything higher than CELL_VOLUME has no effect.
#define MAX_SCRUBBER_FLOWRATE 200  // L/s. Max flow rate when scrubbing from a turf.

// These balance how easy or hard it is to create huge pressure gradients with pumps and filters.
// Lower values means it takes longer to create large pressures differences.
// Has no effect on pumping gasses from high pressure to low, only from low to high.
#define ATMOS_PUMP_EFFICIENCY   2.5
#define ATMOS_FILTER_EFFICIENCY 2.5

// Will not bother pumping or filtering if the gas source as fewer than this amount of moles, to help with performance.
#define MINIMUM_MOLES_TO_PUMP   0.01
#define MINIMUM_MOLES_TO_FILTER 0.1

// The flow rate/effectiveness of various atmos devices is limited by their internal volume,
// so for many atmos devices these will control maximum flow rates in L/s.
#define ATMOS_DEFAULT_VOLUME_PUMP   200 // Liters.
#define ATMOS_DEFAULT_VOLUME_FILTER 200 // L.
#define ATMOS_DEFAULT_VOLUME_MIXER  200 // L.
#define ATMOS_DEFAULT_VOLUME_PIPE   70  // L.

// Chemistry.
#define CHEM_SYNTH_ENERGY 500 // How much energy does it take to synthesize 1 unit of chemical, in Joules.

#define SPEED_OF_LIGHT       3e8    // Approximate.
#define SPEED_OF_LIGHT_SQ    9e16
#define FIRE_DAMAGE_MODIFIER 0.0215 // Higher values result in more external fire damage to the skin. (default 0.0215)
#define  AIR_DAMAGE_MODIFIER 2.025  // More means less damage from hot air scalding lungs, less = more damage. (default 2.025)
#define INFINITY             1.#INF

// Setting this much higher than 1024 could allow spammers to DOS the server easily.
#define MAX_MESSAGE_LEN       1024
#define MAX_PAPER_MESSAGE_LEN 12288
#define MAX_BOOK_MESSAGE_LEN  36864
#define MAX_LNAME_LEN         64
#define MAX_NAME_LEN          26

// Event defines.
#define EVENT_LEVEL_MUNDANE  1
#define EVENT_LEVEL_MODERATE 2
#define EVENT_LEVEL_MAJOR    3

// Suit sensor levels
#define SUIT_SENSOR_OFF      0
#define SUIT_SENSOR_BINARY   1
#define SUIT_SENSOR_VITAL    2
#define SUIT_SENSOR_TRACKING 3

// NanoUI flags
#define STATUS_INTERACTIVE 2 // GREEN Visability
#define STATUS_UPDATE 1 // ORANGE Visability
#define STATUS_DISABLED 0 // RED Visability
#define STATUS_CLOSE -1 // Close the interface

//General-purpose life speed define for plants.
#define HYDRO_SPEED_MULTIPLIER 1

// Robot AI notifications
#define ROBOT_NOTIFICATION_NEW_UNIT 1
#define ROBOT_NOTIFICATION_NEW_NAME 2
#define ROBOT_NOTIFICATION_NEW_MODULE 3
#define ROBOT_NOTIFICATION_MODULE_RESET 4

#define BOMBCAP_DVSTN_RADIUS (max_explosion_range/4)
#define BOMBCAP_HEAVY_RADIUS (max_explosion_range/2)
#define BOMBCAP_LIGHT_RADIUS max_explosion_range
#define BOMBCAP_FLASH_RADIUS (max_explosion_range*1.5)

#define DEFAULT_JOB_TYPE /datum/job/assistant

// Appearance change flags
#define APPEARANCE_UPDATE_DNA 1
#define APPEARANCE_RACE	(2|APPEARANCE_UPDATE_DNA)
#define APPEARANCE_GENDER (4|APPEARANCE_UPDATE_DNA)
#define APPEARANCE_SKIN 8
#define APPEARANCE_HAIR 16
#define APPEARANCE_HAIR_COLOR 32
#define APPEARANCE_FACIAL_HAIR 64
#define APPEARANCE_FACIAL_HAIR_COLOR 128
#define APPEARANCE_EYE_COLOR 256
#define APPEARANCE_ALL_HAIR (APPEARANCE_HAIR|APPEARANCE_HAIR_COLOR|APPEARANCE_FACIAL_HAIR|APPEARANCE_FACIAL_HAIR_COLOR)
#define APPEARANCE_ALL 511

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
#define MODE_MONKEY "monkey"
#define MODE_RENEGADE "renegade"
#define MODE_REVOLUTIONARY "revolutionary"
#define MODE_LOYALIST "loyalist"
#define MODE_MALFUNCTION "malf"
#define MODE_TRAITOR "traitor"
#define MODE_MEME "meme"

#define MIN_SUPPLIED_LAW_NUMBER 15
#define MAX_SUPPLIED_LAW_NUMBER 50

//Area flags, possibly more to come
#define RAD_SHIELDED 1 //shielded from radiation, clearly

//intent flags, why wasn't this done the first time?
#define I_HELP		"help"
#define I_DISARM	"disarm"
#define I_GRAB		"grab"
#define I_HURT		"harm"

/*
	These are used Bump() code for living mobs, in the mob_bump_flag, mob_swap_flags, and mob_push_flags vars to determine whom can bump/swap with whom.
*/
#define HUMAN 1
#define MONKEY 2
#define ALIEN 4
#define ROBOT 8
#define SLIME 16
#define SIMPLE_ANIMAL 32
#define HEAVY 64

#define ALLMOBS (HUMAN|MONKEY|ALIEN|ROBOT|SLIME|SIMPLE_ANIMAL|HEAVY)

#define NEXT_MOVE_DELAY 8

#define DROPLIMB_EDGE 0
#define DROPLIMB_BLUNT 1
#define DROPLIMB_BURN 2

// Custom layer definitions, supplementing the default TURF_LAYER, MOB_LAYER, etc.
#define DOOR_OPEN_LAYER 2.7		//Under all objects if opened. 2.7 due to tables being at 2.6
#define DOOR_CLOSED_LAYER 3.1	//Above most items if closed
#define LIGHTING_LAYER 11
#define OBFUSCATION_LAYER 21	//Where images covering the view for eyes are put
#define SCREEN_LAYER 22			//Mob HUD/effects layer


/////////////////
////WIZARD //////
/////////////////

/*		WIZARD SPELL FLAGS		*/
#define GHOSTCAST		1	//can a ghost cast it?
#define NEEDSCLOTHES	2	//does it need the wizard garb to cast? Nonwizard spells should not have this
#define NEEDSHUMAN		4	//does it require the caster to be human?
#define Z2NOCAST		8	//if this is added, the spell can't be cast at centcomm
#define STATALLOWED		16	//if set, the user doesn't have to be conscious to cast. Required for ghost spells
#define IGNOREPREV		32	//if set, each new target does not overlap with the previous one
//The following flags only affect different types of spell, and therefore overlap
//Targeted spells
#define INCLUDEUSER		64	//does the spell include the caster in its target selection?
#define SELECTABLE		128	//can you select each target for the spell?
//AOE spells
#define IGNOREDENSE		64	//are dense turfs ignored in selection?
#define IGNORESPACE		128	//are space turfs ignored in selection?
//End split flags
#define CONSTRUCT_CHECK	256	//used by construct spells - checks for nullrods
#define NO_BUTTON		512	//spell won't show up in the HUD with this

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

///////WIZ END/////////

//singularity defines
#define STAGE_ONE 	1
#define STAGE_TWO 	3
#define STAGE_THREE	5
#define STAGE_FOUR	7
#define STAGE_FIVE	9
#define STAGE_SUPER	11

// Camera networks
#define NETWORK_CRESCENT "Crescent"
#define NETWORK_CIVILIAN_EAST "Civilian East"
#define NETWORK_CIVILIAN_WEST "Civilian West"
#define NETWORK_COMMAND "Command"
#define NETWORK_ENGINE "Engine"
#define NETWORK_ENGINEERING "Engineering"
#define NETWORK_ENGINEERING_OUTPOST "Engineering Outpost"
#define NETWORK_ERT "ERT"
#define NETWORK_EXODUS "Exodus"
#define NETWORK_MEDICAL "Medical"
#define NETWORK_MINE "MINE"
#define NETWORK_RESEARCH "Research"
#define NETWORK_RESEARCH_OUTPOST "Research Outpost"
#define NETWORK_ROBOTS "Robots"
#define NETWORK_PRISON "Prison"
#define NETWORK_SECURITY "Security"
#define NETWORK_TELECOM "Tcomsat"
#define NETWORK_THUNDER "thunder"

// Languages
#define LANGUAGE_SOL_COMMON "Sol Common"
#define LANGUAGE_UNATHI "Sinta'unathi"
#define LANGUAGE_SIIK_MAAS "Siik'maas"
#define LANGUAGE_SIIK_TAJR "Siik'tajr"
#define LANGUAGE_SKRELLIAN "Skrellian"
#define LANGUAGE_ROOTSPEAK "Rootspeak"
#define LANGUAGE_TRADEBAND "Tradeband"
#define LANGUAGE_GUTTER "Gutter"
#define LANGUAGE_SIIK_MAAS "Siik'maas"
#define LANGUAGE_SURZHYK "Surzhyk"


#define WALL_CAN_OPEN 1
#define WALL_OPENING 2

#define DEFAULT_WALL_MATERIAL "steel"
#define DEFAULT_TABLE_MATERIAL "plastic"

//default item on-mob icons
#define INV_HEAD_DEF_ICON 'icons/mob/head.dmi'
#define INV_BACK_DEF_ICON 'icons/mob/back.dmi'
#define INV_L_HAND_DEF_ICON 'icons/mob/items/lefthand.dmi'
#define INV_R_HAND_DEF_ICON 'icons/mob/items/righthand.dmi'
//#define INV_W_UNIFORM_DEF_ICON 'icons/mob/uniform.dmi'
#define INV_ACCESSORIES_DEF_ICON 'icons/mob/ties.dmi'

//slim item on-mob icons
#define INV_HEAD_SLIM_ICON 'icons/mob/head.dmi'
#define INV_BACK_SLIM_ICON 'icons/mob/back_f.dmi'
#define INV_L_HAND_SLIM_ICON 'icons/mob/items/lefthand.dmi'
#define INV_R_HAND_SLIM_ICON 'icons/mob/items/righthand.dmi'
//#define INV_W_UNIFORM_SLIM_ICON 'icons/mob/uniform_f.dmi'
#define INV_ACCESSORIES_SLIM_ICON 'icons/mob/ties_f.dmi'


#define SHARD_SHARD "shard"
#define SHARD_SHRAPNEL "shrapnel"
#define SHARD_STONE_PIECE "piece"
#define SHARD_SPLINTER "splinters"
#define SHARD_NONE ""

#define MATERIAL_UNMELTABLE 1
#define MATERIAL_BRITTLE 2
#define MATERIAL_PADDING 4

#define TABLE_BRITTLE_MATERIAL_MULTIPLIER 4 // Amount table damage is multiplied by if it is made of a brittle material (e.g. glass)

#define FOR_DVIEW(type, range, center, invis_flags) \
	dview_mob.loc = center; \
	dview_mob.see_invisible = invis_flags; \
	for(type in view(range, dview_mob))
#define END_FOR_DVIEW dview_mob.loc = null
