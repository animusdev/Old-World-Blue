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

// Some arbitrary defines to be used by self-pruning global lists. (see master_controller)
#define PROCESS_KILL 26 // Used to trigger removal from a processing list.

#define ROUNDSTART_LOGOUT_REPORT_TIME 6000 // Amount of time (in deciseconds) after the rounds starts, that the player disconnect report is issued.

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
#define PROGRESSBAR		512

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

// Languages.
#define LANGUAGE_HUMAN  1
#define LANGUAGE_ALIEN  2
#define LANGUAGE_DOG    4
#define LANGUAGE_CAT    8
#define LANGUAGE_BINARY 16
#define LANGUAGE_OTHER  32768

#define LANGUAGE_UNIVERSAL 65535


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

#define BOMBCAP_DVSTN_RADIUS (max_explosion_range/4)
#define BOMBCAP_HEAVY_RADIUS (max_explosion_range/2)
#define BOMBCAP_LIGHT_RADIUS max_explosion_range
#define BOMBCAP_FLASH_RADIUS (max_explosion_range*1.5)

#define NEXT_MOVE_DELAY 8



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

#define FOR_DVIEW(type, range, center, invis_flags) \
	dview_mob.loc = center; \
	dview_mob.see_invisible = invis_flags; \
	for(type in view(range, dview_mob))
#define END_FOR_DVIEW dview_mob.loc = null
