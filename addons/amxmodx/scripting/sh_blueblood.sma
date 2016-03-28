//Library
#include <amxmod>
#include <Vexd_Utilities>
#include <superheromod>

// -VERSION-
// Update: 1.1
// Renamed the hero to Blue Blood since it's similar to Red Blood, 
// instead of taking damage, you give out weapons.

//CVARS for Blue Blood - copy and paste this into your shconfig.cfg
//blueblood - (Default level: 5)
//blueblood - (Default: 60)

//Credits goes to:
//jtp10181 / {HOJ}Batman for the Batman sh_giveweapon code.
//Firewalker877 for the lightning effect and sound code from Red Blood.

//Register Plugin Event
#define AUTHOR Sir-LaggAlot
#define VERSION 1.1

// VARIABLES
new gHeroName[]="Blue Blood"
new gHasBlueBloodPower[SH_MAXSLOTS+1]
new gHasWeapons[SH_MAXSLOTS+1]
new gSpriteLightning

// WEAPONS
#define giveTotal 27
new weapArray[giveTotal][27] = {
	"weapon_usp",
	"weapon_m3",
	"weapon_mac10",
	"weapon_ump45",
	"weapon_glock18",
	"weapon_elite",
	"weapon_mp5navy",
	"weapon_tmp",
	"weapon_deagle",
	"weapon_p228",
	"weapon_fiveseven",
	"weapon_p90",
	"weapon_xm1014",
	"weapon_ak47",
	"weapon_famas",
	"weapon_galil",
	"weapon_scout",
	"weapon_g3sg1",
	"weapon_sg552",
	"weapon_m4a1",
	"weapon_aug",
	"weapon_sg550",
	"weapon_awp",
	"weapon_m249",
	"weapon_hegrenade",
	"weapon_flashbang",
	"weapon_smokegrenade"
}

public plugin_init()
{
	// PLUGIN INFO
	register_plugin("SUPERHERO Weapon Giver", "VERSION", "AUTHOR")

	// DO NOT EDIT THIS FILE TO CHANGE CVARS, USE THE SHCONFIG.CFG
	register_cvar("blueblood_level", "0")
	register_cvar("blueblood_cooldown", "60")

	// FIRE THE EVENT TO CREATE THIS SUPERHERO!
	shCreateHero(gHeroName, "Blood Blood", "Load up your opponent with weapons when you shoot them.", false, "blueblood_level")

	// REGISTER EVENTS THIS HERO WILL RESPOND TO! (AND SERVER COMMANDS)
	register_srvcmd("blueblood_init", "blueblood_init")
	shRegHeroInit(gHeroName, "blueblood_init")

	//EXTRA EVENTS
	register_event("ResetHUD","newSpawn","b")
	register_event("Damage", "blueblood_damage", "b", "2!0")
}

public blueblood_init()
{
	// First Argument is an id
	new temp[6]
	read_argv(1,temp,5)
	new id=str_to_num(temp)

	// 2nd Argument is 0 or 1 depending on whether the id has shocker
	read_argv(2,temp,5)
	new hasPowers=str_to_num(temp)

	gHasBlueBloodPower[id] = (hasPowers != 0)

	gHasWeapons[id] = false
}

public blueblood_damage(id)
{
	if (!shModActive() || !is_user_alive(id)) return

	new weapon, bodypart, attacker = get_user_attacker(id,weapon,bodypart)

	if ( attacker <= 0 || attacker > SH_MAXSLOTS ) return

	if (!gHasBlueBloodPower[attacker] || gPlayerUltimateUsed[attacker] ) return

	if ( is_user_alive(id) && id != attacker && is_user_connected(attacker)) {
		playSound(id)
		playSound(attacker)
		lightning_effect(id, attacker, 20)

		for (new x = 0; x < giveTotal; x++) {
		shGiveWeapon(id, weapArray[x])

		gHasWeapons[id] = true
		}
		ultimateTimer(attacker, get_cvar_num("blueblood_cooldown") * 1.0)
	}
}

public newSpawn(id)
{
	gHasWeapons[id] = false

	if (!shModActive()) return

	gPlayerUltimateUsed[id] = false
}

public plugin_precache()
{
	precache_sound("shmod/blueblood.wav")
	gSpriteLightning = precache_model("sprites/lgtning.spr")
}

public playSound(id)
{
	new parm[1]
	parm[0] = id

	emit_sound(id, CHAN_AUTO, "shmod/blueblood.wav", 1.0, ATTN_NORM, 0, PITCH_HIGH)
	set_task(1.5,"stopSound", 0, parm, 1)
}

public stopSound(parm[])
{
	new sndStop = (1<<5)
	emit_sound(parm[0], CHAN_AUTO, "shmod/blueblood.wav", 1.0, ATTN_NORM, sndStop, PITCH_NORM)
}

public lightning_effect(id, targetid, linewidth)
{
	message_begin( MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte(8)
	write_short(id)	// start entity
	write_short(targetid)	// entity
	write_short(gSpriteLightning)	// model
	write_byte(0) // starting frame
	write_byte(15)  // frame rate
	write_byte(20)  // life
	write_byte(linewidth)  // line width
	write_byte(60)  // noise amplitude
	write_byte(0)	// r, g, b
	write_byte(0)	// r, g, b
	write_byte(255)	// r, g, b
	write_byte(255)	// brightness
	write_byte(0)	// scroll speed
	message_end()
}