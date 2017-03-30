// Number of identical messages required to get the spam-prevention auto-mute thing to trigger warnings and automutes.
#define SPAM_TRIGGER_WARNING  5
#define SPAM_TRIGGER_AUTOMUTE 10

// Preference toggles.
#define SOUND_ADMINHELP 1
#define SOUND_MIDI      2
#define SOUND_AMBIENCE  4
#define SOUND_LOBBY     8
#define SHOW_TYPING     16
#define CHAT_NOICONS    32
#define RUS_AUTOEMOTES  64
#define HIDE_MOTD       128
//#define ??? 256
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

//Species size
#define SMALL  1 //mouse
#define MEDIUM 2 // human
#define LARGE  4 //2 humans )

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
#define IS_VAMPIRE 7

#define MAX_GEAR_COST 10 // Used in chargen for accessory loadout limit.

// Chemistry.
#define CHEM_SYNTH_ENERGY 500 // How much energy does it take to synthesize 1 unit of chemical, in Joules.

#define SPEED_OF_LIGHT       3e8    // Approximate.
#define SPEED_OF_LIGHT_SQ    9e16
#define FIRE_DAMAGE_MODIFIER 0.0215 // Higher values result in more external fire damage to the skin. (default 0.0215)
#define  AIR_DAMAGE_MODIFIER 2.025  // More means less damage from hot air scalding lungs, less = more damage. (default 2.025)
#define INFINITY             1.#INF

//singularity defines
#define STAGE_ONE 	1
#define STAGE_TWO 	3
#define STAGE_THREE	5
#define STAGE_FOUR	7
#define STAGE_FIVE	9
#define STAGE_SUPER	11


#define WALL_CAN_OPEN 1
#define WALL_OPENING 2
