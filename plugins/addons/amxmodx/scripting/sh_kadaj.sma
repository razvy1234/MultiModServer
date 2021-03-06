// Kadaj

/* CVARS - copy and paste to shconfig.cfg

//Kadaj
kadaj_level 0			//What level Kadaj is available
kadaj_maxjumps 5		//How many times he can do bad ass jumps
kadaj_gravity 0.70		//how high can he jump - 1.0 = 100% gravity
kadaj_speed 385			//How fast Kadaj can run
kadaj_cooldown 30		//How long till he can transform again
kadaj_fftime 7			//How long he can control his power (recomend not going above 20 sec. as the wav is only 20 sec.)
kadaj_ultspeed 800		//How fast he can run in his true form
kadaj_ulthealth 250		//Health when he transforms
kadaj_weakhealth 75		//Health when he gets weak and loses his transformation

*/

#include <amxmod>
#include <superheromod>
#include <Vexd_Utilities>
#include <fakemeta>

#if defined AMX98
        #include <xtrafun>
        #define FL_ONGROUND (1<<9)
#endif
        
#define DOF 1  //Forward
#define DOB 2  //Backward
#define DOR 3  //Right
#define DOL 4  //Left
#define TMINUS 0.5  //Time to activate fly

// VARIABLES
new gHeroName[]="Kadaj"
new gHaskadajPower[SH_MAXSLOTS+1]
new g_kadajTimer[SH_MAXSLOTS+1]
new bool:gCanJump[SH_MAXSLOTS+1]
new jumpnum[SH_MAXSLOTS+1]
new bool:gCanJumpdt[SH_MAXSLOTS+1]
new bool:gHasJumped[SH_MAXSLOTS+1]	
new bool:gCanForward[SH_MAXSLOTS+1]
new bool:gCanBack[SH_MAXSLOTS+1]
new bool:gCanRight[SH_MAXSLOTS+1]
new bool:gCanLeft[SH_MAXSLOTS+1]
new bool:gCanDo[SH_MAXSLOTS+1]
new lasthit[SH_MAXSLOTS+1]

