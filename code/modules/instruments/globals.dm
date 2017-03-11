// * Use this section for fine tuning
// * * MUSICAL_HIGHEST_OCTAVE is the highest octave allowed to be played on any instrument. Values higher than 9 are meaningless since only one digit is allowed for an octave
// * * MUSICAL_LOWEST_OCTAVE is the lowest octave allowed to be played on any instrument. Values lower than 0 are meaningless since they correspond to infrasound and also only one digit is allowed for octave
// * * MUSICAL_HIGHEST_TRANSPOSE should be used to limit the amount of octaves that a player can transpose a melody by
// * * MUSICAL_LOWEST_TRANPOSE is the same as above
// * * MUSICAL_LONGEST_TIMER limits the sustain timer
// * * MUSICAL_SOFTEST_DROP and MUSICAL_HARDEST_DROP limit the range of soft_coeff. MUSICAL_SOFTEST_DROP must be higher than 1 lest you get never-ending sounds which will cause channel overflow
// * * MUSICAL_CHANNELS determines the amount of channels reserved for each instrument in the world. More channels allows more layered music, but also limits the amount of instrument coexisting in the world.
// * * MUSICAL_MAX_LINES determines the highest amount of lines that can any instrument can input
// * * MUSICAL_MAX_LINE_LENGTH is self-explanatory

#define MUSICAL_HIGHEST_OCTAVE 9
#define MUSICAL_LOWEST_OCTAVE 0

#define MUSICAL_HIGHEST_TRANSPOSE 4
#define MUSICAL_LOWEST_TRANSPOSE -4

#define MUSICAL_LONGEST_TIMER 50
#define MUSICAL_SOFTEST_DROP 1.07
#define MUSICAL_HARDEST_DROP 10.0

#define MUSICAL_CHANNELS 128
#define MUSICAL_MAX_LINES 1000
#define MUSICAL_MAX_LINE_LENGTH 50


// Don't change
#define OCTAVE_START(x) 12*(x)
var/global/list/n2t_int = list() // Instead of num2text it is used for faster access in n2t
var/global/list/free_channels = list() // Used to take up some channels and avoid istruments cancelling each other
var/global/list/nn2no = list(0,2,4,5,7,9,11) // Maps note num onto note offset

world/New()
	for (var/i=1, i<=1024, i++) // Currently only 1024 channels are allowed
		free_channels += i
	..()

proc/n2t(key) // Used in of num2text for faster access in sample_map
	if (!n2t_int.len)
		for (var/i=1, i<=127, i++)
			n2t_int += num2text(i)

	if (key==0)
		return "0" // Fuck you BYOND
	if (!isnum(key) || key < 0 || key>127 || round(key) != key)
		CRASH("n2t argument must be an integer from 0 to 127")
	return n2t_int[key]

/datum/sample_pair
	var/sample
	var/deviation = 0

	New(sample_file, deviation)
		src.sample = sample_file
		src.deviation = deviation