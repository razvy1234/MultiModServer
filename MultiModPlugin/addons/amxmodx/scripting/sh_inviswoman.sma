//INVISIBLE WOMAN! from the Fantastic Four, Sue Richards psionic ability to manipulate ambient cosmic energy enables her to bend light around her body without distortion.

/* CVARS - copy and paste to shconfig.cfg

//Invisible Woman
inviswoman_level 6
inviswoman_alpha 0		//Value of invisiblity 0-invisible 255-completly visible (default=0)
inviswoman_time 5		//# of seconds of invisiblity
inviswoman_cooldown 30	//# of seconds before invisiblity can be used again from keydown

*/

/*
* v1.1 - vittu - 8/8/05
*      - Cleaned up code.
*      - Added cvar for alpha value.
*      - Changed sound from cows "moo" to a heartbeat, very low volume. 
*
*/

#include <amxmod>
#include <superheromod>

// GLOBAL VARIABLES
new gHeroName[]="Invisible Woman"
new bool:gHasInvisWomanPower[SH_MAXSLOTS+1]
new gInvisWomanTimer[SH_MAXSLOTS+1]
new gInvisWomanMode[SH_MAXSLOTS+1]
new gAlpha
new gInvisWomanSound[]="player/heartbeat1.wav"
//----------------------------------------------------------------------------------------------
public plugin_init()
{
	// Plugin Info
	register_plugin("SUPERHERO Invisible Woman", "1.1", "Glooba")

	// DO NOT EDIT THIS FILE TO CHANGE CVARS, USE THE SHCONFIG.CFG
	register_cvar("inviswoman_level", "6")
	register_cvar("inviswoman_alpha", "0")
	register_cvar("inviswoman_time", "5")
	register_cvar("inviswoman_cooldown", "30")

	// FIRE THE EVENT TO CREATE THIS SUPERHERO!
	shCreateHero(gHeroName, "Invisibility", "Press +power key to become invisible for a short period of time", true, "inviswoman_level")

	// REGISTER EVENTS THIS HERO WILL RESPOND TO! (AND SERVER COMMANDS)
	// INIT
	register_srvcmd("inviswoman_init", "inviswoman_init")
	shRegHeroInit(gHeroName, "inviswoman_init")

	// KEY DOWN
	register_srvcmd("inviswoman_kd", "inviswoman_kd")
	shRegKeyDown(gHeroName, "inviswoman_kd")

	// NEW SPAWN
	register_event("ResetHUD", "newSpawn", "b")

	// DEATH
	register_event("DeathMsg", "inviswoman_death", "a")

	// LOOP
	set_task(1.0, "inviswoman_loop", 0, "", 0, "b")
}
//----------------------------------------------------------------------------------------------
public plugin_precache()
{
	precache_sound(gInvisWomanSound)
}
//----------------------------------------------------------------------------------------------
public inviswoman_init()
{
	// First Argument is an id
	new temp[6]
	read_argv(1, temp, 5)
	new id = str_to_num(temp)

	// 2nd Argument is 0 or 1 depending on whether the id has
	read_argv(2, temp, 5)
	new hasPowers = str_to_num(temp)

	if ( hasPowers ) {
		// Make sure looop doesn't fire for them
		gInvisWomanTimer[id] = -1
	}
	//This gets run if they had the power but don't anymore
	else if ( gHasInvisWomanPower[id] && gInvisWomanTimer[id] >= 0 ) {
		inviswoman_endmode(id)
	}

	//Sets this variable to the current status
	gHasInvisWomanPower[id] = (hasPowers != 0)
}
//----------------------------------------------------------------------------------------------
public newSpawn(id)
{
	gPlayerUltimateUsed[id] = false
	gInvisWomanTimer[id] = -1
	if ( gHasInvisWomanPower[id] ) {
		inviswoman_endmode(id)
	}
}
//----------------------------------------------------------------------------------------------
// RESPOND TO KEYDOWN
public inviswoman_kd()
{
	if ( !hasRoundStarted() ) return

	// First Argument is an id
	new temp[6]
	read_argv(1,temp,5)
	new id = str_to_num(temp)

	if ( !is_user_alive(id) || !gHasInvisWomanPower[id] ) return

	// Make sure they're not in the middle of invisible woman mode
	// Let them know they already used their ultimate if they have
	if ( gPlayerUltimateUsed[id] || gInvisWomanTimer[id] > 0 ) {
		playSoundDenySelect(id)
		return
	}

	gInvisWomanTimer[id] = get_cvar_num("inviswoman_time")
	if (get_cvar_float("inviswoman_cooldown") > 0.0 ) ultimateTimer(id, get_cvar_float("inviswoman_cooldown"))

	gAlpha = get_cvar_num("inviswoman_alpha")
	set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, gAlpha)

	gInvisWomanMode[id] = true

	new message[128]
	format(message, 127, "You have now turned invisible")
	set_hudmessage(50, 50, 255, -1.0, 0.28, 0, 0.0, 1.0, 0.0, 0.0, 54)
	show_hudmessage(id, message)

	emit_sound(id, CHAN_STATIC, gInvisWomanSound, 0.1, ATTN_NORM, 0, PITCH_NORM)
}
//----------------------------------------------------------------------------------------------
public stopSound(id)
{
	emit_sound(id, CHAN_STATIC, gInvisWomanSound, 0.1, ATTN_NORM, 0, PITCH_NORM)
}
//----------------------------------------------------------------------------------------------
public inviswoman_loop()
{
	for ( new id = 1; id <= SH_MAXSLOTS; id++ ) {
		if ( gHasInvisWomanPower[id] && is_user_alive(id) ) {
			if ( gInvisWomanTimer[id] > 0 ) {
				new message[128]
				format(message, 127, "%d second%s left of invisibility", gInvisWomanTimer[id], gInvisWomanTimer[id] == 1 ? "" : "s")
				set_hudmessage(50, 50, 255, -1.0, 0.28, 0, 0.0, 1.0, 0.0, 0.0, 54)
				show_hudmessage(id, message)

				set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, gAlpha)

				gInvisWomanTimer[id]--
			}
			else if ( gInvisWomanTimer[id] == 0 ) {
					gInvisWomanTimer[id]--
					inviswoman_endmode(id)
			}
		}
	}
}
//----------------------------------------------------------------------------------------------
public inviswoman_endmode(id)
{
	if ( !is_user_connected(id) ) return

	gInvisWomanTimer[id] = -1
	stopSound(id)

	if ( gInvisWomanMode[id]) {
		set_user_rendering(id)
		gInvisWomanMode[id] = false
	}
}
//----------------------------------------------------------------------------------------------
public inviswoman_death()
{
	new id = read_data(2)

	gPlayerUltimateUsed[id] = false

	gInvisWomanTimer[id] = -1

	if (gHasInvisWomanPower[id]) {
		inviswoman_endmode(id)
	}
}
//----------------------------------------------------------------------------------------------
