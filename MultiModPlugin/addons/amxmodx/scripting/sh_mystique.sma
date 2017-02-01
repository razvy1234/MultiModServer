// MYSTIQUE! - BASED ON Vexds model changer

/* CVARS - copy and paste to shconfig.cfg

//Mystique
mystique_level 0
mystique_cooldown 0				//Cooldown time between morphs
mystique_maxtime 0				//Max time you can be morphed
mystique_toggle 1				//Should the key be a toggle or do they need to hold it down

*/

#include <superheromod>

// GLOBAL VARIABLES
new gHeroID
new const gHeroName[] = "Mystique"
new bool:gMorphed[SH_MAXSLOTS+1]
new const gMystiqueSound[] = "ambience/disgusting.wav"
new const CTSkins[4][10] = {"sas", "gsg9", "urban", "gign"}
new const TSkins[4][10] = {"arctic", "leet", "guerilla", "terror"}
new pCvarCooldown, pCvarMaxTime, pCvarToggle
new gMsgSync
//----------------------------------------------------------------------------------------------
public plugin_init()
{
	// Plugin Info
	register_plugin("SUPERHERO Mystique", SH_VERSION_STR, "{HOJ} Batman")

	// DO NOT EDIT THIS FILE TO CHANGE CVARS, USE THE SHCONFIG.CFG
	new pcvarLevel = register_cvar("mystique_level", "0")
	pCvarCooldown = register_cvar("mystique_cooldown", "0")
	pCvarMaxTime = register_cvar("mystique_maxtime", "0")
	pCvarToggle = register_cvar("mystique_toggle", "1")

	// FIRE THE EVENT TO CREATE THIS SUPERHERO!
	gHeroID = sh_create_hero(gHeroName, pcvarLevel)
	sh_set_hero_info(gHeroID, "Morph into Enemy", "Press the +power key to shapeshift into the Enemy")
	sh_set_hero_bind(gHeroID)

	gMsgSync = CreateHudSyncObj()
}
//----------------------------------------------------------------------------------------------
public plugin_precache()
{
	precache_sound(gMystiqueSound)
}
//----------------------------------------------------------------------------------------------
public sh_hero_init(id, heroID, mode)
{
	if ( gHeroID != heroID ) return

	if ( mode == SH_HERO_DROP && gMorphed[id] && is_user_connected(id) ) {
		mystique_unmorph(id)
	}

	sh_debug_message(id, 1, "%s %s", gHeroName, mode ? "ADDED" : "DROPPED")
}
//----------------------------------------------------------------------------------------------
public sh_client_spawn(id)
{
	gPlayerInCooldown[id] = false

	if ( gMorphed[id] ) {
		cs_reset_user_model(id)
		remove_task(id)
		gMorphed[id] = false
	}
}
//----------------------------------------------------------------------------------------------
public sh_hero_key(id, heroID, key)
{
	if ( gHeroID != heroID || !is_user_alive(id) ) return

	switch(key)
	{
		case SH_KEYDOWN: {
			// If in toggle mode change this to a keyup event
			if ( get_pcvar_num(pCvarToggle) && gMorphed[id] ) {
				mystique_unmorph(id)
				return
			}

			// Let them know they already used their ultimate if they have
			if ( gPlayerInCooldown[id] ) {
				sh_sound_deny(id)
				return
			}

			mystique_morph(id)
		}

		case SH_KEYUP: {
			// toggle mode - keyup doesn't do anything!
			if ( get_pcvar_num(pCvarToggle) ) return

			mystique_unmorph(id)
		}
	}
}
//----------------------------------------------------------------------------------------------
mystique_morph(id)
{
	if ( !sh_is_active() || !is_user_alive(id) || gMorphed[id] ) return

	new newSkin[10]
	new num = random_num(0, 3)
	switch(cs_get_user_team(id)) {
		case CS_TEAM_T: copy(newSkin, charsmax(newSkin), CTSkins[num])
		case CS_TEAM_CT: copy(newSkin, charsmax(newSkin), TSkins[num])
		default: return
	}

	cs_set_user_model(id, newSkin)

	gMorphed[id] = true
	mystique_sound(id)

	// Message
	set_hudmessage(200, 200, 0, -1.0, 0.45, 2, 0.02, 4.0, 0.01, 0.1, -1)
	ShowSyncHudMsg(id, gMsgSync, "%s - YOU NOW LOOK LIKE THE ENEMY", gHeroName)

	new Float:mystiqueMaxTime = get_pcvar_float(pCvarMaxTime)
	if ( mystiqueMaxTime > 0.0 ) {
		set_task(mystiqueMaxTime, "force_unmorph", id)
	}
}
//----------------------------------------------------------------------------------------------
mystique_unmorph(id)
{
	if ( !gMorphed[id] || !is_user_connected(id) ) return

	cs_reset_user_model(id)

	remove_task(id)
	gMorphed[id] = false

	if ( !is_user_alive(id) ) return

	mystique_sound(id)

	set_hudmessage(200, 200, 0, -1.0, 0.45, 2, 0.02, 4.0, 0.01, 0.1, -1)
	ShowSyncHudMsg(id, gMsgSync, "%s - RETURNED TO SELF", gHeroName)

	new Float:cooldown = get_pcvar_float(pCvarCooldown)
	if ( cooldown > 0.0 ) sh_set_cooldown(id, cooldown)
}
//----------------------------------------------------------------------------------------------
mystique_sound(id)
{
	emit_sound(id, CHAN_AUTO, gMystiqueSound, 0.2, ATTN_NORM, SND_STOP, PITCH_NORM)
	emit_sound(id, CHAN_AUTO, gMystiqueSound, 0.2, ATTN_NORM, 0, PITCH_NORM)
}
//----------------------------------------------------------------------------------------------
public sh_client_death(victim)
{
	mystique_unmorph(victim)
}
//----------------------------------------------------------------------------------------------
public force_unmorph(id)
{
	sh_chat_message(id, gHeroID, "Your shapeshifting power has worn off")

	mystique_unmorph(id)
}
//----------------------------------------------------------------------------------------------
public client_connect(id)
{
	gMorphed[id] = false
}
//----------------------------------------------------------------------------------------------