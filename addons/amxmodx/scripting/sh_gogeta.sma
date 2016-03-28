//GOGETA! - from Dragonball Z/GT. Fusion of Goku and Vegeta using the fusion dance, with Goku being more expressed.
// He was only seen at Super Sajin Levels 2 and 4.

/*

//Gogeta
gogeta_level 0
gogeta_ss2_cost 250			//Choice 1 Armor Cost of each Kamehameha fired
gogeta_ss2_maxap 500		//Choice 1 Max Armor given and max he regens to
gogeta_ss2_regen 25			//Choice 1 Amount of Armor regen per seceond
gogeta_ss2_maxdmg 50		//Choice 1 Max Damage from Kamehameha
gogeta_ss2_radius 175		//Choice 1 Max Radius of Kamehameha
gogeta_ss4_cost 500			//Choice 2 Armor Cost of each Kamehameha fired
gogeta_ss4_maxap 500		//Choice 2 Max Armor given and max he regens to
gogeta_ss4_regen 15			//Choice 2 Amount of Armor regen per seceond
gogeta_ss4_maxdmg 90		//Choice 2 Max Damage from Kamehameha
gogeta_ss4_radius 300		//Choice 2 Max Radius of Kamehameha
gogeta_blast_decals 1		//Show the burn decals on the walls (1=yes 0=no)
gogeta_speed 500			//How fast he is with all weapons (defalut=500)

*/

#include <amxmod>
#include <superheromod>

// GLOBAL VARIABLES
new gHeroName[]="Gogeta"
new gHasGogetaPower[SH_MAXSLOTS+1]
new gLastWeapon[SH_MAXSLOTS+1]
new bool:shownmenu[SH_MAXSLOTS+1]
new gPowerChoice[SH_MAXSLOTS+1]
new gWaveCost[SH_MAXSLOTS+1]
new gRegen[SH_MAXSLOTS+1]
new gDmgRadius[SH_MAXSLOTS+1]
new gMaxDmg[SH_MAXSLOTS+1]
new gMaxArmor[SH_MAXSLOTS+1]
new Beam2, Beam4, Explosion2, Explosion4, Smoke
new gGogetaTaskID

