// Damage things. TODO: Merge these down to reduce on defines.
// Way to waste perfectly good damage-type names (BRUTE) on this... If you were really worried about case sensitivity, you could have just used rlowertext(damagetype) in the proc.
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
#define BRUTELOSS 0x1
#define FIRELOSS  0x2
#define TOXLOSS   0x4
#define OXYLOSS   0x8

// Organ defines.
#define ORGAN_CUT_AWAY   (1<<0)
#define ORGAN_BLEEDING   (1<<1)
#define ORGAN_BROKEN     (1<<2)
#define ORGAN_DESTROYED  (1<<3)
#define ORGAN_SPLINTED   (1<<4)
#define ORGAN_DEAD       (1<<5)
#define ORGAN_MUTATED    (1<<6)
#define SALVED           (1<<7)
#define ORGAN_GAUZED     (1<<8)
#define ORGAN_ATTACHABLE (1<<9)

#define DROPLIMB_EDGE 0
#define DROPLIMB_BLUNT 1
#define DROPLIMB_BURN 2

#define ORGAN_ASSISTED 1 // Like pacemakers, not robotic
#define ORGAN_ROBOT    2 // Fully robotic, no organic parts
#define ORGAN_LIFELIKE 3 // Robotic, made to appear organic

#define PROCESS_ACCURACY 10

//Germs and infections.
#define GERM_LEVEL_AMBIENT  110 // Maximum germ level you can reach by standing still.
#define GERM_LEVEL_MOVE_CAP 200 // Maximum germ level you can reach by running around.

#define INFECTION_LEVEL_ONE   100
#define INFECTION_LEVEL_TWO   500
#define INFECTION_LEVEL_THREE 1000
