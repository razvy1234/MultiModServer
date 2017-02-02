//Invisible Man

/* CVARS - copy and paste to shconfig.cfg

//Invisible Man
invisman_level 0
invisman_alpha 50		//Min Alpha level when invisible. 0 = invisible, 255 = full visibility.
invisman_delay 5.0		//Seconds a player must be still to become fully invisibile
invisman_checkmove 1 		//0 = no movement check only shooting, 1 = check movement buttons, 2 or more = speed movement to check
invisman_checkonground 0	//Must player be on ground to be invisible (Default 0 = no, 1 = yes)

*/

#include <superheromod>

// GLOBAL VARIABLES
new gHeroID
new const gHeroName[] = "Invisible Man"
new bool:gHasInvisibleMan[SH_MAXSLOTS+1]
new gIsInvisible[SH_MAXSLOTS+1]
new Float:gStillTime[SH_MAXSLOTS+1]
new const gButtons = IN_ATTACK | IN_ATTACK2 | IN_RELOAD | IN_USE 
new const gButtonsMove = IN_FORWARD | IN_BACK | IN_MOVELEFT | IN_MOVERIGHT | IN_JUMP
new gPcvarAlpha, gPcvarDelay, gPcvarCheckMove, gPcvarCheckOnGround
//----------------------------------------------------------------------------------------------
public plugin_init()
{
	// Plugin Info
	register_plugin("SUPERHERO Invisible Man", SH_VERSION_STR, "AssKicR")

	// DO NOT EDIT THIS FILE TO CHANGE CVARS, USE THE SHCONFIG.CFG
	new pcvarLevel = register_cvar("invisman_level", "0")
	gPcvarAlpha = register_cvar("invisman_alpha", "50")
	gPcvarDelay = register_cvar("invisman_delay", "5.0")
	gPcvarCheckMove = register_cvar("invisman_checkmove", "1.0")
	gPcvarCheckOnGround = register_cvar("invisman_checkonground", "0")

	// FIRE THE EVENT TO CREATE THIS SUPERHERO!
	gHeroID = sh_create_hero(gHeroName, pcvarLevel)
	sh_set_hero_info(gHeroID, "Invisibility", "Makes you less visible and harder to see. Only works while standing/not shooting and not zooming.")

	// CHECK SOME BUTTONS
	set_task(0.1, "checkButtons", _, _, _, "b")
}
//----------------------------------------------------------------------------------------------
public sh_hero_init(id, heroID, mode)
{
	if ( gHeroID != heroID ) return

	switch(mode) {
		case SH_HERO_ADD: {
			gHasInvisibleMan[id] = true
		}
		case SH_HERO_DROP: {
			gHasInvisibleMan[id] = false
			remInvisibility(id)
		}
	}

	sh_debug_message(id, 1, "%s %s", gHeroName, mode ? "ADDED" : "DROPPED")
}
//----------------------------------------------------------------------------------------------
public sh_client_spawn(id)
{
	remInvisibility(id)
}
//----------------------------------------------------------------------------------------------
public setInvisibility(id, alpha)
{
	if ( alpha < 100 ) {
		sh_set_rendering(id, 8, 8, 8, alpha, kRenderFxGlowShell, kRenderTransAlpha)
	}
	else {
		// Using FxNone, color makes no difference, straight alpha transition
		sh_set_rendering(id, 0, 0, 0, alpha, kRenderFxNone, kRenderTransAlpha)
	}
}
//----------------------------------------------------------------------------------------------
public remInvisibility(id)
{
	gStillTime[id] = -1.0

	if ( gIsInvisible[id] > 0 ) {
		sh_set_rendering(id)
		client_print(id, print_center, "[SH]%s: You are no longer cloaked", gHeroName)
	}

	gIsInvisible[id] = 0
}
//----------------------------------------------------------------------------------------------
public checkButtons()
{
	if ( !sh_is_active() || sh_is_freezetime() ) return

	new bool:setVisible
	new butnprs

	new players[SH_MAXSLOTS], playerCount, id
	get_players(players, playerCount, "ah")

	for( new i = 0; i < playerCount; i++ ) {
		id = players[i]

		if ( !gHasInvisibleMan[id] ) continue

		setVisible = false

		if ( get_pcvar_num(gPcvarCheckOnGround) && !(pev(id, pev_flags)&FL_ONGROUND) ) setVisible = true

		butnprs = pev(id, pev_button)

		// Always check these
		if ( butnprs & gButtons ) setVisible = true

		// Check movement? if greater then 1 check speed not keys
		new Float:checkmove = get_pcvar_float(gPcvarCheckMove)
		switch(checkmove)
		{
			case 0.0: { /* 0 = no move check, do nothing */ }

			case 1.0: {
				if ( butnprs & gButtonsMove ) setVisible = true
			}

			default: {
				//Check speed of player against the checkmove cvar
				new Float:velocity[3]
				pev(id, pev_velocity, velocity)
				if ( vector_length(velocity) >= checkmove ) setVisible = true
			}
		}

		if ( setVisible ) {
			remInvisibility(id)
		}
		else {
			//new sysTime = get_systime()
			new Float:sysTime
                	global_get(glb_time, sysTime)
			new Float:delay = get_pcvar_float(gPcvarDelay)

			if ( gStillTime[id] < 0.0 ) {
				gStillTime[id] = sysTime
			}

			new alpha = get_pcvar_num(gPcvarAlpha)

			if ( sysTime - delay >= gStillTime[id] ) {
				if ( gIsInvisible[id] != 100 ) client_print(id, print_center, "[SH]%s : 100%s cloaked", gHeroName, "%")
				gIsInvisible[id] = 100
				setInvisibility(id, alpha)
			}
			else if ( sysTime > gStillTime[id] ) {
				new Float:prcnt = (sysTime - gStillTime[id]) / delay
				new rPercent = floatround(prcnt * 100)
				alpha = floatround( 255 - ((255 - alpha) * prcnt) )
				client_print(id, print_center, "[SH]%s : %d%s cloaked", gHeroName, rPercent, "%")
				gIsInvisible[id] = rPercent
				setInvisibility(id, alpha)
			}
		}
	}
}
//----------------------------------------------------------------------------------------------
public client_damage(attacker, victim)
{
	if ( !sh_is_active() || !gHasInvisibleMan[victim] ) return

	remInvisibility(victim)
}
//----------------------------------------------------------------------------------------------