static const burn_decal[3] = {28, 29, 30}
static const burn_decal_big[3] = {46, 47, 48}
//----------------------------------------------------------------------------------------------
public plugin_init()
{
	// Plugin Info
	register_plugin("SUPERHERO Gogeta", "1.0", "P-DiL / vittu")

	// DO NOT EDIT THIS FILE TO CHANGE CVARS, USE THE SHCONFIG.CFG
	register_cvar("gogeta_level", "0")
	register_cvar("gogeta_ss2_cost", "250")
	register_cvar("gogeta_ss2_maxap", "500")
	register_cvar("gogeta_ss2_regen", "25")
	register_cvar("gogeta_ss2_maxdmg", "50")
	register_cvar("gogeta_ss2_radius", "175")
	register_cvar("gogeta_ss4_cost", "500")
	register_cvar("gogeta_ss4_maxap", "500")
	register_cvar("gogeta_ss4_regen", "15")
	register_cvar("gogeta_ss4_maxdmg", "90")
	register_cvar("gogeta_ss4_radius", "300")
	register_cvar("gogeta_blast_decals", "1")
	register_cvar("gogeta_speed", "500")

	// FIRE THE EVENT TO CREATE THIS SUPERHERO!
	shCreateHero(gHeroName, "Super Saiyan Menu", "Your Choice of a Gogeta Kamehameha Wave on keydown. Also Regenerate your KI(Armor) and get extra speed.", true, "gogeta_level")

	// REGISTER EVENTS THIS HERO WILL RESPOND TO! (AND SERVER COMMANDS)
	// INIT
	register_srvcmd("gogeta_init", "gogeta_init")
	shRegHeroInit(gHeroName, "gogeta_init")

	// KEY DOWN
	register_srvcmd("gogeta_kd", "gogeta_kd")
	shRegKeyDown(gHeroName, "gogeta_kd")

	// DEATH
	register_event("DeathMsg", "gogeta_death", "a")

	// MENU
	register_menucmd(register_menuid("Super Saiyan Level Menu"), 1023, "main_menu_action")

	// Let Server know about Goten's Variables
	shSetMaxSpeed( gHeroName, "gogeta_speed", "[0]")

	// Set a random number to the looping task so it can be removed without conflict
	gGogetaTaskID = random_num(81818, 100000)
}
//----------------------------------------------------------------------------------------------
public plugin_precache()
{
	Beam2 = precache_model("sprites/shmod/gogeta_beam_red.spr")
	Beam4 = precache_model("sprites/shmod/gogeta_beam_blue.spr")
	Explosion2 = precache_model("sprites/shmod/kamehameha_exp_red.spr")
	Explosion4 = precache_model("sprites/shmod/kamehameha_exp_blue.spr")
	Smoke = precache_model("sprites/wall_puff4.spr")
	precache_sound("shmod/gogeta_powerup1.wav")
	precache_sound("shmod/gogeta_powerup2.wav")
	precache_sound("shmod/gogeta_10xkamehameha.wav")
	precache_sound("shmod/gogeta_bigbang.wav")
}
//----------------------------------------------------------------------------------------------
public gogeta_init()
{
	// First Argument is an id
	new temp[6]
	read_argv(1,temp,5)
	new id=str_to_num(temp)

	// 2nd Argument is 0 or 1 depending on whether the id has Gogeta powers
	read_argv(2,temp,5)
	new hasPowers = str_to_num(temp)

	gHasGogetaPower[id] = (hasPowers != 0)

	if ( gHasGogetaPower[id] ) {
		shownmenu[id] = false
	}
	else {
		shRemSpeedPower(id)
		remove_task(id+gGogetaTaskID)
	}
}
//----------------------------------------------------------------------------------------------
// RESPOND TO KEYDOWN
public gogeta_kd()
{
	// First Argument is an id with Gogeta Powers!
	new temp[6]
	read_argv(1,temp,5)
	new id=str_to_num(temp)

	if ( !is_user_alive(id) || !gHasGogetaPower[id] ) return

	if ( !shownmenu[id] ){
		show_main_menu(id)
		return
	}

	if ( !hasRoundStarted() ) return

	new userArmor = get_user_armor(id)

	if(userArmor < gWaveCost[id]) {
		client_print(id,print_chat,"[SH](%s) Kamehameha cost %d KI (Armor)", gHeroName, gWaveCost[id])
		playSoundDenySelect(id)
		return
	}

	// Use armor as cost for power
	set_user_armor( id, userArmor - gWaveCost[id] )

	// Remember this weapon...
	new clip, ammo, weaponID = get_user_weapon(id,clip,ammo)
	gLastWeapon[id] = weaponID

	// Make them switch to knife so they can not shoot at same time
	engclient_cmd(id,"weapon_knife")

	// Play attack sound according to choice
	if( gPowerChoice[id] == 1) {
		emit_sound(id, CHAN_STATIC, "shmod/gogeta_10xkamehameha.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	else {
		emit_sound(id, CHAN_STATIC, "shmod/gogeta_bigbang.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
	}

	fire_wave(id)

	// Fake a keyup to switch weapon back, since keyup cancels the menu 
	set_task( 0.1, "switch_back", id)
}
//----------------------------------------------------------------------------------------------
public switch_back(id)
{
	// Switch back to previous weapon...
	if ( gLastWeapon[id] != CSW_KNIFE ) shSwitchWeaponID( id, gLastWeapon[id] )
}
//----------------------------------------------------------------------------------------------
public fire_wave(id)
{
	new aimvec[3]
	new FFOn = get_cvar_num("mp_friendlyfire")

	new Float:dRatio, damage, distanceBetween

	if( !is_user_alive(id) ) return

	// Make sure still on knife
	new clip,ammo,weaponID = get_user_weapon(id,clip,ammo)
	if ( weaponID != CSW_KNIFE ) engclient_cmd(id,"weapon_knife")

	get_user_origin(id, aimvec, 3)

	waveEffects(id, aimvec)

	for(new vic = 1; vic <= SH_MAXSLOTS; vic++) {
		if( is_user_alive(vic) && ( FFOn || vic==id || get_user_team(id) != get_user_team(vic) ) ) {
			new origin[3]
			get_user_origin(vic, origin)
			distanceBetween = get_distance(aimvec, origin)
			if( distanceBetween < gDmgRadius[id] ) {
				dRatio = float(distanceBetween) / float(gDmgRadius[id])
				damage = gMaxDmg[id] - floatround( gMaxDmg[id] * dRatio)
				if( vic == id ) damage = floatround( damage / 2.0 ) //lessen damage taken by self
				if( gPowerChoice[id] == 1 ) shExtraDamage(vic, id, damage, "10x Kamehameha")
				else shExtraDamage(vic, id, damage, "Big Bang Kamehameha")
				//to test raidus to see how much damage is caused, uncomment below
				//client_print(id, print_chat, "damage caused: %d", damage)
			} // distance
		} // alive
	} // loop
}
//----------------------------------------------------------------------------------------------
public waveEffects(id, aimvec[3])
{
	new decal_id, beamWidth2, beamWidth4

	//Change sprite size according to blast radius
	new blastSize = floatround( gDmgRadius[id] / 12.0 )

	//Change burn decal and beam size according to blast size
	if (blastSize <= 18) { //radis ~< 216
		decal_id = burn_decal[random_num(0,2)]
		beamWidth2 = 40
		beamWidth4 = 55
	}
	else {
		decal_id = burn_decal_big[random_num(0,2)]
		beamWidth2 = 50
		beamWidth4 = 65
	}

	//Beam
	message_begin( MSG_BROADCAST, SVC_TEMPENTITY )
	write_byte(1)			//TE_BEAMENTPOINTS
	write_short(id)		//ent
	write_coord(aimvec[0])	//position
	write_coord(aimvec[1])
	write_coord(aimvec[2])
	if( gPowerChoice[id] == 1 ) write_short(Beam2)	//model
	else write_short(Beam4)	//model
	write_byte(0)			//start frame
	write_byte(10)			// framerate
	write_byte(5)			// life
	if( gPowerChoice[id] == 1 ) write_byte(beamWidth2)	// width
	else write_byte(beamWidth4)
	write_byte(0)			// noise
	write_byte(255)		// red (rgb color)
	write_byte(255)		// green (rgb color)
	write_byte(255)		// blue (rgb color)
	write_byte(255)		// brightness
	write_byte(60)			// speed
	message_end()

	//Explosion Sprite
	message_begin( MSG_BROADCAST, SVC_TEMPENTITY )
	write_byte(23)			//TE_GLOWSPRITE
	write_coord(aimvec[0])	//position
	write_coord(aimvec[1])
	write_coord(aimvec[2])
	if( gPowerChoice[id] == 1 ) write_short(Explosion2)	// model
	else  write_short(Explosion4)	// model
	write_byte(001)		// life 0.x sec
	write_byte(blastSize)	// size
	write_byte(255)		// brightness
	message_end()

	//Explosion (smoke, sound/effects)
	message_begin( MSG_BROADCAST, SVC_TEMPENTITY )
	write_byte(3)			//TE_EXPLOSION
	write_coord(aimvec[0])	//pos
	write_coord(aimvec[1])
	write_coord(aimvec[2])
	write_short(Smoke)		// model
	write_byte(blastSize+5)	// scale in 0.1's
	write_byte(20)			// framerate
	write_byte(10)			// flags
	message_end()

	//Burn Decals
	if(get_cvar_num("goten_blast_decals") == 1) {
		message_begin( MSG_BROADCAST, SVC_TEMPENTITY )
		write_byte(109)		//TE_GUNSHOTDECAL
		write_coord(aimvec[0])	//pos
		write_coord(aimvec[1])
		write_coord(aimvec[2])
		write_short(0)			//?
		write_byte(decal_id)	//decal
		message_end()
	}
}
//----------------------------------------------------------------------------------------------
public show_main_menu(id)
{
	new menu_body[320]
	new n = 0
	new len = 319

	if(!gHasGogetaPower[id] || !is_user_alive(id)) return

	n += format( menu_body[n],len-n,"\ySuper Saiyan Level Menu^n\w^n")
	n += format( menu_body[n],len-n,"1. Super Saiyan 2 - 10x Kamehameha^n\r     (Max: %dAP | Cost: %dAP | Regen: %dAP/s)\w^n^n", get_cvar_num("gogeta_ss2_maxap"), get_cvar_num("gogeta_ss2_cost"), get_cvar_num("gogeta_ss2_regen"))
	n += format( menu_body[n],len-n,"2. Super Saiyan 4 - Big Bang Kamehameha^n\r     (Max: %dAP | Cost: %dAP | Regen: %dAP/s)^n^n", get_cvar_num("gogeta_ss4_maxap"), get_cvar_num("gogeta_ss4_cost"), get_cvar_num("gogeta_ss4_regen"))
	n += format( menu_body[n],len-n,"\w0. Exit")

	new keys = (1<<0)|(1<<1)|(1<<9)

	show_menu(id,keys,menu_body)
}
//----------------------------------------------------------------------------------------------
public main_menu_action(id,key)
{
	shownmenu[id] = true
	key++

	if(!gHasGogetaPower[id] || !is_user_alive(id)) {
		shownmenu[id] = false
		return
	}

	switch(key){
		case 1: {
			gPowerChoice[id] = 1
			gogeta_choice(id)
		}
		case 2: {
			gPowerChoice[id] = 2
			gogeta_choice(id)
		}
		case 10: {
			shownmenu[id] = false
		}
		default: show_main_menu(id)
	}
}
//----------------------------------------------------------------------------------------------
public gogeta_choice(id)
{
	new userArmor = get_user_armor(id)

	if (gPowerChoice[id] == 1) {
		set_hudmessage(255, 40, 40, -1.0, 0.25, 1, 6.0, 4.0, 0.1, 0.1, 77)
		show_hudmessage(id, "Gogeta - Super Saiyan 2 FUSION!!!")
		emit_sound(id, CHAN_STATIC, "shmod/gogeta_powerup1.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)

		// Set Variables
		gDmgRadius[id] = get_cvar_num("gogeta_ss2_radius")
		gMaxDmg[id] = get_cvar_num("gogeta_ss2_maxdmg")
		gRegen[id] = get_cvar_num("gogeta_ss2_regen")
		gWaveCost[id] = get_cvar_num("gogeta_ss2_cost")
		gMaxArmor[id] = get_cvar_num("gogeta_ss2_maxap")

		//Give him armor
		if(userArmor < gMaxArmor[id]){
			//Give the armor item first so CS knows the player has armor
			give_item(id, "item_assaultsuit")
			
			set_user_armor(id, gMaxArmor[id])
		}
	}

	if (gPowerChoice[id] == 2) {
		set_hudmessage(0, 100, 255, -1.0, 0.25, 1, 6.0, 4.0, 0.1, 0.1, 77)
		show_hudmessage(id, "Gogeta - Super Saiyan 4 FUSION!!!")
		emit_sound(id, CHAN_STATIC, "shmod/gogeta_powerup2.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)

		// Set Variables
		gDmgRadius[id] = get_cvar_num("gogeta_ss4_radius")
		gMaxDmg[id] = get_cvar_num("gogeta_ss4_maxdmg")
		gRegen[id] = get_cvar_num("gogeta_ss4_regen")
		gWaveCost[id] = get_cvar_num("gogeta_ss4_cost")
		gMaxArmor[id] = get_cvar_num("gogeta_ss4_maxap")

		//Give him armor
		if(userArmor < gMaxArmor[id]){
			//Give the armor item first so CS knows the player has armor
			give_item(id, "item_assaultsuit")
			
			set_user_armor(id, gMaxArmor[id])
		}
	}

	// Set AP regen loop
	set_task( 1.0, "gogeta_loop", id+gGogetaTaskID, "", 0, "b")
}
//----------------------------------------------------------------------------------------------
public gogeta_loop(id)
{
	id -= gGogetaTaskID

	if ( !hasRoundStarted() ) return

	if (!is_user_connected(id)) {
		// Don't want any left over residuals
		remove_task(id+gGogetaTaskID)
		return
	}

	// Increase armor for this guy
	new userArmor = get_user_armor(id)
	if ( userArmor < gMaxArmor[id] ) {
		set_user_armor(id, userArmor+gRegen[id] )
		return
	}
}
//----------------------------------------------------------------------------------------------
public gogeta_death()
{
	new id = read_data(2)

	if(!gHasGogetaPower[id]) return

	// Reset All Varibles only on Death
	shownmenu[id] = false
	gPowerChoice[id] = 0
	gDmgRadius[id] = 0
	gMaxDmg[id] = 0
	gRegen[id] = 0
	gWaveCost[id] = 0
	gMaxArmor[id] = 0
	remove_task(id+gGogetaTaskID)
}
//----------------------------------------------------------------------------------------------