#define TASKID 6789524
//----------------------------------------------------------------------------------------------
public plugin_init()
{
	// Plugin Info
	register_plugin("SUPERHERO Kadaj","1.1","1sh0t2killz")

	// DO NOT EDIT THIS FILE TO CHANGE CVARS, USE THE SHCONFIG.CFG
	register_cvar("kadaj_level", "0")
	register_cvar("kadaj_maxjumps", "5")
	register_cvar("kadaj_gravity", "0.70" )
	register_cvar("kadaj_speed", "385" )
	register_cvar("kadaj_ultspeed", "900" )
	register_cvar("kadaj_cooldown", "30" )
	register_cvar("kadaj_fftime", "11" )
	register_cvar("kadaj_ulthealth", "250" )
	register_cvar("kadaj_weakhealth", "75" )

	// FIRE THE EVENT TO CREATE THIS SUPERHERO!
	shCreateHero(gHeroName, "Final Fantasy", "Kadaj, the body of thought of sephiroth!", true, "kadaj_level" )

	// REGISTER EVENTS THIS HERO WILL RESPOND TO! (AND SERVER COMMANDS)
	// INIT
	register_srvcmd("kadaj_init", "kadaj_init")
	shRegHeroInit(gHeroName, "kadaj_init")
	// KEY DOWN
	register_srvcmd("kadaj_kd", "kadaj_kd")
	shRegKeyDown(gHeroName, "kadaj_kd")
	// LOOP
	register_srvcmd("kadaj_loop", "kadaj_loop")
	//shRegLoop1P0(gHeroName, "kadaj_loop", "ac" ) // Alive kadajHeros="ac"
	set_task(1.0,"kadaj_loop",0,"",0,"b") //forever loop
	
	// New Round
	register_event("ResetHUD","newRound","b")

	// Prethink and postthink
	register_forward(FM_PlayerPreThink, "kadaj_dtpre")
	register_forward(FM_PlayerPostThink, "kadaj_dtpost")

	// Speeds
	shSetMaxSpeed(gHeroName, "kadaj_ultspeed", "[0]" )
}
//----------------------------------------------------------------------------------------------
public plugin_precache(){
	precache_sound("shmod/sephiroth.wav")
}
//----------------------------------------------------------------------------------------------
public kadaj_init()
{
	shSetMinGravity(gHeroName, "kadaj_gravity" )

	// First Argument is an id
	new temp[6]
	read_argv(1,temp,5)
	new id=str_to_num(temp)

	// 2nd Argument is 0 or 1 depending on whether the id has kadaj
	read_argv(2,temp,5)
	new hasPowers=str_to_num(temp)

	gHaskadajPower[id]=(hasPowers!=0)

	if (gHaskadajPower[id]) {
		jumpnum[id] = get_cvar_num("kadaj_maxjumps")
	}
}
//----------------------------------------------------------------------------------------------
public newRound(id)
{
	jumpnum[id] = get_cvar_num("kadaj_maxjumps")
	gPlayerUltimateUsed[id]=false
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
// RESPOND TO KEYDOWN
public kadaj_kd()
{
	new temp[6]

	// First Argument is an id with kadaj Powers!
	read_argv(1,temp,5)
	new id=str_to_num(temp)

	if ( !is_user_alive(id) ) return PLUGIN_HANDLED

	// Let them know they already used their ultimate if they have
	if ( gPlayerUltimateUsed[id] )
	{
		playSoundDenySelect(id)
		//emit_sound(id, CHAN_STATIC, "shmod/sephiroth.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)
		return PLUGIN_HANDLED
	}

	// Make sure they're not in the middle of Final Fantasy Mode already
	if ( g_kadajTimer[id]>0 ) return PLUGIN_HANDLED

	g_kadajTimer[id]=get_cvar_num("kadaj_fftime")+1
	kadaj_ffmode(id)
	ultimateTimer(id, get_cvar_num("kadaj_cooldown") * 1.0)

	emit_sound(id, CHAN_STATIC, "shmod/sephiroth.wav", 1.0, ATTN_NORM, 0, PITCH_NORM)

	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public kadaj_loop()
{
	for ( new id=1; id<=SH_MAXSLOTS; id++ )
	{
		if ( gHaskadajPower[id] && is_user_alive(id)  )
		{
			if ( g_kadajTimer[id]>0 )
			{
				g_kadajTimer[id]--
				new message[128]
				format(message, 127, "%d seconds left of Ultimant Mode", g_kadajTimer[id] )
				set_user_rendering(id,kRenderFxGlowShell,255,255,0,100,3)
				set_hudmessage(0,255,0,-1.0,0.3,0,1.0,1.0,0.0,0.0,4)
				show_hudmessage( id, message)
				set_user_maxspeed(id,900.0)
				client_cmd(id,"cl_sidespeed %i",get_cvar_num("kadaj_ultspeed"))
				client_cmd(id,"cl_forwardspeed %i",get_cvar_num("kadaj_ultspeed"))

				}
				else
				{

				if ( g_kadajTimer[id] == 0 )
				{
					g_kadajTimer[id]--
					kadaj_end(id)
				}
			}
		}
	}
}
//----------------------------------------------------------------------------------------------
public kadaj_end(id)
{
	client_print(id,print_chat,"[Kadaj] Your powers are drained and you feel weak")
	set_user_maxspeed(id,320.0)
	set_user_rendering(id,kRenderFxGlowShell,0,0,0,kRenderNormal,255)
	set_user_health(id,get_cvar_num("kadaj_weakhealth"))
	shSetMaxSpeed(gHeroName, "kadaj_speed", "[0]" )
	// Stop the music
	new sndStop=(1<<5)
	emit_sound(id, CHAN_STATIC, "shmod/sephiroth.wav", 1.0, ATTN_NORM, sndStop, PITCH_NORM)
}
//----------------------------------------------------------------------------------------------
public kadaj_ffmode(id)
{
	if ( gHaskadajPower[id] && is_user_alive(id) )
	{
		// Learn from your mistakes
		//shSetMaxSpeed(gHeroName, "kadaj_ultspeed", "[0]" )
		//set_user_maxspeed(id,900.0)
		set_user_health(id,get_cvar_num("kadaj_ulthealth"))
		new message[128]
		format(message, 127, "Entered kadajs Ultimant Mode" )
		set_hudmessage(0,255,0,-1.0,0.3,0,0.25,1.0,0.0,0.0,4)
		show_hudmessage(id, message)
	}
}
//----------------------------------------------------------------------------------------------
public client_PreThink(id)
{
	if (!gHaskadajPower[id] || !shModActive()) return PLUGIN_HANDLED
	
	new newbutton = Entvars_Get_Int(id,EV_INT_button)
	new oldbutton = Entvars_Get_Int(id,EV_INT_oldbuttons)
	new flags = Entvars_Get_Int(id,EV_INT_flags)

	if(newbutton&IN_JUMP && !(flags&FL_ONGROUND) && !(oldbutton&IN_JUMP)) {
	      if(jumpnum[id] > 0) {
		      gCanJump[id] = true
		      return PLUGIN_CONTINUE
	      }
	}
	if(newbutton&IN_JUMP && flags&FL_ONGROUND) {
	      jumpnum[id] = get_cvar_num("kadaj_maxjumps")
	      return PLUGIN_CONTINUE
	}
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------	
public client_PostThink(id)
{
	if(gCanJump[id]) {
	     new Float:velocity[3]	
	     Entvars_Get_Vector(id,EV_VEC_velocity,velocity)
	     velocity[2] = velocity[2] + 285.0
	     Entvars_Set_Vector(id,EV_VEC_velocity,velocity)
	     Entvars_Set_Int(id, EV_INT_gaitsequence, 6)  //Just a jump animation
	     gCanJump[id] = false
	     jumpnum[id]--
	     return PLUGIN_CONTINUE
	}
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public kadaj_dtpre(id)
{
	if (!gHaskadajPower[id] || !shModActive() || !hasRoundStarted()) return PLUGIN_HANDLED
	
	new newbutton = Entvars_Get_Int(id,EV_INT_button)
	new oldbutton = Entvars_Get_Int(id,EV_INT_oldbuttons)
	new flags = Entvars_Get_Int(id,EV_INT_flags)

	//Double Jump
	if((newbutton&IN_JUMP) && !(flags&FL_ONGROUND) && !(oldbutton&IN_JUMP)) {
		if(!gHasJumped[id]) {
			gCanJumpdt[id] = true
			gHasJumped[id] = true
		}
	}
	if((newbutton&IN_JUMP) && (flags&FL_ONGROUND)) {
		gHasJumped[id] = false
		return PLUGIN_CONTINUE
	}

	//Flying forward
	if((newbutton&IN_FORWARD) && (flags&FL_ONGROUND) && !(oldbutton&IN_FORWARD)) {
		if(!gCanDo[id]) {
			new pstr[2]
			pstr[0] = id
			set_task(TMINUS,"can_switch",352+id,pstr,1)
			gCanDo[id] = true
			lasthit[id] = DOF
			return PLUGIN_CONTINUE
		}
		if(gCanDo[id]) {
			if(lasthit[id] == DOF) {
				gCanForward[id] = true
				gCanDo[id] = false
				return PLUGIN_CONTINUE
			}
			else {
				gCanDo[id] = false
				new pstr[2]
				pstr[0] = id
				set_task(TMINUS,"can_switch",314,pstr,1)
				gCanDo[id] = true
				lasthit[id] = DOF
				return PLUGIN_CONTINUE
			}
		}
	}
	
	//Flying Back
	if((newbutton&IN_BACK) && (flags&FL_ONGROUND) && !(oldbutton&IN_BACK)) {
		if(!gCanDo[id]) {
			new pstr[2]
			pstr[0] = id
			set_task(TMINUS,"can_switch",352+id,pstr,1)
			gCanDo[id] = true
			lasthit[id] = DOB
			return PLUGIN_CONTINUE
		}
		if(gCanDo[id]) {
			if(lasthit[id] == DOB) {
				gCanBack[id] = true
				gCanDo[id] = false
				return PLUGIN_CONTINUE
			}
			else {
				gCanDo[id] = false
				new pstr[2]
				pstr[0] = id
				set_task(TMINUS,"can_switch",314,pstr,1)
				gCanDo[id] = true
				lasthit[id] = DOB
				return PLUGIN_CONTINUE
			}
		}
	}
	
	//Flying Right
	if((newbutton&IN_MOVERIGHT) && (flags&FL_ONGROUND) && !(oldbutton&IN_MOVERIGHT)) {
		if(!gCanDo[id]) {
			new pstr[2]
			pstr[0] = id
			set_task(TMINUS,"can_switch",352+id,pstr,1)
			gCanDo[id] = true
			lasthit[id] = DOR
			return PLUGIN_CONTINUE
		}
		if(gCanDo[id]) {
			if(lasthit[id] == DOR) {
				gCanRight[id] = true
				gCanDo[id] = false
				return PLUGIN_CONTINUE
			}
			else {
				gCanDo[id] = false
				new pstr[2]
				pstr[0] = id
				set_task(TMINUS,"can_switch",314,pstr,1)
				gCanDo[id] = true
				lasthit[id] = DOR
				return PLUGIN_CONTINUE
			}
		}
	}
	
	//Flying Left
	if((newbutton&IN_MOVELEFT) && (flags&FL_ONGROUND) && !(oldbutton&IN_MOVELEFT)) {
		if(!gCanDo[id]) {
			new pstr[2]
			pstr[0] = id
			set_task(TMINUS,"can_switch",352+id,pstr,1)
			gCanDo[id] = true
			lasthit[id] = DOL
			return PLUGIN_CONTINUE
		}
		if(gCanDo[id]) {
			if(lasthit[id] == DOL) {
				gCanLeft[id] = true
				gCanDo[id] = false
				return PLUGIN_CONTINUE
			}
			else {
				gCanDo[id] = false
				new pstr[2]
				pstr[0] = id
				set_task(TMINUS,"can_switch",314,pstr,1)
				gCanDo[id] = true
				lasthit[id] = DOL
				return PLUGIN_CONTINUE
			}
		}
	}
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------	
public can_switch(pstr[])
{
	new id = pstr[0]
	
	gCanDo[id] = false
}
//----------------------------------------------------------------------------------------------	
public kadaj_dtpost(id)
{
	//Double Jump
	if(gCanJumpdt[id] == true) {
		new Float:velocity[3]	
		Entvars_Get_Vector(id,EV_VEC_velocity,velocity) //Get their current velocity (to carry other movement/inertia into the jump)
		velocity[2] = random_float(265.0,285.0) //Set height velocity.  Values recieved from testing.
		Entvars_Set_Vector(id,EV_VEC_velocity,velocity) //Set the player's new vector.
		gCanDo[id] = false
		gCanJumpdt[id] = false
		return PLUGIN_CONTINUE
	}
	
	//Flying Forward
	if(gCanForward[id]) {
		new corigin[3]
		new eorigin[3]
		get_user_origin(id,corigin,0)  //Grab their origin
		get_user_origin(id,eorigin,3)  //Grab the origin of the point they are looking at
		new Float:deltax = float(corigin[0]) -  float(eorigin[0])	//Find the difference between the player origin x and aiming origin x
		new Float:deltay = float(corigin[1]) - float(eorigin[1])	//Same for y
		eorigin[0] -= corigin[0]  //Subtract so that the player's origin is (0,0).  Not actually done, I only changed the values I really needed to change.	
		eorigin[1] -= corigin[1]  //Same
		new Float:polardeg = floatatan2(float(eorigin[1]),float(eorigin[0]),1)	//Find the angle between the aiming origin and the x-axis(left-right line on the player)
		if(polardeg < 0.0)  polardeg += 360.0  //Make sure that we are getting the proper angle
		new Float:totalvelo = floatadd(deltax,deltay)  //Find the total movement of x and y
		new Float:xperc = floatdiv(deltax,totalvelo)  //Divide to find the x's share of the movement
		new Float:yperc = floatdiv(deltay,totalvelo)  //Same for the y
		new Float:finalx
		new Float:finaly
		if((polardeg > 135.0) && (polardeg < 314)) { 
			finalx = floatmul(float(-900),xperc)  //Assign their final velocity (900 is arbitrary but works well)
			finaly = floatmul(float(-900),yperc)
		}
		else {
			finalx = floatmul(float(900),xperc)
			finaly = floatmul(float(900),yperc)
		}
		new Float:velocity[3]
		Entvars_Get_Vector(id,EV_VEC_velocity,velocity)
		velocity[0] = finalx	
		velocity[1] = finaly	
		velocity[2] = random_float(200.0,240.0)	
		Entvars_Set_Vector(id,EV_VEC_velocity,velocity)	
		gCanForward[id] = false	
		return PLUGIN_CONTINUE
	}
	
	//Flying Back
	if(gCanBack[id]) {
		new corigin[3]
		new eorigin[3]
		get_user_origin(id,corigin,0)
		get_user_origin(id,eorigin,3)
		new Float:deltax = float(corigin[0]) -  float(eorigin[0])
		new Float:deltay = float(corigin[1]) - float(eorigin[1])
		eorigin[0] -= corigin[0]
		eorigin[1] -= corigin[1]
		new Float:polardeg = floatatan2(float(eorigin[1]),float(eorigin[0]),1)
		if(polardeg < 0.0)  polardeg += 360.0
		new Float:totalvelo = floatadd(deltax,deltay)
		new Float:xperc = floatdiv(deltax,totalvelo)
		new Float:yperc = floatdiv(deltay,totalvelo)
		new Float:finalx
		new Float:finaly
		if((polardeg > 135.0) && (polardeg < 315)) { 
			finalx = floatmul(float(900),xperc)
			finaly = floatmul(float(900),yperc)
		}
		else {
			finalx = floatmul(float(-900),xperc)
			finaly = floatmul(float(-900),yperc)
		}
		new Float:velocity[3]
		Entvars_Get_Vector(id,EV_VEC_velocity,velocity)
		velocity[0] = finalx
		velocity[1] = finaly
		velocity[2] = random_float(200.0,240.0)
		Entvars_Set_Vector(id,EV_VEC_velocity,velocity)
		gCanBack[id] = false
		return PLUGIN_CONTINUE
	}
	
	//Fly Right
	if(gCanRight[id]) {
		new Float:velocity[3]
		Entvars_Get_Vector(id,EV_VEC_velocity,velocity)
		new Float:absx = floatabs(velocity[0])	//Figure out how fast they are moving
		new Float:absy = floatabs(velocity[1])	//Same - this will be used to figure out x/y percentages 
		new Float:total = floatadd(absx,absy)	//Add like in forward and back
		new Float:xperc = floatdiv(absx,total)	//Figure the percentages
		new Float:yperc = floatdiv(absy,total)	//Same
		new Float:finalx
		new Float:finaly 
		if(velocity[0] < 0)  finalx = floatmul(xperc,-900.0)  //Correct the velocities if negative (we used absolute value to calculate above)
		else finalx = floatmul(xperc,900.0)
		if(velocity[1] < 0)  finaly = floatmul(yperc,-900.0)
		else finaly = floatmul(yperc,900.0)
		velocity[0] = finalx
		velocity[1] = finaly
		velocity[2] = random_float(200.0,240.0)	//Give them a little jump
		Entvars_Set_Vector(id,EV_VEC_velocity,velocity)
		gCanRight[id] = false
	}	
	
	//Fly Left
	if(gCanLeft[id]) {
		new Float:velocity[3]
		Entvars_Get_Vector(id,EV_VEC_velocity,velocity)
		new Float:absx = floatabs(velocity[0])
		new Float:absy = floatabs(velocity[1])
		new Float:total = floatadd(absx,absy)
		new Float:xperc = floatdiv(absx,total)
		new Float:yperc = floatdiv(absy,total)
		new Float:finalx
		new Float:finaly 
		if(velocity[0] < 0)  finalx = floatmul(xperc,-900.0)
		else finalx = floatmul(xperc,900.0)
		if(velocity[1] < 0)  finaly = floatmul(yperc,-900.0)
		else finaly = floatmul(yperc,900.0)
		velocity[0] = finalx
		velocity[1] = finaly
		velocity[2] = random_float(200.0,240.0)
		Entvars_Set_Vector(id,EV_VEC_velocity,velocity)
		gCanLeft[id] = false
	}	
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------	
public client_connect(id)
{
	gHaskadajPower[id] = false
	jumpnum[id] = 0
	lasthit[id] = 0
}
//----------------------------------------------------------------------------------------------
public client_disconnect(id)
{
	gHaskadajPower[id] = false
	jumpnum[id] = 0
	lasthit[id] = 0
}
//----------------------------------------------------------------------------------------------