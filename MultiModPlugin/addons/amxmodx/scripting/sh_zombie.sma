// Zombie - Revive and can eat victims skull 
//credits to yang's majinbuu hero tho it only supported amxx
/* CVARS - copy and paste to shconfig.cfg
	
//Zombie
zombie_level 0
zombie_skullhealth 50            //hp gained from eating skull of victims
zombie_respawnpct 50			//Percent chance 0-100 of respawning on each death (default 50)
	
*/
	
#include <amxmod>
#include <superheromod>
#include <Vexd_Utilities>
	 
	
// GLOBAL VARIABLES
new gHeroName[]="Zombie"
new bool:gHasZombiePower[SH_MAXSLOTS+1]
new bool:gmorphed[SH_MAXSLOTS+1]
new gUserTeam[SH_MAXSLOTS+1]
new bool:gBetweenRounds
new Smoke	 
//----------------------------------------------------------------------------------------------
public plugin_init()
{
		// Plugin Info
		register_plugin("Zombie","1.0","Random1")
	
		// DO NOT EDIT THIS FILE TO CHANGE CVARS, USE THE SHCONFIG.CFG
		register_cvar("zombie_level", "0" )
		register_cvar("zombie_skullhealth", "50")
		register_cvar("zombie_respawnpct", "50")
		
		// FIRE THE EVENT TO CREATE THIS SUPERHERO!
		shCreateHero(gHeroName, "Zombie", "Random chance of revive/can eat skull of victims", false, "zombie_level" )
	
		// REGISTER EVENTS THIS HERO WILL RESPOND TO! (AND SERVER COMMANDS)
		// INIT
		register_srvcmd("zombie_init", "zombie_init")
		shRegHeroInit(gHeroName, "zombie_init")
	
		register_event("ResetHUD", "newRound","b")
		register_event("DeathMsg","zombie_death","a")
		register_event("DeathMsg","deathevent","a")
		register_logevent("round_end", 2, "1=Round_End")
		register_logevent("round_end", 2, "1&Restart_Round_")
		
}	 
//----------------------------------------------------------------------------------------------
public zombie_init()
{
		// First Argument is an id
		new temp[6]
		read_argv(1,temp,5)
		new id=str_to_num(temp)
	
		// 2nd Argument is 0 or 1 depending on whether the id has GreenLantern
		read_argv(2,temp,5)
		new hasPowers = str_to_num(temp)
	
		gHasZombiePower[id] = (hasPowers!=0)
		
		if ( hasPowers ) {
		zombie_morph(id)
		}
	
		//This gets run if they had the power but don't anymore
		else if ( gmorphed[id] ) {
		zombie_endmode(id)
		zombie_unmorph(id)
		}		
}	
//---------------------------------------------------------------------------------------------- 
public remove_skull()
{
		#if defined AMXX_VERSION
		new skull = find_ent_by_class(-1, "skull")
		while(skull) {
			remove_entity(skull)
			skull = find_ent_by_class(skull, "skull")
		}
		#else
		new skull = find_entity(-1, "skull")
		if (is_entity(skull)){
		remove_entity(skull)
		}
		#endif
}
//----------------------------------------------------------------------------------------------	
public newRound(id)
{
	if ( gHasZombiePower[id] && is_user_alive(id) && shModActive() ) {
	zombie_morph(id)
	remove_skull()
	}
			
	gBetweenRounds = false		
}	
//----------------------------------------------------------------------------------------------
public zombie_endmode(id)
{
	if ( !is_user_connected(id) ) return

	zombie_unmorph(id)
	
}
//----------------------------------------------------------------------------------------------
public deathevent()
{
		new killer = read_data(1)
		new victim = read_data(2)
		if ( killer != victim )
		{
			if ( gHasZombiePower[killer] && is_user_alive(killer) )
			{
				createskull(victim)
				new aimvec[3]
				get_user_origin(victim, aimvec)
				message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
				write_byte(23)
				write_coord(aimvec[0])
				write_coord(aimvec[1])
				write_coord(aimvec[2])
				write_short(Smoke)
				write_byte(001)
				write_byte(65)
				write_byte(200)
				message_end()
				aimvec[2] -= 100
				set_user_origin(victim, aimvec)
	
			}
		}
		return PLUGIN_HANDLED
}	
//----------------------------------------------------------------------------------------------
public createskull(victim)
{
		new Float:vAim[3], Float:vOrigin[3]
		entity_get_vector(victim, EV_VEC_origin, vOrigin)
		VelocityByAim(victim, random_num(2, 4), vAim)
	
		vOrigin[0] += vAim[0]
		vOrigin[1] += vAim[1]
		vOrigin[2] += 30.0
	
		new skull = create_entity("info_target")
		entity_set_string(skull, EV_SZ_classname, "skull")
		entity_set_model(skull, "models/shmod/skull.mdl")	
		entity_set_size(skull, Float:{-2.5, -2.5, -1.5}, Float:{2.5, 2.5, 1.5})
		entity_set_int(skull, EV_INT_solid, 2)
		entity_set_int(skull, EV_INT_movetype, 6)
		entity_set_vector(skull, EV_VEC_origin, vOrigin)
}	
//----------------------------------------------------------------------------------------------
public plugin_precache() {
		precache_model("models/shmod/skull.mdl")
		Smoke = precache_model("sprites/wall_puff4.spr")
		precache_model("models/player/cszombie/cszombie.mdl")
}	
//----------------------------------------------------------------------------------------------
public zombie_morph(id)
{
	if ( gmorphed[id] || !is_user_alive(id) ) return

	#if defined AMXX_VERSION
	cs_set_user_model(id, "cszombie")
	#else
	CS_SetModel(id, "cszombie")
	#endif
	
	// Message
	set_hudmessage(50, 205, 50, -1.0, 0.40, 2, 0.02, 4.0, 0.01, 0.1, 7)
	show_hudmessage(id, "You are now a zombie that can revive and eat skulls")

	gmorphed[id] = true
}
//----------------------------------------------------------------------------------------------
public zombie_unmorph(id)
{
	if ( gmorphed[id] ) {
		// Message
		set_hudmessage(50, 205, 50, -1.0, 0.40, 2, 0.02, 4.0, 0.01, 0.1, 7)
		show_hudmessage(id, "Your a normal person now")

		#if defined AMXX_VERSION
		cs_reset_user_model(id)
		#else
		CS_ClearModel(id)
		#endif
			
		gmorphed[id] = false

		}
}
//----------------------------------------------------------------------------------------------
public zombie_death()
{
	new id = read_data(2)

	if ( gBetweenRounds ) return
	if ( !is_user_connected(id) || !gHasZombiePower[id] ) return

	new randNum = random_num(0, 100)
	new pctChance = get_cvar_num("zombie_respawnpct")
	if ( pctChance < randNum ) return

	gUserTeam[id] = get_user_team(id)

	// Look for self to raise from dead
	if ( !is_user_alive(id) ) {
		// Zombie will raise self from dead
		new parm[1]
		parm[0] = id
		// Respawn him faster then Zues, let this power be used before Zues's
		// never set higher then 1.9 or lower then 0.5
		set_task(0.8, "zombie_respawn", 0, parm, 1)
	}
}
//----------------------------------------------------------------------------------------------
public zombie_respawn(parm[])
{
	new id = parm[0]

	if ( !is_user_connected(id) || is_user_alive(id) ) return
	if ( gBetweenRounds ) return
	if ( gUserTeam[id] != get_user_team(id) ) return //prevents respawning spectators

	emit_sound(id, CHAN_STATIC, "ambience/port_suckin1.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)

	// Double spawn prevents the no HUD glitch
	user_spawn(id)
	user_spawn(id)

	set_task(1.0, "zombie_teamcheck", 0, parm, 1)
}
//----------------------------------------------------------------------------------------------
public zombie_teamcheck(parm[])
{
	new id = parm[0]

	if ( gUserTeam[id] != get_user_team(id) ) {
		client_print(id, print_chat, "[SH](Zombie) You changed teams and can't revive as a zombie instead u die")

		user_kill(id, 1)

		// Stop Zombie from respawning until round ends
		remove_task(177+id)
	}
}
//----------------------------------------------------------------------------------------------
public round_end()
{
	if ( !shModActive() ) return

	gBetweenRounds = true

	// Reset the cooldown on round end, to start fresh for a new round
	for ( new id = 1; id <= SH_MAXSLOTS; id++ ) {
		if ( gHasZombiePower[id] ) {
			remove_task(177+id)
		}
	}
}
//----------------------------------------------------------------------------------------------
public client_disconnect(id)
{
	// stupid check but lets see
	if ( id <= 0 || id > SH_MAXSLOTS ) return

	// Yeah don't want any left over residuals
	remove_task(id)

	gHasZombiePower[id] = false
}
//----------------------------------------------------------------------------------------------
public client_connect(id)
{
	gHasZombiePower[id] = false
}
//----------------------------------------------------------------------------------------------
#if defined AMXX_VERSION
public pfn_touch(ptr, ptd) 
{
	if(!is_valid_ent(ptd) || !is_valid_ent(ptr))
		return PLUGIN_CONTINUE
		
	if(!is_user_connected(ptd) || !is_user_alive(ptd))
		return PLUGIN_CONTINUE
	
	if( !gHasZombiePower[ptd] )
		return PLUGIN_CONTINUE

	new classname[32]
	entity_get_string(ptr, EV_SZ_classname, classname, 31)
	if(equal(classname, "skull")) 
	{
			new gOrigHealth = get_user_health(ptd)
			new health = gOrigHealth + get_cvar_num("zombie_skullhealth")
			set_user_health(ptd, health)
			remove_entity(ptr)
	}
	return PLUGIN_CONTINUE
}
#else
public entity_touch(entity1, entity2) 
	{
		if(!is_entity(entity2) || !is_entity(entity1))
			return PLUGIN_CONTINUE
			
		if(!is_user_connected(entity2) || !is_user_alive(entity2))
			return PLUGIN_CONTINUE
		
		if( !gHasZombiePower[entity2] )
			return PLUGIN_CONTINUE
	
		new classname[32]
		entity_get_string(entity1, EV_SZ_classname, classname, 31)
		if(equal(classname, "skull")) 
		{
				new gOrigHealth = get_user_health(entity2)
				new health = gOrigHealth + get_cvar_num("zombie_skullhealth")
				set_user_health(entity2, health)
				remove_entity(entity1)
		}
		return PLUGIN_CONTINUE
}
#endif
//----------------------------------------------------------------------------------------------