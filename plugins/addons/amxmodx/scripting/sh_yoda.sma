//YODA! - from Star Wars. Need I say more.

/*

//Yoda
yoda_level 9
yoda_cooldown 10	//Time in seconds until yoda can push again
yoda_radius 400	//How close does enemy have to be in order to push them (def=400)
yoda_power 600		//Force of the push, velocity multiplier (def=600)
yoda_damage 10 	//Amount of damage a push does to an enemy (def=10)
yoda_selfdmg 0		//Amount of damage using push does to self (def=0)

*/

/*
* v1.2 - vittu - 6/23/05
*      - Minor code clean up.
*
* v1.1 - vittu - 4/16/05
*      - Cleaned up code.
*      - Fixed self damage cvar to work and made it define amount of damage instead.
*      - Changed cooldown to only be set when an enemy is actually pushed.
*      - Added sound to damage caused.
*      - Added a stun so enemies can't easily push against the push force.
*
*   from original code "MORE JEDI POWERS TO BE ADDED :)"
*/

#include <amxmod>
#include <Vexd_Utilities>
#include <superheromod>

// GLOBAL VARIABLES
new gHeroName[]="Yoda"
new bool:gHasYodaPower[SH_MAXSLOTS+1]
//----------------------------------------------------------------------------------------------
public plugin_init()
{
	// Plugin Info
	register_plugin("SUPERHERO Yoda", "1.2", "AssKicR / Freecode")

	// DO NOT EDIT THIS FILE TO CHANGE CVARS, USE THE SHCONFIG.CFG
	register_cvar("yoda_level", "9")
	register_cvar("yoda_cooldown", "10")
	register_cvar("yoda_radius", "400")
	register_cvar("yoda_power", "600")
	register_cvar("yoda_damage", "10")
	register_cvar("yoda_selfdmg", "0")

	// FIRE THE EVENT TO CREATE THIS SUPERHERO!
	shCreateHero(gHeroName, "Force Push", "Push enemies away with the Jedi Power of the Force.", true, "yoda_level")

	// REGISTER EVENTS THIS HERO WILL RESPOND TO! (AND SERVER COMMANDS)
	// INIT
	register_srvcmd("yoda_init", "yoda_init")
	shRegHeroInit(gHeroName, "yoda_init")

	// EVENTS
	register_event("ResetHUD", "newSpawn", "b")

	// KEY DOWN
	register_srvcmd("yoda_kd", "yoda_kd")
	shRegKeyDown(gHeroName, "yoda_kd")
}
//----------------------------------------------------------------------------------------------
public plugin_precache()
{
	precache_sound("shmod/yoda_forcepush.wav")
	precache_sound("player/pl_pain2.wav")
}
//----------------------------------------------------------------------------------------------
public yoda_init()
{
	// First Argument is an id
	new temp[6]
	read_argv(1,temp,5)
	new id = str_to_num(temp)

	// 2nd Argument is 0 or 1 depending on whether the id has the hero
	read_argv(2,temp,5)
	new hasPowers = str_to_num(temp)

	gHasYodaPower[id] = (hasPowers != 0)
}
//----------------------------------------------------------------------------------------------
public newSpawn(id)
{
	gPlayerUltimateUsed[id] = false
}
//----------------------------------------------------------------------------------------------
// RESPOND TO KEYDOWN
public yoda_kd()
{
	if ( !shModActive() || !hasRoundStarted() ) return

	// First Argument is an id
	new temp[6]
	read_argv(1,temp,5)
	new id = str_to_num(temp)

	if ( !is_user_alive(id) || !gHasYodaPower[id] ) return

	if ( gPlayerUltimateUsed[id] ) {
		playSoundDenySelect(id)
		return
	}

	force_push(id)
}
//----------------------------------------------------------------------------------------------
public force_push(id)
{
	if ( !is_user_alive(id) ) return

	new team[33], players[SH_MAXSLOTS], pnum
	new origin[3], vorigin[3], parm[4], distance
	new Float:tempVelocity[3] = {0.0, 0.0, 200.0}
	new bool:enemyPushed = false

	get_user_team(id, team, 32)

	// Find all alive enemies
	if ( equali(team, "CT") ) {
		get_players(players, pnum, "ae", "TERRORIST")
	}
	else {
		get_players(players, pnum, "ae", "CT")
	}

	get_user_origin(id, origin)

	for ( new vic = 0; vic < pnum; vic++ ) {
		if( !is_user_alive(players[vic]) ) continue

		get_user_origin(players[vic], vorigin)

		distance = get_distance(origin, vorigin)

		if ( distance < get_cvar_num("yoda_radius") ) {

			// Set cooldown/sound/self damage only once, if push is used
			if ( !enemyPushed ) {
				if (get_cvar_float("yoda_cooldown") > 0.0) ultimateTimer(id, get_cvar_float("yoda_cooldown"))

				emit_sound(id, CHAN_ITEM, "shmod/yoda_forcepush.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)

				// Do damage to Yoda?
				if ( get_cvar_num("yoda_selfdmg") > 0 ) {
					shExtraDamage(id, id, get_cvar_num("yoda_selfdmg"), "Force Push")
				}
				enemyPushed = true
			}

			parm[0] = ((vorigin[0] - origin[0]) / distance) * get_cvar_num("yoda_power")
			parm[1] = ((vorigin[1] - origin[1]) / distance) * get_cvar_num("yoda_power")
			parm[2] = players[vic]
			parm[3] = id

			// Stun enemy makes them easier to push
			shStun(players[vic], 1)
			set_user_maxspeed(players[vic], 1.0)

			// First lift them
			Entvars_Set_Vector(players[vic], EV_VEC_velocity, tempVelocity)

			// Then push them back in x seconds after lift and do some damage
			set_task(0.1, "move_enemy", 0, parm, 4)
		}
	}

	if ( !enemyPushed && is_user_alive(id) ) {
		client_print(id, print_chat, "[SH](Yoda) No enemies within Range!")
		playSoundDenySelect(id)
	}
}
//----------------------------------------------------------------------------------------------
public move_enemy(parm[])
{
	new victim = parm[2]
	new id = parm[3]

	new Float:fl_velocity[3]
	fl_velocity[0] = float(parm[0])
	fl_velocity[1] = float(parm[1])
	fl_velocity[2] = 200.0

	Entvars_Set_Vector(victim, EV_VEC_velocity, fl_velocity)

	// do some damage
	if ( get_cvar_num("yoda_damage") > 0 ) {
		emit_sound(victim, CHAN_BODY, "player/pl_pain2.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)

		if ( !is_user_alive(victim) ) return

		shExtraDamage(victim, id, get_cvar_num("yoda_damage"), "Force Push")
	}
}
//----------------------------------------------------------------------------------------------