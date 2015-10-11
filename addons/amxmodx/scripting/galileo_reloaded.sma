/*********************** Licensing *******************************************************
*  This program is free software; you can redistribute it and/or modify it
*  under the terms of the GNU General Public License as published by the
*  Free Software Foundation; either version 2 of the License, or (at
*  your option) any later version.
*
*  This program is distributed in the hope that it will be useful, but
*  WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
*  General Public License for more details.
*  
*  You should have received a copy of the GNU General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*****************************************************************************************

[SIZE="6"][COLOR="Blue"][B]Galileo Reloaded v1.0-alpha1[/B][/COLOR][/SIZE]
[B]Release: 10.10.2015 | Last Update: 10.10.2015[/B]

[anchor]Top[/anchor][SIZE="5"][COLOR="blue"][B]Contents' Table[/B][/COLOR][/SIZE] 

[LIST]
[*][goanchor=Introduction]Introduction[/goanchor]
[*][goanchor=Requirements]Requirements and Commands[/goanchor]
[*][goanchor=Installation]Installation[/goanchor]
[*][goanchor=Change]Change Log[/goanchor]
[*][goanchor=TODO]TODO[/goanchor]
[*][goanchor=Credits]Credits[/goanchor]
[*][goanchor=Sourcecode]Source Code and Support[/goanchor]
[*][goanchor=Downloads]Downloads[/goanchor]
[/LIST]
The original plugin "[URL="https://forums.alliedmods.net/showthread.php?t=77391"]galileo.sma[/URL]" is originally written by [B]Brad[/B]. The "Galileo Reload" works differently 
from the original "[B]Galileo[/B]". This has special features for the "[URL=" "]Multi-Mod Manager[/URL]" plugin, but 
still can be used alone. See the [goanchor=Change]Change Log[/goanchor] and [goanchor=Credits]Credits[/goanchor] for more info. 

This is a Alpha version. This Alpha software can be unstable, see [goanchor=TODO]TODO[/goanchor] section for more information. 
As [B]Alpha software[/B] may not contain all of the features that are planned for the final version, see [goanchor=TODO]TODO[/goanchor] 
section for features that are planned for the final version. 

As I am working at another plugins, I cannot provide immediately fixes and forum's answers here. But 
as soon as I can, I am going to release a new alpha version, fixing the current bugs listed here at 
[goanchor=TODO]TODO[/goanchor] section. 
[URL="http://www.gametracker.com/search/?search_by=server_variable&search_by2=GalileoReloaded&query=&loc=_all&sort=&order="]
[SIZE=5][B][COLOR=DarkGreen]Click here to see all servers using this plugin.[/COLOR][/B][/SIZE][/URL]

********************** [anchor]Introduction[/anchor][B][SIZE="5"][COLOR="blue"]Introduction[/COLOR][/SIZE][/B] [goanchor=Top]Go Top[/goanchor]  *******************************
This is a feature rich map voting plugin.  It's intended to be used in place of any other map choosing plugin 
such as the original [B]Galileo[/B], [B]Deagles' Map Manager[/B] and AMXX's very own [B]Map Chooser[/B].

It is [COLOR="Red"][B]highly recommended[/B][/COLOR] you to review the well-commented "[B]galileo.cfg[/B]" to see all the options you 
have with this plugin.  It's located in the [B]Attached ZIP[/B] available at the [goanchor=Downloads]Downloads[/goanchor] section.

[COLOR="Blue"][B]Features' list:[/B][/COLOR] 
[QUOTE]
 * Ability to "[B]rock the vote[/B]".

 * Map [B]nominations[/B] to be used in the next map vote.

 * [B]Runoff[/B] voting when no map gets more than 50% of the total vote.

 * [B]Weighted[/B] map votes for players with customizable admin flags.

 * Command '[COLOR="Blue"][B]gal_startvote [-nochange][/B][/COLOR]', to forces a map vote to begin and the map will be 
	   changed once the next map has been determined. If the "[COLOR="blue"][B]-nochange[/B][/COLOR]" argument is supplied, 
	   the map will not be changed by [COLOR="Blue"]Galileo Reload[/COLOR], which is useful when you have a different 
	   plugin handling the actual changing of the map. 

 * Command '[COLOR="Blue"][B]gal_startvote2 [-nochange][/B][/COLOR]', the same as the first but, when keep the current 
	   map option wins, the current map is restarted. This command is specially for the "[URL=" "]Multi-Mod Manager[/URL]" plugin. 

 * Command '[COLOR="Blue"][B]gal_createmapfile filename[/B][/COLOR]', Creates a file that contains a list of every valid 
	   map in your maps folder. The [COLOR="Blue"][B]filename[/B][/COLOR] argument indicates specifies the name to be used for 
	   the new file.  It will be created in the [COLOR="Blue"][B].\configs\galileo[/B][/COLOR] folder.
[/QUOTE]

********************** [anchor]Requirements[/anchor][SIZE="5"][COLOR="Blue"][B]Requirements and Commands[/B][/COLOR][/SIZE] [goanchor=Top]Go Top[/goanchor]  ******
[B]Amx Mod X 1.8.2[/B] 
Tested under [B]Counter-Strike[/B] and Counter-Strike: [B]Condition Zero[/B] 

[B]Client's Commands:[/B]
[QUOTE]
//Displays a listing, to all players, of the most recently played maps.
//Requires CVAR "gal_banrecent" to be set to a value higher than 0.
[COLOR="Blue"]say [B]recentmaps[/B][/COLOR]

//Registers the players request for a map vote and change. The player will be 
//informed how many more players need to rock the vote before a map vote will be forced.
//The [I]anything[/I] argument can be any "word" up to 20 characters.
//Requires CVAR "gal_rtv_commands" to be set to an appropriate value.
[COLOR="Blue"]say [B]rockthevote[/B][/COLOR]
[COLOR="Blue"]say [B]rtv[/B][/COLOR]
[COLOR="Blue"]say rockthe[B]anything[/B]vote[/COLOR]

//Displays, to all players, a listing of maps that have been nominated.
//Requires CVAR "gal_nom_playerallowance" to be set to a value higher than 0.
[COLOR="Blue"]say [B]nominations[/B][/COLOR]
[COLOR="Blue"]say [B]noms[/B][/COLOR]

//Attempts to nominate the map specified by the [I]partialMapName[/I] argument.
//If there are multiple matches for [I]partialMapName[/I], a menu of the matches will 
//be displayed to the player allowing them to select the map they meant.
//Requires CVAR "gal_nom_playerallowance" to be set to a value higher than 0.
[COLOR="Blue"]say [I]nominate[/I] [B]partialMapName[/B][/COLOR]
[COLOR="Blue"]say [I]nom[/I] [B]partialMapName[/B][/COLOR]

//Cancels the nomination of [I]mapname[/I], which would have had to be previously 
//nominated by the player.
//Requires CVAR "gal_nom_playerallowance" to be set to a value higher than 0.
[COLOR="Blue"]say [I]cancel[/I] [B]mapname[/B][/COLOR]

//If [I]mapname[/I] has been nominated by the player, will cancel the nomination.  
//If [I]mapname[/I] has not been nominated by the player, will attempt to nominate it.
//Requires CVAR "gal_nom_playerallowance" to be set to a value higher than 0.
[COLOR="Blue"]say [B]mapname[/B][/COLOR]
[/QUOTE]

******************************** [anchor]Installation[/anchor][B][SIZE="5"][COLOR="Blue"]Installation[/COLOR][/SIZE][/B] [goanchor=Top]Go Top[/goanchor]  **********************
[B]1.[/B] Download the files "[B]galileo_reloaded.sma[/B]" and "[B]plugin_resources.zip[/B]" at [goanchor=Downloads]Downloads[/goanchor] 
section.

[B]2.[/B] Then take the content of "[B]yourgamemod[/B]" from "[B]plugin_resources.zip[/B]", to your gamemod folder. 
Ex: czero, cstrike, ...

[B]3.[/B] [B]Compile[/B] the file and put the [B]compiled[/B] file to your plugins folder at 
"[COLOR="Blue"]yourgamemod/addons/amxmodx/[/COLOR][B]plugins[/B]". 

[B]4.[/B] Put the [B]next line[/B] to your "[B]plugins.ini[/B]" file at "yourgamemod/addons/amxmodx/[B]configs[/B]" folder and
disable the original "[B]mapchooser.amxx[/B]" or any other [B]map manager plugin[/B], like the original the 
"[URL="https://forums.alliedmods.net/showthread.php?t=77391"]galileo.sma[/URL]":
[QUOTE]
galileo_reloaded.amxx
[/QUOTE]

******************************** [anchor]Change[/anchor][B][SIZE="5"][COLOR="blue"]Change Log[/COLOR][/SIZE][/B] [goanchor=Top]Go Top[/goanchor] ***********************
[QUOTE]
v1.0-alpha1
 * Fixed server restart after change timelimit to 0. 
 * Fixed server timelimit re-change after change it to 0. 
 * Fixed bug where it change the map right after a normal vote map finished. 
 * Removed map end control, to the original AMXX Dev Team plugin nextmap.amxx 
 * Removed  the feature to change server map, when the server is empty. 
 * Removed the "amx_nextmap" change to [vote in progress]. 
 * Removed the feature to allow round finish. 
 * Removed the messages "say currentmap", "say nextmap", to nextmap.amxx 
 * Removed not initiating vote map, at the first map, after forcing votemap. 
 * Added the command "gal_startvote2" to restart the current map when keep the current map. 
 * Added the count down voting remaining time to be always show. 
 * Added auto-pause for anothers plugins map managers. 
 * Added a option "#" to gal_nom_mapfile, to use the current mapcycle to nominate maps. 
 * Made the vote map list be loaded from the current mapcycle file. 
 * Made changemap immediately after a forced map vote, calling gal_startvote. 
 * When nobody vote for next map, keep the initial server next map. 
 * Disabled nextmap unknown change. 
[/QUOTE]

******************************** [anchor]TODO[/anchor][B][SIZE="5"][COLOR="blue"]TODO[/COLOR][/SIZE][/B] [goanchor=Top]Go Top[/goanchor] *********************************
[QUOTE]
 * Fix broken re-opt vote. 
 * To clear unused language file constants. 
 * Add colored messages. 
 * Add nominate maps by a map list. 
 * Add auto-update feature to the vote menu while voting. 
[/QUOTE]

******************************** [anchor]Credits[/anchor][B][SIZE="5"][COLOR="blue"]Credits[/COLOR][/SIZE][/B] [goanchor=Top]Go Top[/goanchor] *******************************
[B]Brad[/B]: The original [URL="https://forums.alliedmods.net/showthread.php?t=77391"]galileo.sma[/URL] developer. 
[B]Addons zz[/B]: The galileo_reloaded.sma developer. 
[B]Th3822[/B]: For find a error from map_nominate. 
[QUOTE=Brad;684848][COLOR=darkblue][SIZE=4][B]Donations to the Original Author[/B][/SIZE][/COLOR] 
A lot of time and effort went into making this plugin, making features just right, 
making sure there were no bugs, making sure it was easy to use. If you are glad I made 
this plugin, and are able, I'd appreciate a token donation. 
[URL="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=brad%40mixedberry%2enet&item_name=Thank%20you%21&item_number=Galileo&amount=5%2e00&no_shipping=1&return=http%3a%2f%2fforums%2ealliedmods%2enet%2fshowthread%2ephp%3ft%3d77391%23files&cn=Optional%20Note&tax=0&currency_code=USD&lc=US&bn=PP%2dDonationsBF&charset=UTF%2d8"]$5[/URL], 
[URL="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=brad%40mixedberry%2enet&item_name=Thank%20you%21&item_number=Galileo&amount=10%2e00&no_shipping=1&return=http%3a%2f%2fforums%2ealliedmods%2enet%2fshowthread%2ephp%3ft%3d77391%23files&cn=Optional%20Note&tax=0&currency_code=USD&lc=US&bn=PP%2dDonationsBF&charset=UTF%2d8"]$10[/URL], 
or [URL="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=brad%40mixedberry%2enet&item_name=Thank%20you%21&item_number=Galileo&no_shipping=1&return=http%3a%2f%2fforums%2ealliedmods%2enet%2fshowthread%2ephp%3ft%3d77391%23files&cn=Optional%20Note&tax=0&currency_code=USD&lc=US&bn=PP%2dDonationsBF&charset=UTF%2d8"]whatever works[/URL] for you.

[URL="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=brad%40mixedberry%2enet&item_name=Thank%20you%21&item_number=Galileo&no_shipping=1&return=http%3a%2f%2fforums%2ealliedmods%2enet%2fshowthread%2ephp%3ft%3d77391%23files&cn=Optional%20Note&tax=0&currency_code=USD&lc=US&bn=PP%2dDonationsBF&charset=UTF%2d8"][IMG]https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif[/IMG][/URL]

Thank you!  It means a lot to me.
--Brad
[/QUOTE]
******************************** [anchor]Sourcecode[/anchor][SIZE="5"][COLOR="blue"][B]Source Code and Support[/B][/COLOR][/SIZE] [goanchor=Top]Go Top[/goanchor] ***
This source code is available on [B]GitHub[/B]. 
[URL]https://github.com/addonszz/Multi-Mod_Server/blob/develop/addons/amxmodx/scripting/galileo_reloaded.sma[/URL]

For any problems with this plugin visit [B][URL="https://forums.alliedmods.net/index.php"]this own page[/URL][/B] or:
[url]https://github.com/Addonszz/Multi-Mod_Server/issues[/url]
for support.

If you are [B]posting[/B] because the plugin or a [B]feature[/B] of the plugin isn't working for you, [B]please[/B] do 
all of the following, so we can [COLOR="Blue"]more efficiently[/COLOR] figure out what's going on: 
[QUOTE] 
If you have access to your game server's console, type the [COLOR="Blue"][B]following[/B][/COLOR] in the server console: 
[LIST] 
[*]status 
[*]meta list 
[*]amxx plugins 
[*]amxx cvars 
[/LIST] 
If you don't have access the your [COLOR="Blue"][B]game server's console[/B][/COLOR], join your server and type the 
following in your game console: 

[LIST] 
[*]status 
[*]rcon_password your_rcon_password 
[*]rcon meta list 
[*]rcon amxx plugins 
[*]rcon amxx cvars 
[/LIST] 
[LIST=1] 
[*]Paste here everything from the [B]status[/B] command [COLOR="Red"][B]*except*[/B][/COLOR] the player list. 
[*]Paste here the entire result from the [B]meta list[/B] and [B]amxx plugins[/B] commands. 
[*]Paste here [COLOR="red"][B]*only*[/B][/COLOR] the CVARs that contain "[COLOR="SeaGreen"][B]galileo.amxx[/B][/COLOR]" in the last column 
from the [B]amxx cvars[/B] command. They will be grouped together. 
[/LIST] 
[/QUOTE] 
******************************** [anchor]Downloads[/anchor][SIZE="6"][COLOR="Blue"][B]Downloads[/B][/COLOR][/SIZE] [goanchor=Top]Go Top[/goanchor] ********************

*/

new const PLUGIN_VERSION[]  = "1.0-alpha1";

#include <amxmodx>
#include <amxmisc>

#pragma semicolon 1

#define TASKID_EMPTYSERVER	98176977
#define TASKID_REMINDER			52691153

#define RTV_CMD_STANDARD	 1
#define RTV_CMD_SHORTHAND	2
#define RTV_CMD_DYNAMIC		4

#define SOUND_GETREADYTOCHOOSE	1
#define SOUND_COUNTDOWN					2
#define SOUND_TIMETOCHOOSE			4
#define SOUND_RUNOFFREQUIRED		8

#define MAPFILETYPE_SINGLE	1
#define MAPFILETYPE_GROUPS	2

#define SHOWSTATUS_VOTE		1
#define SHOWSTATUS_END		2

#define SHOWSTATUSTYPE_COUNT			1
#define SHOWSTATUSTYPE_PERCENTAGE	2

#define ANNOUNCECHOICE_PLAYERS	1
#define ANNOUNCECHOICE_ADMINS		2

#define MAX_NOMINATION_CNT			5

#define MAX_PREFIX_CNT			32
#define MAX_RECENT_MAP_CNT	16

#define MAX_PLAYER_CNT				33
#define MAX_STANDARD_MAP_CNT	25
#define MAX_MAPNAME_LEN				31
#define MAX_MAPS_IN_VOTE			8
#define MAX_NOM_MATCH_CNT	 1000

#define VOTE_IN_PROGRESS	1
#define VOTE_FORCED				2
#define VOTE_IS_RUNOFF		4
#define VOTE_IS_OVER	  8
#define VOTE_IS_EARLY			16
#define VOTE_HAS_EXPIRED	32

#define SRV_START_CURRENTMAP	1
#define SRV_START_NEXTMAP			2
#define SRV_START_MAPVOTE			3
#define SRV_START_RANDOMMAP		4

#define LISTMAPS_USERID	0
#define LISTMAPS_LAST		1

#define TIMELIMIT_NOT_SET -1.0

new MENU_CHOOSEMAP[] = "gal_menuChooseMap";

new DIR_CONFIGS[64];
new DIR_DATA[64];

new CLR_RED[3];			// \r
new CLR_WHITE[3];   // \w
new CLR_YELLOW[3];  // \y
new CLR_GREY[3];		// \d

new g_mapPrefix[MAX_PREFIX_CNT][16], g_mapPrefixCnt = 1;
new g_currentMap[MAX_MAPNAME_LEN+1], Float:g_originalTimelimit = TIMELIMIT_NOT_SET;

new g_nomination[MAX_PLAYER_CNT + 1][MAX_NOMINATION_CNT + 1], g_nominationCnt, g_nominationMatchesMenu[MAX_PLAYER_CNT];

new g_voteWeightFlags[32];

new isTimeToChangeLevel = false;
new isTimeToChangeLevel2 = false;
new isTimeLimitChanged = false; 

new g_recentMap[MAX_RECENT_MAP_CNT][MAX_MAPNAME_LEN + 1], g_cntRecentMap;
new Array:g_nominationMap, g_nominationMapCnt;
new Array:g_fillerMap;
new Float:g_rtvWait;
new bool:g_rockedVote[MAX_PLAYER_CNT + 1], g_rockedVoteCnt;

new g_mapChoice[MAX_MAPS_IN_VOTE + 1][MAX_MAPNAME_LEN + 1], g_choiceCnt, g_choiceMax;
new bool:g_voted[MAX_PLAYER_CNT + 1] = {true, ...}, g_mapVote[MAX_MAPS_IN_VOTE + 1];
new g_voteStatus, g_voteDuration, g_votesCast;
new g_runoffChoice[2];
new g_vote[512];

new g_refreshVoteStatus = true, g_voteTallyType[3], g_snuffDisplay[MAX_PLAYER_CNT + 1];

new g_menuChooseMap;

new cvar_extendmapMax, cvar_extendmapStep;
new cvar_endOfMapVote;
new cvar_rtvWait, cvar_rtvRatio, cvar_rtvCommands;
new cvar_cmdVotemap, cvar_cmdListmaps, cvar_listmapsPaginate;
new cvar_banRecent, cvar_banRecentStyle, cvar_voteDuration;
new cvar_nomMapFile, cvar_nomPrefixes; 
new cvar_nomQtyUsed, cvar_nomPlayerAllowance;
new cvar_voteExpCountdown, cvar_voteWeightFlags, cvar_voteWeight;
new cvar_voteMapChoiceCnt, cvar_voteAnnounceChoice, cvar_voteUniquePrefixes;
new cvar_rtvReminder;
new cvar_srvStart;
new cvar_runoffEnabled, cvar_runoffDuration;
new cvar_voteStatus, cvar_voteStatusType;
new cvar_soundsMute;

public plugin_init()
{
	register_plugin("Galileo Reloaded", PLUGIN_VERSION, "Addons zz/Brad Jones");
	
	register_cvar("GalileoReloaded", PLUGIN_VERSION, FCVAR_SERVER|FCVAR_SPONLY);
		
	register_cvar("gal_server_starting", "1", FCVAR_SPONLY);

	register_cvar("gal_debug", "0");

	register_dictionary("common.txt");
	register_dictionary("nextmap.txt");
	register_dictionary("galileo_reloaded.txt");

	register_event("TextMsg", "event_game_commencing", "a", "2=#Game_Commencing", "2=#Game_will_restart_in");

	g_menuChooseMap = register_menuid(MENU_CHOOSEMAP);
	register_menucmd(g_menuChooseMap, MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0, "vote_handleChoice");

	register_clcmd("say", "cmd_say", -1);
	register_clcmd("votemap", "cmd_HL1_votemap");
	register_clcmd("listmaps", "cmd_HL1_listmaps");

	// Called when need to start a votemap, where extend the current map, aka, Keep Current Map, 
	// will to do the real extend
	register_concmd("gal_startvote", "cmd_startVote", ADMIN_MAP);

	// Called when need to start a votemap, where extend the current map, aka, Keep Current Map
	// restart the server at the current map
	register_concmd("gal_startvote2", "cmd_startVote2", ADMIN_MAP);

	register_concmd("gal_createmapfile", "cmd_createMapFile", ADMIN_RCON);

	cvar_extendmapMax				=	register_cvar("amx_extendmap_max", "90");
	cvar_extendmapStep			=	register_cvar("amx_extendmap_step", "15");
	
	cvar_cmdVotemap				 = register_cvar("gal_cmd_votemap", "0");
	cvar_cmdListmaps				= register_cvar("gal_cmd_listmaps", "2");

	cvar_listmapsPaginate		 = register_cvar("gal_listmaps_paginate", "10");
	
	cvar_banRecent					= register_cvar("gal_banrecent", "3");
	cvar_banRecentStyle			= register_cvar("gal_banrecentstyle", "1");

	cvar_endOfMapVote				= register_cvar("gal_endofmapvote", "1");

	cvar_srvStart						= register_cvar("gal_srv_start", "0");

	cvar_rtvCommands				= register_cvar("gal_rtv_commands", "3");
	cvar_rtvWait					  = register_cvar("gal_rtv_wait", "10");
	cvar_rtvRatio						= register_cvar("gal_rtv_ratio", "0.60");
	cvar_rtvReminder				= register_cvar("gal_rtv_reminder", "2");

	cvar_nomPlayerAllowance	= register_cvar("gal_nom_playerallowance", "2");
	cvar_nomMapFile					= register_cvar("gal_nom_mapfile", "mapcycle");
	cvar_nomPrefixes				= register_cvar("gal_nom_prefixes", "1");
	cvar_nomQtyUsed					= register_cvar("gal_nom_qtyused", "0");
	
	cvar_voteWeight				 = register_cvar("gal_vote_weight", "2");
	cvar_voteWeightFlags		= register_cvar("gal_vote_weightflags", "y");
	cvar_voteDuration				= register_cvar("gal_vote_duration", "15");
	cvar_voteExpCountdown		= register_cvar("gal_vote_expirationcountdown", "1");
	cvar_voteMapChoiceCnt		=	register_cvar("gal_vote_mapchoices", "5");
	cvar_voteAnnounceChoice	= register_cvar("gal_vote_announcechoice", "1");
	cvar_voteStatus					=	register_cvar("gal_vote_showstatus", "1");
	cvar_voteStatusType			= register_cvar("gal_vote_showstatustype", "2");
	cvar_voteUniquePrefixes = register_cvar("gal_vote_uniqueprefixes", "0");
	
	cvar_runoffEnabled			= register_cvar("gal_runoff_enabled", "0");
	cvar_runoffDuration			= register_cvar("gal_runoff_duration", "10");
	
	cvar_soundsMute					= register_cvar("gal_sounds_mute", "0");
	
	//set_task(1.0, "dbg_test",_,_,_,"a", 15);
}

public dbg_fakeVotes()
{
	if (!(g_voteStatus & VOTE_IS_RUNOFF))
	{
		g_mapVote[0] += 2;	 // map 1
		g_mapVote[1] += 0;	 // map 2
		g_mapVote[2] += 6;	 // map 3
		g_mapVote[3] += 0;	 // map 4
		g_mapVote[4] += 0;	 // map 5
		g_mapVote[5] += 4;	// extend option
		
		g_votesCast = g_mapVote[0] + g_mapVote[1] + g_mapVote[2] + g_mapVote[3] + g_mapVote[4] + g_mapVote[5];
	}
	else if (g_voteStatus & VOTE_IS_RUNOFF)
	{
		g_mapVote[0] += 1;	// choice 1
		g_mapVote[1] += 0;	// choice 2
		
		g_votesCast = g_mapVote[0] + g_mapVote[1];
	}
}

/**
 * Called when all plugins went through plugin_init().
 * When this forward is called, most plugins should have registered their
 * cvars and commands already.
 */
public plugin_cfg()
{
	isTimeLimitChanged = false;
	isTimeToChangeLevel = false;
	isTimeToChangeLevel2 = false;

	if( is_plugin_loaded( "Nextmap Chooser" ) != -1 )
	{
		server_cmd( "amxx pause mapchooser.amxx" );
	}

	formatex(DIR_CONFIGS[get_configsdir(DIR_CONFIGS, sizeof(DIR_CONFIGS)-1)], sizeof(DIR_CONFIGS)-1, "/galileo");
	formatex(DIR_DATA[get_datadir(DIR_DATA, sizeof(DIR_DATA)-1)], sizeof(DIR_DATA)-1, "/galileo");

	server_cmd("exec %s/galileo.cfg", DIR_CONFIGS);
	server_exec();

	if (colored_menus())
	{
		copy(CLR_RED, 2, "\r");
		copy(CLR_WHITE, 2, "\w");
		copy(CLR_YELLOW, 2, "\y");
	}

	g_rtvWait = get_pcvar_float(cvar_rtvWait);
	get_pcvar_string(cvar_voteWeightFlags, g_voteWeightFlags, sizeof(g_voteWeightFlags)-1);
	get_mapname(g_currentMap, sizeof(g_currentMap)-1);
	g_choiceMax = max(min(MAX_MAPS_IN_VOTE, get_pcvar_num(cvar_voteMapChoiceCnt)), 2);
	// g_nonOverlapHudSync = CreateHudSyncObj();
	g_fillerMap = ArrayCreate(32);
	g_nominationMap = ArrayCreate(32);

	// initialize nominations table
	nomination_clearAll();

	if (get_pcvar_num(cvar_banRecent))
	{
		register_clcmd("say recentmaps", "cmd_listrecent", 0);
		
		map_loadRecentList();

		if (!(get_cvar_num("gal_server_starting") && get_pcvar_num(cvar_srvStart)))
		{
			map_writeRecentList();
		}
	}

	if (get_pcvar_num(cvar_rtvCommands) & RTV_CMD_STANDARD)
	{
		register_clcmd("say rockthevote", "cmd_rockthevote", 0);
	}

	if (get_pcvar_num(cvar_nomPlayerAllowance))
	{
		register_concmd("gal_listmaps", "cmd_listmaps");
		register_clcmd("say nominations", "cmd_nominations", 0, "- displays current nominations for next map");

		if (get_pcvar_num(cvar_nomPrefixes))
		{
			map_loadPrefixList();
		}
		map_loadNominationList();
	}

	new mapName[32];
	get_mapname(mapName, 31);
	dbg_log(6, "[%s]", mapName);
	dbg_log(6, "");

	if (get_cvar_num("gal_server_starting"))
	{
		srv_handleStart();
	}

	set_task(10.0, "vote_setupEnd");
}

public plugin_end()
{
	map_restoreOriginalTimeLimit();
}

public vote_setupEnd()
{
	dbg_log(4, "%32s mp_timelimit: %f  g_originalTimelimit: %f", "vote_setupEnd(in)", get_cvar_float("mp_timelimit"), g_originalTimelimit);
	
	g_originalTimelimit = get_cvar_float("mp_timelimit");

	set_task(15.0, "vote_manageEnd", _, _, _, "b");
	
	dbg_log(2, "%32s mp_timelimit: %f  g_originalTimelimit: %f", "vote_setupEnd(out)", get_cvar_float("mp_timelimit"), g_originalTimelimit);
}

public srv_handleStart()
{
	// this is the key that tells us if this server has been restarted or not
	set_cvar_num("gal_server_starting", 0);

	// take the defined "server start" action
	new startAction = get_pcvar_num(cvar_srvStart);
	if (startAction)
	{
		new nextMap[32];
		
		if (startAction == SRV_START_CURRENTMAP || startAction == SRV_START_NEXTMAP)
		{
			new filename[256];
			formatex(filename, sizeof(filename)-1, "%s/info.dat", DIR_DATA);
		
			new file = fopen(filename, "rt"); 
			if (file) // !feof(file)
			{ 
				fgets(file, nextMap, sizeof(nextMap)-1);

				if (startAction == SRV_START_NEXTMAP)
				{
					nextMap[0] = 0;
					fgets(file, nextMap, sizeof(nextMap)-1);
				}
			}
			fclose(file);
		}
		else if (startAction == SRV_START_RANDOMMAP)
		{
			// pick a random map from allowable nominations
			
			// if noms aren't allowed, the nomination list hasn't already been loaded
			if (get_pcvar_num(cvar_nomPlayerAllowance) == 0)
			{
				map_loadNominationList();
			}
			
			if (g_nominationMapCnt)
			{
				ArrayGetString(g_nominationMap, random_num(0, g_nominationMapCnt - 1), nextMap, sizeof(nextMap)-1);
			}
		}
		
		trim(nextMap);
		
		if (nextMap[0] && is_map_valid(nextMap))
		{
			server_cmd("changelevel %s", nextMap);
		}
		else
		{
			vote_manageEarlyStart();
		}		
	}
}

vote_manageEarlyStart()
{
	g_voteStatus |= VOTE_IS_EARLY;

	set_task(120.0, "vote_startDirector");
}

map_setNext(nextMap[])
{
	// set the queryable cvar
	set_cvar_string("amx_nextmap", nextMap);
	
	// update our data file
	new filename[256];
	formatex(filename, sizeof(filename)-1, "%s/info.dat", DIR_DATA);

	new file = fopen(filename, "wt");
	if (file)
	{
		fprintf(file, "%s", g_currentMap);
		fprintf(file, "^n%s", nextMap);
		fclose(file);
	}
	else
	{
		//error
	}
}

public vote_manageEnd()
{
	new secondsLeft = get_timeleft();	
	
	// are we ready to start an "end of map" vote?
	if (secondsLeft < 151 && secondsLeft > 129 && get_pcvar_num(cvar_endOfMapVote) && !( g_voteStatus & VOTE_IN_PROGRESS ) )
	{
		vote_startDirector(false);
	}
}

public map_loadRecentList()
{
	new filename[256];
	formatex(filename, sizeof(filename)-1, "%s/recentmaps.dat", DIR_DATA);

	new file = fopen(filename, "rt");
	if (file)
	{
		new buffer[32];
		
		while (!feof(file))
		{
			fgets(file, buffer, sizeof(buffer)-1);
			trim(buffer);

			if (buffer[0])
			{
				if (g_cntRecentMap == get_pcvar_num(cvar_banRecent))
				{
					break;
				}
				copy(g_recentMap[g_cntRecentMap++], sizeof(buffer)-1, buffer);
			}
		}
		fclose(file);
	}
}

public map_writeRecentList()
{
	new filename[256];
	formatex(filename, sizeof(filename)-1, "%s/recentmaps.dat", DIR_DATA);

	new file = fopen(filename, "wt");
	if (file)
	{
		fprintf(file, "%s", g_currentMap);

		for (new idxMap = 0; idxMap < get_pcvar_num(cvar_banRecent) - 1; ++idxMap)
		{
			fprintf(file, "^n%s", g_recentMap[idxMap]);
		}
		
		fclose(file);
	}
}

public map_loadFillerList(filename[])
{
	return map_populateList(g_fillerMap, filename);	
}

public cmd_rockthevote(id)
{
	client_print(id, print_chat, "%L", id, "GAL_CMD_RTV");
	vote_rock(id);
	return PLUGIN_CONTINUE;
}

public cmd_nominations(id)
{
	client_print(id, print_chat, "%L", id, "GAL_CMD_NOMS");
	nomination_list(id);
	return PLUGIN_CONTINUE;
}

public cmd_listrecent(id)
{
	switch (get_pcvar_num(cvar_banRecentStyle))
	{
		case 1:
		{
			new msg[101], msgIdx;
			for (new idx = 0; idx < g_cntRecentMap; ++idx)
			{
				msgIdx += format(msg[msgIdx], sizeof(msg)-1-msgIdx, ", %s", g_recentMap[idx]);
			}	
			client_print(0, print_chat, "%L: %s", LANG_PLAYER, "GAL_MAP_RECENTMAPS", msg[2]);	
		}
		case 2:
		{
			for (new idx = 0; idx < g_cntRecentMap; ++idx)
			{
				client_print(0, print_chat, "%L (%i): %s", LANG_PLAYER, "GAL_MAP_RECENTMAP", idx+1, g_recentMap[idx]);
			}
		}
	}
	
	return PLUGIN_HANDLED;
}

public cmd_startVote(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED;

	if (g_voteStatus & VOTE_IN_PROGRESS)
	{
		client_print(id, print_chat, "%L", id, "GAL_VOTE_INPROGRESS");
	}
	else 
	{
		isTimeToChangeLevel = true;
		vote_startDirector(true);	
	}

	return PLUGIN_HANDLED;
}

public cmd_startVote2(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED;

	if (g_voteStatus & VOTE_IN_PROGRESS)
	{
		client_print(id, print_chat, "%L", id, "GAL_VOTE_INPROGRESS");
	}
	else 
	{
		isTimeToChangeLevel = true;
		isTimeToChangeLevel2 = true;
		vote_startDirector(true);	
	}

	return PLUGIN_HANDLED;
}

map_populateList(Array:mapArray, mapFilename[])
{
	// clear the map array in case we're reusing it
	ArrayClear(mapArray);
	
	// load the array with maps
	new mapCnt;
	
	if ( !equal(mapFilename, "*") && !equal(mapFilename, "#") )
	{
		new file = fopen(mapFilename, "rt");
		if (file)
		{
			new buffer[32];
			
			while (!feof(file))
			{
				fgets(file, buffer, sizeof(buffer)-1);
				trim(buffer);
				
				if (buffer[0] && !equal(buffer, "//", 2) && !equal(buffer, ";", 1) && is_map_valid(buffer))
				{
					ArrayPushString(mapArray, buffer);
					++mapCnt;
				}
			}
			fclose(file);
		}
		else
		{
			log_error(AMX_ERR_NOTFOUND, "%L", LANG_SERVER, "GAL_MAPS_FILEMISSING", mapFilename);
		}
	}
	else
	{
		if ( equal(mapFilename, "*") )
		{
			// no file provided, assuming contents of "maps" folder
			new dir, mapName[32];
			dir = open_dir("maps", mapName, sizeof(mapName)-1);

			if (dir)
			{
				new lenMapName;
				
				while (next_file(dir, mapName, sizeof(mapName)-1))
				{
					lenMapName = strlen(mapName);	
					if (lenMapName > 4 && equali(mapName[lenMapName - 4], ".bsp", 4))
					{
						mapName[lenMapName-4] = '^0';
						if (is_map_valid(mapName))
						{
							ArrayPushString(mapArray, mapName);
							++mapCnt;
						}
					}
				}
				close_dir(dir);
			}
			else
			{
				// directory not found, wtf?
				log_error(AMX_ERR_NOTFOUND, "%L", LANG_SERVER, "GAL_MAPS_FOLDERMISSING");
			}
		} else 
		{
			get_cvar_string("mapcyclefile", mapFilename, 255 );
			new file = fopen(mapFilename, "rt");
			if (file)
			{
				new buffer[32];
				
				while (!feof(file))
				{
					fgets(file, buffer, sizeof(buffer)-1);
					trim(buffer);
					
					if (buffer[0] && !equal(buffer, "//", 2) && !equal(buffer, ";", 1) && is_map_valid(buffer))
					{
						ArrayPushString(mapArray, buffer);
						++mapCnt;
					}
				}
				fclose(file);
			}
			else
			{
				log_error(AMX_ERR_NOTFOUND, "%L", LANG_SERVER, "GAL_MAPS_FILEMISSING", mapFilename);
			}
		}
	}
	return mapCnt;	
}

public map_loadNominationList()
{
	new filename[256];
	get_pcvar_string(cvar_nomMapFile, filename, sizeof(filename)-1);

	g_nominationMapCnt = map_populateList(g_nominationMap, filename);
}

public cmd_createMapFile(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED;

	new cntArg = read_argc() - 1;
	
	switch (cntArg)
	{
		case 1:
		{
			new arg1[256];
			read_argv(1, arg1, sizeof(arg1)-1);
			remove_quotes(arg1);

			new mapName[MAX_MAPNAME_LEN+5];	// map name is 31 (i.e. MAX_MAPNAME_LEN), ".bsp" is 4, string terminator is 1.
			new dir, file, mapCnt, lenMapName;
			
			dir = open_dir("maps", mapName, sizeof(mapName)-1);
			if (dir)
			{
				new filename[256];
				formatex(filename, sizeof(filename)-1, "%s/%s", DIR_CONFIGS, arg1);
				
				file = fopen(filename, "wt");
				if (file)
				{
					mapCnt = 0;
					while (next_file(dir, mapName, sizeof(mapName)-1))
					{
						lenMapName = strlen(mapName);	
						
						if (lenMapName > 4 && equali(mapName[lenMapName - 4], ".bsp", 4))
						{
							mapName[lenMapName- 4] = '^0';
							if (is_map_valid(mapName))
							{
								mapCnt++;
								fprintf(file, "%s^n", mapName);
							}
						}
					}
					fclose(file);
					con_print(id, "%L", LANG_SERVER, "GAL_CREATIONSUCCESS", filename, mapCnt);
				}
				else
				{
					con_print(id, "%L", LANG_SERVER, "GAL_CREATIONFAILED", filename);
				}
				close_dir(dir);
			}
			else
			{
				// directory not found, wtf?
				con_print(id, "%L", LANG_SERVER, "GAL_MAPSFOLDERMISSING");
			}
		}
		default:
		{
			// inform of correct usage
			con_print(id, "%L", id, "GAL_CMD_CREATEFILE_USAGE1");
			con_print(id, "%L", id, "GAL_CMD_CREATEFILE_USAGE2");
		}
	}		
	return PLUGIN_HANDLED;
}

public map_loadPrefixList()
{
	new filename[256];
	formatex(filename, sizeof(filename)-1, "%s/prefixes.ini", DIR_CONFIGS);

	new file = fopen(filename, "rt");
	if (file)
	{
		new buffer[16];
		while (!feof(file))
		{
			fgets(file, buffer, sizeof(buffer)-1);
			if (buffer[0] && !equal(buffer, "//", 2))
			{
				if (g_mapPrefixCnt <= MAX_PREFIX_CNT)
				{
					trim(buffer);
					copy(g_mapPrefix[g_mapPrefixCnt++], sizeof(buffer)-1, buffer);
				}
				else
				{
					log_error(AMX_ERR_BOUNDS, "%L", LANG_SERVER, "GAL_PREFIXES_TOOMANY", MAX_PREFIX_CNT, filename);
					break;
				}
			}
		}
		fclose(file);
	}
	else
	{
		log_error(AMX_ERR_NOTFOUND, "%L", LANG_SERVER, "GAL_PREFIXES_NOTFOUND", filename);
	}
	return PLUGIN_HANDLED;
}

public event_game_commencing()
{
	// make sure the reset time is the original time limit 
	// (can be skewed if map was previously extended)
	map_restoreOriginalTimeLimit();
}

map_getIdx(text[])
{
	new map[MAX_MAPNAME_LEN + 1];
	new mapIdx;
	new nominationMap[32];
	
	for (new prefixIdx = 0; prefixIdx < g_mapPrefixCnt; ++prefixIdx)
	{
		formatex(map, sizeof(map)-1, "%s%s", g_mapPrefix[prefixIdx], text);

		for (mapIdx = 0; mapIdx < g_nominationMapCnt; ++mapIdx)
		{
			ArrayGetString(g_nominationMap, mapIdx, nominationMap, sizeof(nominationMap)-1);
			
			if (equal(map, nominationMap))
			{
				return mapIdx;
			}
		}
	}
	return -1;
}

public cmd_say(id)
{
	//-----
	// generic say handler to determine if we need to act on what was said
	//-----
	
	static text[70], arg1[32], arg2[32], arg3[2];
	read_args(text, sizeof(text)-1);
	remove_quotes(text);
	arg1[0] = '^0';
	arg2[0] = '^0';
	arg3[0] = '^0';
	parse(text, arg1, sizeof(arg1)-1, arg2, sizeof(arg2)-1, arg3, sizeof(arg3)-1);

	// if the chat line has more than 2 words, we're not interested at all
	if (arg3[0] == 0)
	{
		new idxMap;

		// if the chat line contains 1 word, it could be a map or a one-word command
		if (arg2[0] == 0) // "say [rtv|rockthe<anything>vote]"
		{
			if ((get_pcvar_num(cvar_rtvCommands) & RTV_CMD_SHORTHAND && equali(arg1, "rtv")) || ((get_pcvar_num(cvar_rtvCommands) & RTV_CMD_DYNAMIC && equali(arg1, "rockthe", 7) && equali(arg1[strlen(arg1)-4], "vote"))))
			{
				vote_rock(id);
				return PLUGIN_HANDLED;
			}
			else if (get_pcvar_num(cvar_nomPlayerAllowance))
			{
				if (equali(arg1, "noms"))
				{
					nomination_list(id);
					return PLUGIN_HANDLED;
				}
				else
				{
					idxMap = map_getIdx(arg1);
					if (idxMap >= 0)
					{
						nomination_toggle(id, idxMap);
						return PLUGIN_HANDLED;
					}
				}
			}
		}
		else if (get_pcvar_num(cvar_nomPlayerAllowance)) // "say <nominate|nom|cancel> <map>"
		{
			if (equali(arg1, "nominate") || equali(arg1, "nom"))
			{
				nomination_attempt(id, arg2);
				return PLUGIN_HANDLED;
			}
			else if (equali(arg1, "cancel"))
			{
				// bpj -- allow ambiguous cancel in which case a menu of their nominations is shown
				idxMap = map_getIdx(arg2);
				if (idxMap >= 0)
				{
					nomination_cancel(id, idxMap);
					return PLUGIN_HANDLED;
				}
			}
		}
	}
	return PLUGIN_CONTINUE;
}

nomination_attempt(id, nomination[]) // (playerName[], &phraseIdx, matchingSegment[])
{
	// all map names are stored as lowercase, so normalize the nomination
	strtolower(nomination);
	
	// assume there'll be more than one match (because we're lazy) and starting building the match menu
	//menu_destroy(g_nominationMatchesMenu[id]);
	g_nominationMatchesMenu[id] = menu_create("Nominate Map", "nomination_handleMatchChoice");
	
	// gather all maps that match the nomination
	new mapIdx, nominationMap[32], matchCnt = 0, matchIdx = -1, info[1], choice[64], disabledReason[16];
	for (mapIdx = 0; mapIdx < g_nominationMapCnt && matchCnt <= MAX_NOM_MATCH_CNT; ++mapIdx)
	{
		ArrayGetString(g_nominationMap, mapIdx, nominationMap, sizeof(nominationMap)-1);
		
		if (contain(nominationMap, nomination) > -1)
		{
			matchCnt++;
			matchIdx = mapIdx;	// store in case this is the only match
			
			// there may be a much better way of doing this, but I didn't feel like 
			// storing the matches and mapIdx's only to loop through them again
			info[0] = mapIdx;

			// in most cases, the map will be available for selection, so assume that's the case here
			disabledReason[0] = 0;

			// disable if the map has already been nominated
			if (nomination_getPlayer(mapIdx))
			{
				formatex(disabledReason, sizeof(disabledReason)-1, "%L", id, "GAL_MATCH_NOMINATED");
			}
			// disable if the map is too recent
			else if (map_isTooRecent(nominationMap))
			{
				formatex(disabledReason, sizeof(disabledReason)-1, "%L", id, "GAL_MATCH_TOORECENT");
			}
			else if (equal(g_currentMap, nominationMap))
			{
				formatex(disabledReason, sizeof(disabledReason)-1, "%L", id, "GAL_MATCH_CURRENTMAP");
			}

			formatex(choice, sizeof(choice)-1, "%s %s", nominationMap, disabledReason);
			menu_additem(g_nominationMatchesMenu[id], choice, info, (disabledReason[0] == 0) ? 0 : (1<<26));
		}
	}
	
	// handle the number of matches
	switch (matchCnt)
	{
		case 0:
		{
			// no matches; pity the poor fool
			client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_NOMATCHES", nomination);
		}		
		case 1:
		{
			// one match?! omg, this is just like awesome
			map_nominate(id, matchIdx);
			
		}		
		default:
		{
			// this is kinda sexy; we put up a menu of the matches for them to pick the right one
			client_print(id, print_chat, "%L", id, "GAL_NOM_MATCHES", nomination);
			if (matchCnt == MAX_NOM_MATCH_CNT)
			{
				client_print(id, print_chat, "%L", id, "GAL_NOM_MATCHES_MAX", MAX_NOM_MATCH_CNT, MAX_NOM_MATCH_CNT);
			}
			menu_display(id, g_nominationMatchesMenu[id]);
		}
	}
}

public nomination_handleMatchChoice(id, menu, item)
{
	if( item < 0 ) return PLUGIN_CONTINUE;
 
	// Get item info
	new mapIdx, info[1];
	new access, callback;
 
	menu_item_getinfo(g_nominationMatchesMenu[id], item, access, info, 1, _, _, callback);
 
	mapIdx = info[0];
	map_nominate(id, mapIdx);
 
	return PLUGIN_HANDLED;
}

nomination_getPlayer(idxMap)
{
	// check if the map has already been nominated
	new idxNomination;
	new playerNominationMax = min(get_pcvar_num(cvar_nomPlayerAllowance), MAX_NOMINATION_CNT);
	
	for (new idPlayer = 1; idPlayer <= MAX_PLAYER_CNT; ++idPlayer)
	{
		for (idxNomination = 1; idxNomination <= playerNominationMax; ++idxNomination)
		{
			if (idxMap == g_nomination[idPlayer][idxNomination])
			{
				return idPlayer;
			}
		}
	}
	return 0;
}

nomination_toggle(id, idxMap)
{
	new idNominator = nomination_getPlayer(idxMap);
	if (idNominator == id)
	{
		nomination_cancel(id, idxMap);
	}
	else
	{
		map_nominate(id, idxMap, idNominator);
	}
}

nomination_cancel(id, idxMap)
{
	// cancellations can only be made if a vote isn't already in progress
	if (g_voteStatus & VOTE_IN_PROGRESS)
	{
		client_print(id, print_chat, "%L", id, "GAL_CANCEL_FAIL_INPROGRESS");
		return;
	}
	// and if the outcome of the vote hasn't already been determined
	else if (g_voteStatus & VOTE_IS_OVER)
	{
		client_print(id, print_chat, "%L", id, "GAL_CANCEL_FAIL_VOTEOVER");
		return;
	}

	new bool:nominationFound, idxNomination;
	new playerNominationMax = min(get_pcvar_num(cvar_nomPlayerAllowance), MAX_NOMINATION_CNT);
	
	for (idxNomination = 1; idxNomination <= playerNominationMax; ++idxNomination)
	{
		if (g_nomination[id][idxNomination] == idxMap)
		{
			nominationFound = true;
			break;
		}
	}

	new mapName[32];
	ArrayGetString(g_nominationMap, idxMap, mapName, sizeof(mapName)-1);
	
	if (nominationFound)
	{
		g_nomination[id][idxNomination] = -1;
		g_nominationCnt--;
		
		nomination_announceCancellation(mapName);
	}
	else
	{
		new idNominator = nomination_getPlayer(idxMap);
		if (idNominator)
		{
			new name[32];
			get_user_name(idNominator, name, 31);
			
			client_print(id, print_chat, "%L", id, "GAL_CANCEL_FAIL_SOMEONEELSE", mapName, name);
		}
		else
		{
			client_print(id, print_chat, "%L", id, "GAL_CANCEL_FAIL_WASNOTYOU", mapName);
		}
	}
}

map_nominate(id, idxMap, idNominator = -1)
{
	// nominations can only be made if a vote isn't already in progress
	if (g_voteStatus & VOTE_IN_PROGRESS)
	{
		client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_INPROGRESS");
		return;
	}
	// and if the outcome of the vote hasn't already been determined
	else if (g_voteStatus & VOTE_IS_OVER)
	{
		client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_VOTEOVER");
		return;
	}
	
	new mapName[32];
	ArrayGetString(g_nominationMap, idxMap, mapName, sizeof(mapName)-1);
	
	// players can not nominate the current map
	if (equal(g_currentMap, mapName))
	{
		client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_CURRENTMAP", g_currentMap);
		return;
	}
	
	// players may not be able to nominate recently played maps
	if (map_isTooRecent(mapName))
	{
		client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_TOORECENT", mapName);
		client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_TOORECENT_HLP");
		return;
	}
	
	// check if the map has already been nominated
	if (idNominator == -1)
	{
		idNominator = nomination_getPlayer(idxMap);
	}

	if (idNominator == 0)
	{
		// determine the number of nominations the player already made
		// and grab an open slot with the presumption that the player can make the nomination
		new nominationCnt = 0, idxNominationOpen, idxNomination;
		new playerNominationMax = min(get_pcvar_num(cvar_nomPlayerAllowance), MAX_NOMINATION_CNT);
		
		for (idxNomination = 1; idxNomination <= playerNominationMax; ++idxNomination)
		{
			if (g_nomination[id][idxNomination] >= 0)
			{
				nominationCnt++;
			}
			else
			{
				idxNominationOpen = idxNomination;
			}
		}

		if (nominationCnt == playerNominationMax)
		{
			new nominatedMaps[256], buffer[32];
			for (idxNomination = 1; idxNomination <= playerNominationMax; ++idxNomination)
			{
				idxMap = g_nomination[id][idxNomination];
				ArrayGetString(g_nominationMap, idxMap, buffer, sizeof(buffer)-1);
				format(nominatedMaps, sizeof(nominatedMaps)-1, "%s%s%s", nominatedMaps, (idxNomination == 1) ? "" : ", ", buffer);
			}
				
			client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_TOOMANY", playerNominationMax, nominatedMaps);
			client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_TOOMANY_HLP");
		}
		else
		{
			// otherwise, allow the nomination
			g_nomination[id][idxNominationOpen] = idxMap;
			g_nominationCnt++;
			map_announceNomination(id, mapName);
			client_print(id, print_chat, "%L", id, "GAL_NOM_GOOD_HLP");
		}		
	}
	else if (idNominator == id)
	{
		client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_ALREADY", mapName);
	}
	else
	{
		new name[32];
		get_user_name(idNominator, name, 31);
		
		client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_SOMEONEELSE", mapName, name);
		client_print(id, print_chat, "%L", id, "GAL_NOM_FAIL_SOMEONEELSE_HLP");
	}	
}

public nomination_list(id)
{
	new idxNomination, idxMap; //, hudMessage[512];
	new msg[101], mapCnt;
	new playerNominationMax = min(get_pcvar_num(cvar_nomPlayerAllowance), MAX_NOMINATION_CNT);
	new mapName[32];
	
	for (new idPlayer = 1; idPlayer <= MAX_PLAYER_CNT; ++idPlayer)
	{
		for (idxNomination = 1; idxNomination <= playerNominationMax; ++idxNomination)
		{
			idxMap = g_nomination[idPlayer][idxNomination];
			if (idxMap >= 0)
			{
				ArrayGetString(g_nominationMap, idxMap, mapName, sizeof(mapName)-1);
				format(msg, sizeof(msg)-1, "%s, %s", msg, mapName);
				
				if (++mapCnt == 4)	// list 4 maps per chat line
				{
					client_print(0, print_chat, "%L: %s", LANG_PLAYER, "GAL_NOMINATIONS", msg[2]);
					mapCnt = 0;
					msg[0] = 0;
				}
			}
		}
	}
	if (msg[0])
	{
		client_print(0, print_chat, "%L: %s", LANG_PLAYER, "GAL_NOMINATIONS", msg[2]);
	}
	else
	{
		client_print(0, print_chat, "%L: %L", LANG_PLAYER, "GAL_NOMINATIONS", LANG_PLAYER, "NONE");
	}

//	set_hudmessage(255, 0, 90, 0.80, 0.20, 0, 1.0, 12.0, 0.1, 0.1, -1);
//	ShowSyncHudMsg(id, g_nonOverlapHudSync, hudMessage);
}

public vote_startDirector(bool:forced)
{
	new secondsLeft = get_timeleft();	

	if (g_voteStatus & VOTE_IN_PROGRESS & secondsLeft > 151 && secondsLeft < 129 )
	{
		client_print(0, print_chat, "%L", 0, "GAL_VOTE_INPROGRESS");
	} else
	{
		new choicesLoaded, voteDuration;
		
		if (g_voteStatus & VOTE_IS_RUNOFF)
		{
			choicesLoaded = vote_loadRunoffChoices();
			voteDuration = get_pcvar_num(cvar_runoffDuration);

			if (get_realplayersnum())
			{
				dbg_log(4, "   [RUNOFF VOTE CHOICES (%i)]", choicesLoaded);
			}
		}
		else
		{
			// make it known that a vote is in progress
			g_voteStatus |= VOTE_IN_PROGRESS;

			// stop RTV reminders
			remove_task(TASKID_REMINDER);

			if (forced)
			{
				g_voteStatus |= VOTE_FORCED;
			}
			
			choicesLoaded = vote_loadChoices();
			voteDuration = get_pcvar_num(cvar_voteDuration);
			
			if (get_realplayersnum())
			{
				dbg_log(4, "   [PRIMARY VOTE CHOICES (%i)]", choicesLoaded);
			}
			
			if (choicesLoaded)
			{
				// clear all nominations
				nomination_clearAll();
			}
		}
		
		if (choicesLoaded)
		{
			// alphabetize the maps
			SortCustom2D(g_mapChoice, choicesLoaded, "sort_stringsi");

			// dbg code ----
			if (get_realplayersnum())
			{
				for (new dbgChoice = 0; dbgChoice < choicesLoaded; dbgChoice++)
				{
					dbg_log(4, "	  %i. %s", dbgChoice+1, g_mapChoice[dbgChoice]);
				}
			}
			//--------------

			// mark the players who are in this vote for use later
			new player[32], playerCnt;
			get_players(player, playerCnt, "ch");	// skip bots and hltv
			for (new idxPlayer = 0; idxPlayer < playerCnt; ++idxPlayer)
			{
				g_voted[player[idxPlayer]] = false;
			}

			// make perfunctory announcement: "get ready to choose a map"
			if (!(get_pcvar_num(cvar_soundsMute) & SOUND_GETREADYTOCHOOSE))
			{
				client_cmd(0, "spk ^"get red(e80) ninety(s45) to check(e20) use bay(s18) mass(e42) cap(s50)^"");
			}

			// announce the pending vote countdown from 7 to 1
			set_task(1.0, "vote_countdownPendingVote", _, _, _, "a", 7);

			// display the map choices
			set_task(8.5, "vote_handleDisplay");

			// display the vote outcome 
			if (get_pcvar_num(cvar_voteStatus))
			{
				new arg[3] = {-1, -1, false}; // indicates it's the end of vote display
				set_task(8.5 + float(voteDuration) + 1.0, "vote_display", _, arg, 3);
				set_task(8.5 + float(voteDuration) + 6.0, "vote_expire");
			}
			else
			{
				set_task(8.5 + float(voteDuration) + 3.0, "vote_expire");
			}
		}
		else
		{
			client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_VOTE_NOMAPS");
		}
		if (get_realplayersnum())
		{
			dbg_log(4, "");
			dbg_log(4, "   [PLAYER CHOICES]");
		}
	}
}

public vote_countdownPendingVote()
{
	static countdown = 7;

	// visual countdown	
	set_hudmessage(0, 222, 50, -1.0, 0.13, 0, 1.0, 0.94, 0.0, 0.0, -1);
	show_hudmessage(0, "%L", LANG_PLAYER, "GAL_VOTE_COUNTDOWN", countdown);

	// audio countdown
	if (!(get_pcvar_num(cvar_soundsMute) & SOUND_COUNTDOWN))
	{	
		new word[6];
		num_to_word(countdown, word, 5);
		
		client_cmd(0, "spk ^"fvox/%s^"", word);
	}
	
	// decrement the countdown
	countdown--;
	
	if (countdown == 0)
	{
		countdown = 7;
	}
}

vote_addNominations()
{
	// dbg code ----
	if (get_realplayersnum())
	{
		dbg_log(4, "   [NOMINATIONS (%i)]", g_nominationCnt);
	}
	//--------------
	
	if (g_nominationCnt)
	{
		// set how many total nominations we can use in this vote
		new maxNominations = get_pcvar_num(cvar_nomQtyUsed);
		new slotsAvailable = g_choiceMax - g_choiceCnt;
		new voteNominationMax = (maxNominations) ? min(maxNominations, slotsAvailable) : slotsAvailable;
		
		// set how many total nominations each player is allowed
		new playerNominationMax = min(get_pcvar_num(cvar_nomPlayerAllowance), MAX_NOMINATION_CNT);

		// add as many nominations as we can	
		// [TODO: develop a better method of determining which nominations make the cut; either FIFO or random]
		new idxMap, id, mapName[32];

		// dbg code ----
		if (get_realplayersnum())
		{
			new nominator_id, playerName[32];
			for (new idxNomination = playerNominationMax; idxNomination >= 1; --idxNomination)
			{
				for (id = 1; id <= MAX_PLAYER_CNT; ++id)
				{
					idxMap = g_nomination[id][idxNomination];
					if (idxMap >= 0)
					{
						ArrayGetString(g_nominationMap, idxMap, mapName, sizeof(mapName)-1);
						nominator_id = nomination_getPlayer(idxMap);
						get_user_name(nominator_id, playerName, sizeof(playerName)-1);
	
						dbg_log(4, "	  %-32s %s", mapName, playerName);
					}
				}
			}
			dbg_log(4, "");
		}
		//--------------

		for (new idxNomination = playerNominationMax; idxNomination >= 1; --idxNomination)
		{
			for (id = 1; id <= MAX_PLAYER_CNT; ++id)
			{
				idxMap = g_nomination[id][idxNomination];
				if (idxMap >= 0)
				{
					ArrayGetString(g_nominationMap, idxMap, mapName, sizeof(mapName)-1);
					copy(g_mapChoice[g_choiceCnt++], sizeof(g_mapChoice[])-1, mapName);
					
					if (g_choiceCnt == voteNominationMax)
					{
						break;
					}
				}
			}
			if (g_choiceCnt == voteNominationMax)
			{
				break;
			}
		}	
	}
}

vote_addFiller()
{
	if (g_choiceCnt == g_choiceMax)
	{
		return;
	}

	// grab the name of the filler file
	new filename[256];
	get_cvar_string("mapcyclefile", filename, sizeof(filename)-1);

	// create an array of files that will be pulled from
	new fillerFile[8][256];
	new mapsPerGroup[8], groupCnt;

	if (!equal(filename, "*"))
	{
		// determine what kind of file it's being used as
		new file = fopen(filename, "rt");
		if (file)
		{
			new buffer[16];
			fgets(file, buffer, sizeof(buffer)-1);
			trim(buffer);
			fclose(file);

			if (equali(buffer, "[groups]")) 
			{
				dbg_log(8, " ");
				dbg_log(8, "this is a [groups] file");
				// read the filler file to determine how many groups there are (max of 8)
				new groupIdx;
				
				file = fopen(filename, "rt");
				
				while (!feof(file))
				{
					fgets(file, buffer, sizeof(buffer)-1);
					trim(buffer);  
//					dbg_log(8, "buffer: %s   isdigit: %i   groupCnt: %i  ", buffer, isdigit(buffer[0]), groupCnt);

					if (isdigit(buffer[0]))
					{
						if (groupCnt < 8)
						{
							groupIdx = groupCnt++;
							mapsPerGroup[groupIdx] = str_to_num(buffer);
							formatex(fillerFile[groupIdx], sizeof(fillerFile[])-1, "%s/%i.ini", DIR_CONFIGS, groupCnt);
//							dbg_log(8, "fillerFile: %s", fillerFile[groupIdx]);
						}
						else
						{
							log_error(AMX_ERR_BOUNDS, "%L", LANG_SERVER, "GAL_GRP_FAIL_TOOMANY", filename);
							break;
						}
					}
				}

				fclose(file);
				
				if (groupCnt == 0)
				{
					log_error(AMX_ERR_GENERAL, "%L", LANG_SERVER, "GAL_GRP_FAIL_NOCOUNTS", filename);
					return;
				}
			}
			else
			{
				// we presume it's a listing of maps, ala mapcycle.txt
				copy(fillerFile[0], sizeof(filename)-1, filename);
				mapsPerGroup[0] = 8;
				groupCnt = 1;
			}
		}
		else
		{
			log_error(AMX_ERR_NOTFOUND, "%L", LANG_SERVER, "GAL_FILLER_NOTFOUND", fillerFile);
		}
	}
	else
	{
		// we'll be loading all maps in the /maps folder
		copy(fillerFile[0], sizeof(filename)-1, filename);
		mapsPerGroup[0] = 8;
		groupCnt = 1;
	}
	
	// fill remaining slots with random maps from each filler file, as much as possible
	new mapCnt, mapKey, allowedCnt, unsuccessfulCnt, choiceIdx, mapName[32];

	for (new groupIdx = 0; groupIdx < groupCnt; ++groupIdx)
	{
		mapCnt = map_loadFillerList(fillerFile[groupIdx]);
		dbg_log(8, "[%i] groupCnt:%i   mapCnt: %i   g_choiceCnt: %i   g_choiceMax: %i   fillerFile: %s", groupIdx, groupCnt, mapCnt, g_choiceCnt, g_choiceMax, fillerFile[groupIdx]);

		if (g_choiceCnt < g_choiceMax && mapCnt)
		{
			unsuccessfulCnt = 0;
			allowedCnt = min(min(mapsPerGroup[groupIdx], g_choiceMax - g_choiceCnt), mapCnt);
			dbg_log(8, "[%i] allowedCnt: %i   mapsPerGroup: %i   Max-Cnt: %i", groupIdx, allowedCnt, mapsPerGroup[groupIdx], g_choiceMax - g_choiceCnt);
			
			for (choiceIdx = 0; choiceIdx < allowedCnt; ++choiceIdx)
			{
				mapKey = random_num(0, mapCnt - 1);
				ArrayGetString(g_fillerMap, mapKey, mapName, sizeof(mapName)-1);
				dbg_log(8, "[%i] choiceIdx: %i   allowedCnt: %i   mapKey: %i   mapName: %s", groupIdx, choiceIdx, allowedCnt, mapKey, mapName);
				unsuccessfulCnt = 0;
				
				while ((map_isInMenu(mapName) || equal(g_currentMap, mapName) || map_isTooRecent(mapName) || prefix_isInMenu(mapName)) && unsuccessfulCnt < mapCnt)
				{
					unsuccessfulCnt++;
					if (++mapKey == mapCnt) 
					{
						mapKey = 0;
					}
					ArrayGetString(g_fillerMap, mapKey, mapName, sizeof(mapName)-1);
				}
				
				if (unsuccessfulCnt == mapCnt)
				{
					//client_print(0, print_chat, "unsuccessfulCnt: %i  mapCnt: %i", unsuccessfulCnt, mapCnt);
					// there aren't enough maps in this filler file to continue adding anymore
					break;
				}
				
				//client_print(0, print_chat, "mapIdx: %i  map: %s", mapIdx, mapName);
				copy(g_mapChoice[g_choiceCnt++], sizeof(g_mapChoice[])-1, mapName);
				dbg_log(8, "[%i] mapName: %s   unsuccessfulCnt: %i   mapCnt: %i   g_choiceCnt: %i", groupIdx, mapName, unsuccessfulCnt, mapCnt, g_choiceCnt);
			}
		}
	}
}

vote_loadChoices()
{
	vote_addNominations();
	vote_addFiller();
	
	return g_choiceCnt;
}

vote_loadRunoffChoices()
{
	new choiceCnt;

	new runoffChoice[2][MAX_MAPNAME_LEN+1];
	copy(runoffChoice[0], sizeof(runoffChoice[])-1, g_mapChoice[g_runoffChoice[0]]);
	copy(runoffChoice[1], sizeof(runoffChoice[])-1, g_mapChoice[g_runoffChoice[1]]);

	new mapIdx;
	if (g_runoffChoice[0] != g_choiceCnt)
	{
		copy(g_mapChoice[mapIdx++], sizeof(g_mapChoice[])-1, runoffChoice[0]);
		choiceCnt++;
	}	
	if (g_runoffChoice[1] != g_choiceCnt)
	{
		choiceCnt++;
	}
	copy(g_mapChoice[mapIdx], sizeof(g_mapChoice[])-1, runoffChoice[1]);
	
	g_choiceCnt = choiceCnt;

	return choiceCnt;	
}

public vote_handleDisplay()
{
	// announce: "time to choose"
	if (!(get_pcvar_num(cvar_soundsMute) & SOUND_TIMETOCHOOSE))
	{
		client_cmd(0, "spk Gman/Gman_Choose%i", random_num(1, 2));
	}

	if (g_voteStatus & VOTE_IS_RUNOFF)
	{
		g_voteDuration = get_pcvar_num(cvar_runoffDuration);
	}
	else
	{
		g_voteDuration = get_pcvar_num(cvar_voteDuration);
	}
	
	if (get_pcvar_num(cvar_voteStatus) && get_pcvar_num(cvar_voteStatusType) == SHOWSTATUSTYPE_PERCENTAGE)
	{
		copy(g_voteTallyType, sizeof(g_voteTallyType)-1, "%");
	}

	if (get_cvar_num("gal_debug") & 4)
	{
		set_task(2.0, "dbg_fakeVotes");
	}
	
	// make sure the display is contructed from scratch
	g_refreshVoteStatus = true;
	
	// ensure the vote status doesn't indicate expired
	g_voteStatus &= ~VOTE_HAS_EXPIRED;
	
	new arg[3];
	arg[0] = true;
	arg[1] = 0;
	arg[2] = false;
	
	if (get_pcvar_num(cvar_voteStatus) == SHOWSTATUS_VOTE)
	{
		set_task(1.0, "vote_display", _, arg, sizeof(arg), "a", g_voteDuration);
	}
	else
	{
		set_task(1.0, "vote_display", _, arg, sizeof(arg));
	}
}

public vote_display(arg[3])
{
	static allKeys = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0;
	static keys, voteStatus[512], voteTally[16];		
	
	new updateTimeRemaining = arg[0];
	new id = arg[1];

	// dbg code ----
	if (get_realplayersnum())
	{
		new snuff = (id > 0) ? g_snuffDisplay[id] : -1;
		dbg_log(4, "   [votedisplay()] id: %i  updateTimeRemaining: %i  unsnuffDisplay: %i  g_snuffDisplay: %i  g_refreshVoteStatus: %i  g_choiceCnt: %i  len(g_vote): %i  len(voteStatus): %i", arg[1], arg[0], arg[2], snuff, g_refreshVoteStatus, g_choiceCnt, strlen(g_vote), strlen(voteStatus));
	}

	if (id > 0 && g_snuffDisplay[id])
	{
		new unsnuffDisplay = arg[2];
		if (unsnuffDisplay)
		{
			g_snuffDisplay[id] = false;
		}
		else
		{
			return;
		}
	}
	
	new isVoteOver = (updateTimeRemaining == -1 && id == -1);
	new charCnt;

	if (g_refreshVoteStatus || isVoteOver)
	{
		// wipe the previous vote status clean
		voteStatus[0] = 0;
		keys = MENU_KEY_0;
		
		new voteCnt;

		new allowStay = (g_voteStatus & VOTE_IS_EARLY);

		new isRunoff = (g_voteStatus & VOTE_IS_RUNOFF);
		new bool:allowExtend = !allowStay && ((isRunoff && g_choiceCnt == 1) || (!(g_voteStatus & VOTE_FORCED) && !isRunoff && get_cvar_float("mp_timelimit") < get_pcvar_float(cvar_extendmapMax)));
		if (get_cvar_num("gal_debug") & 4)
		{
			allowExtend = !allowStay && ((isRunoff && g_choiceCnt == 1) || (!isRunoff && get_cvar_float("mp_timelimit") < get_pcvar_float(cvar_extendmapMax)));
		}
		
		// add the header
		if (isVoteOver)
		{
			charCnt = formatex(voteStatus, sizeof(voteStatus)-1, "%s%L^n", CLR_YELLOW, LANG_SERVER, "GAL_RESULT");
		}
		else
		{
			charCnt = formatex(voteStatus, sizeof(voteStatus)-1, "%s%L^n", CLR_YELLOW, LANG_SERVER, "GAL_CHOOSE");
		}

		// add maps to the menu
		for (new choiceIdx = 0; choiceIdx < g_choiceCnt; ++choiceIdx)
		{
			voteCnt = g_mapVote[choiceIdx];
			vote_getTallyStr(voteTally, sizeof(voteTally)-1, voteCnt);
			
			charCnt += formatex(voteStatus[charCnt], sizeof(voteStatus)-1-charCnt, "^n%s%i. %s%s%s", CLR_RED, choiceIdx+1, CLR_WHITE, g_mapChoice[choiceIdx], voteTally);
			keys |= (1<<choiceIdx);
		}

		if( isTimeToChangeLevel )
		{
			allowExtend = false;
			allowStay = true;
		}
	
		// add optional menu item
		if ( allowExtend || allowStay )
		{
			// if it's not a runoff vote, add a space between the maps and the additional option
			if (g_voteStatus & VOTE_IS_RUNOFF == 0)
			{
				charCnt += formatex(voteStatus[charCnt], sizeof(voteStatus)-1-charCnt, "^n");
			}
			
			vote_getTallyStr(voteTally, sizeof(voteTally)-1, g_mapVote[g_choiceCnt]);

			if (allowExtend)
			{
				// add the "Extend Map" menu item.
				charCnt += formatex(voteStatus[charCnt], sizeof(voteStatus)-1-charCnt, "^n%s%i. %s%L%s", CLR_RED, g_choiceCnt+1, CLR_WHITE, LANG_SERVER, "GAL_OPTION_EXTEND", g_currentMap, floatround(get_pcvar_float(cvar_extendmapStep)), voteTally);
			}
			else
			{
				// add the "Stay Here" menu item
				charCnt += formatex(voteStatus[charCnt], sizeof(voteStatus)-1-charCnt, "^n%s%i. %s%L%s", CLR_RED, g_choiceCnt+1, CLR_WHITE, LANG_SERVER, "GAL_OPTION_STAY", voteTally);
			}
			
			keys |= (1<<g_choiceCnt);
		}

		// make a copy of the virgin menu
		if (g_vote[0] == 0)
		{
			new cleanCharCnt = copy(g_vote, sizeof(g_vote)-1, voteStatus);
			
			// append a "None" option on for people to choose if they don't like any other choice
			formatex(g_vote[cleanCharCnt], sizeof(g_vote)-1-cleanCharCnt, "^n^n%s0. %s%L", CLR_RED, CLR_WHITE, LANG_SERVER, "GAL_OPTION_NONE");
		}
		
		charCnt += formatex(voteStatus[charCnt], sizeof(voteStatus)-1-charCnt, "^n^n");
		
		g_refreshVoteStatus = false;
	}

	static voteFooter[32];
	if (updateTimeRemaining && get_pcvar_num(cvar_voteExpCountdown))
	{
		charCnt = copy(voteFooter, sizeof(voteFooter)-1, "^n^n");
		
		g_voteDuration--;
		formatex(voteFooter[charCnt], sizeof(voteFooter)-1-charCnt, "%s%L: %s%i", CLR_GREY, LANG_SERVER, "GAL_TIMELEFT", CLR_RED, g_voteDuration);
	}
	
	// create the different displays
	static menuClean[512], menuDirty[512];
	menuClean[0] = 0;
	menuDirty[0] = 0;
	
	formatex(menuClean, sizeof(menuClean)-1, "%s%s", g_vote, voteFooter);
	if (!isVoteOver)
	{
		formatex(menuDirty, sizeof(menuDirty)-1, "%s%s", voteStatus, voteFooter);
	}
	else
	{
		formatex(menuDirty, sizeof(menuDirty)-1, "%s^n^n%s%L", voteStatus, CLR_YELLOW, LANG_SERVER, "GAL_VOTE_ENDED");
	}

	new menuid, menukeys;

	// display the vote
	new showStatus = get_pcvar_num(cvar_voteStatus);
	if (id > 0)
	{
		// optionally display to single player that just voted
		if (showStatus == SHOWSTATUS_VOTE)
		{
			// dbg code ----
			new name[32];
			get_user_name(id, name, 31);
			
			dbg_log(4, "	[%s (dirty, just voted)]", name);
			dbg_log(4, "		%s", menuDirty);
			//--------------

			get_user_menu(id, menuid, menukeys);
			if (menuid == 0 || menuid == g_menuChooseMap)
			{
				show_menu(id, allKeys, menuDirty, max(1, g_voteDuration), MENU_CHOOSEMAP);
			}
		}
	}
	else
	{
		// display to everyone
		new players[32], playerCnt;
		get_players(players, playerCnt, "ch"); // skip bots and hltv

		for (new playerIdx = 0; playerIdx < playerCnt; ++playerIdx)
		{
			id = players[playerIdx];
	
			if (g_voted[id] == false && !isVoteOver)
			{
				// dbg code ----
				if (playerIdx == 0)
				{
					new name[32];
					get_user_name(id, name, 31);
					
					dbg_log(4, "	[%s (clean)]", name);
					dbg_log(4, "		%s", menuClean);
				}				
				//--------------

				get_user_menu(id, menuid, menukeys);
				if (menuid == 0 || menuid == g_menuChooseMap)
				{
					show_menu(id, keys, menuClean, g_voteDuration, MENU_CHOOSEMAP);
				}
			}
			else 
			{
				if ((isVoteOver && showStatus) || (showStatus == SHOWSTATUS_VOTE && g_voted[id]))
				{
					// dbg code ----
					if (playerIdx == 0)
					{
						new name[32];
						get_user_name(id, name, 31);
						
						dbg_log(4, "	[%s (dirty)]", name);
						dbg_log(4, "		%s", menuDirty);
					}				
					//--------------

					get_user_menu(id, menuid, menukeys);
					if (menuid == 0 || menuid == g_menuChooseMap)
					{
						show_menu(id, allKeys, menuDirty, (isVoteOver) ? 5 : max(1, g_voteDuration), MENU_CHOOSEMAP);
					}
				}
			}
			// dbg code ----
			if (id == 1)
			{
				dbg_log(4, "");
			}
			//--------------
		}
	}
}

vote_getTallyStr(voteTally[], voteTallyLen, voteCnt)
{
	if (voteCnt && get_pcvar_num(cvar_voteStatusType) == SHOWSTATUSTYPE_PERCENTAGE)
	{
		voteCnt = percent(voteCnt, g_votesCast);
	}
	
	if (get_pcvar_num(cvar_voteStatus) && voteCnt)
	{
		formatex(voteTally, voteTallyLen, " %s(%i%s)", CLR_GREY, voteCnt, g_voteTallyType);
	}
	else
	{
		voteTally[0] = 0;
	}
}

public vote_expire()
{
	g_voteStatus |= VOTE_HAS_EXPIRED;
	
	// dbg code ----
	if (get_realplayersnum())
	{
		dbg_log(4, "");
		dbg_log(4, "   [VOTE RESULT]");
		new voteTally[16];
		for (new idxChoice = 0; idxChoice <= g_choiceCnt; ++idxChoice)
		{
			vote_getTallyStr(voteTally, sizeof(voteTally)-1, g_mapVote[idxChoice]);
			dbg_log(4, "	  %2i/%3i  %i. %s", g_mapVote[idxChoice], voteTally, idxChoice, g_mapChoice[idxChoice]);
		}	
		dbg_log(4, "");
	}
	//--------------
	
	g_vote[0] = 0;
	
	// determine the number of votes for 1st and 2nd place
	new firstPlaceVoteCnt, secondPlaceVoteCnt, totalVotes;
	for (new idxChoice = 0; idxChoice <= g_choiceCnt; ++idxChoice)
	{
		totalVotes += g_mapVote[idxChoice];

		if (firstPlaceVoteCnt < g_mapVote[idxChoice])
		{
			secondPlaceVoteCnt = firstPlaceVoteCnt;
			firstPlaceVoteCnt = g_mapVote[idxChoice];
		}
		else if (secondPlaceVoteCnt < g_mapVote[idxChoice])
		{
			secondPlaceVoteCnt = g_mapVote[idxChoice];
		}
	}

	// determine which maps are in 1st and 2nd place
	new firstPlace[MAX_MAPS_IN_VOTE + 1], firstPlaceCnt;
	new secondPlace[MAX_MAPS_IN_VOTE + 1], secondPlaceCnt;

	for (new idxChoice = 0; idxChoice <= g_choiceCnt; ++idxChoice)
	{
		if (g_mapVote[idxChoice] == firstPlaceVoteCnt)
		{
			firstPlace[firstPlaceCnt++] = idxChoice;
		}
		else if (g_mapVote[idxChoice] == secondPlaceVoteCnt)
		{
			secondPlace[secondPlaceCnt++] = idxChoice;
		}
	}
	
	// announce the outcome
	new idxWinner;
	if (firstPlaceVoteCnt)
	{
		// start a runoff vote, if needed
		if (get_pcvar_num(cvar_runoffEnabled) && !(g_voteStatus & VOTE_IS_RUNOFF))
		{
			// if the top vote getting map didn't receive over 50% of the votes cast, start runoff vote
			if (firstPlaceVoteCnt <= totalVotes / 2)
			{
				// announce runoff voting requirement
				client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_RUNOFF_REQUIRED");
				if (!(get_pcvar_num(cvar_soundsMute) & SOUND_RUNOFFREQUIRED))
				{
					client_cmd(0, "spk ^"run officer(e40) voltage(e30) accelerating(s70) is required^"");
				}

				// let the server know the next vote will be a runoff
				g_voteStatus |= VOTE_IS_RUNOFF;

				// determine the two choices that will be facing off
				new choice1Idx, choice2Idx;
				if (firstPlaceCnt > 2)
				{
					choice1Idx = random_num(0, firstPlaceCnt - 1);
					choice2Idx = random_num(0, firstPlaceCnt - 1);
					
					if (choice2Idx == choice1Idx)
					{
						choice2Idx = (choice2Idx == firstPlaceCnt - 1) ? 0 : ++choice2Idx;
					}
					
					g_runoffChoice[0] = firstPlace[choice1Idx];
					g_runoffChoice[1] = firstPlace[choice2Idx];
					
					client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_RESULT_TIED1", firstPlaceCnt);
				}
				else if (firstPlaceCnt == 2)
				{
					g_runoffChoice[0] = firstPlace[0];
					g_runoffChoice[1] = firstPlace[1];
				}
				else if (secondPlaceCnt == 1)
				{
					g_runoffChoice[0] = firstPlace[0];
					g_runoffChoice[1] = secondPlace[0];
				}
				else
				{
					g_runoffChoice[0] = firstPlace[0];
					g_runoffChoice[1] = secondPlace[random_num(0, secondPlaceCnt - 1)];
					
					client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_RESULT_TIED2", secondPlaceCnt);
				}
				// clear all the votes
				vote_resetStats();
				
				// start the runoff vote
				set_task(5.0, "vote_startDirector");
				
				return;
			}
		}

		// if there is a tie for 1st, randomly select one as the winner
		if (firstPlaceCnt > 1)
		{
			idxWinner = firstPlace[random_num(0, firstPlaceCnt - 1)];
			client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_WINNER_TIED", firstPlaceCnt);
		}
		else
		{
			idxWinner = firstPlace[0];
		}

		if (idxWinner == g_choiceCnt)
		{
			if (g_voteStatus & VOTE_IS_EARLY)
			{
				// "stay here" won
				client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_WINNER_STAY");

				// clear all the votes
				vote_resetStats();
				
				// no longer is an early vote
				g_voteStatus &= ~VOTE_IS_EARLY;		
			}
			else
			{
				if( isTimeToChangeLevel2 )
				{
					// "stay here" won
					client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_WINNER_STAY");

					if( isTimeToChangeLevel )
					{
						set_task(5.0, "map_change_stays");

						// freeze the game and show the scoreboard
						message_begin(MSG_ALL, SVC_INTERMISSION);
						message_end();
					}
				} else 
				{
					if( isTimeToChangeLevel )
					{
						client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_WINNER_STAY");
					}
					else {
						// "extend map" won
						client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_WINNER_EXTEND", floatround(get_pcvar_float(cvar_extendmapStep)));
						map_extend();
					}
				}
			}
		}
		else 
		{
			map_setNext(g_mapChoice[idxWinner]);
			server_exec();

			client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_NEXTMAP", g_mapChoice[idxWinner]);

			if( isTimeToChangeLevel )
			{
				set_task(5.0, "map_change");

				// freeze the game and show the scoreboard
				message_begin(MSG_ALL, SVC_INTERMISSION);
				message_end();
			}
			g_voteStatus |= VOTE_IS_OVER;
		}
	}
	else
	{
		// the initial nextmap
		new initialNextMap[MAX_MAPNAME_LEN + 1];
		get_cvar_string("amx_nextmap", initialNextMap, sizeof(initialNextMap)-1);

		client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_WINNER_RANDOM", initialNextMap );

		if( isTimeToChangeLevel )
		{
			set_task(5.0, "map_change");

			// freeze the game and show the scoreboard
			message_begin(MSG_ALL, SVC_INTERMISSION);
			message_end();
		}

		g_voteStatus |= VOTE_IS_OVER;
	}
	
	g_refreshVoteStatus = true;

	// vote is no longer in progress
	g_voteStatus &= ~VOTE_IN_PROGRESS;
	vote_resetStats();
}

map_extend()
{
	dbg_log(2, "%32s mp_timelimit: %f  g_rtvWait: %f  extendmapStep: %f", "map_extend(in)", get_cvar_float("mp_timelimit"), g_rtvWait, get_pcvar_float(cvar_extendmapStep));		
	
	// reset the "rtv wait" time, taking into consideration the map extension
	if (g_rtvWait)
	{
		g_rtvWait = get_cvar_float("mp_timelimit") + g_rtvWait;
	} 

	// do that actual map extension
	isTimeLimitChanged = true;
	set_cvar_float("mp_timelimit", get_cvar_float("mp_timelimit") + get_pcvar_float(cvar_extendmapStep));
	server_exec();

	// clear vote stats
	vote_resetStats();
	
	// if we were in a runoff mode, get out of it
	g_voteStatus &= ~VOTE_IS_RUNOFF;
	
	dbg_log(2, "%32s mp_timelimit: %f  g_rtvWait: %f  extendmapStep: %f", "map_extend(out)", get_cvar_float("mp_timelimit"), g_rtvWait, get_pcvar_float(cvar_extendmapStep));		
}

vote_resetStats()
{
//	g_vote[0] = 0;
	g_choiceCnt = 0;
	g_votesCast = 0;
	arrayset(g_mapVote, 0, MAX_MAPS_IN_VOTE + 1);	
	// reset everyones' rocks
	arrayset(g_rockedVote, false, sizeof(g_rockedVote));
	g_rockedVoteCnt	= 0;
	// reset everyones' votes
	// arrayset(g_voted, false, sizeof(g_voted));
}

map_isInMenu(map[])
{
	for (new idxChoice = 0; idxChoice < g_choiceCnt; ++idxChoice)
	{
		if (equal(map, g_mapChoice[idxChoice]))
		{
			return true;
		}
	}
	return false;
}

prefix_isInMenu(map[])
{
	if (get_pcvar_num(cvar_voteUniquePrefixes))
	{
		new tentativePrefix[8], existingPrefix[8], junk[8];
		
		strtok(map, tentativePrefix, sizeof(tentativePrefix)-1, junk, sizeof(junk)-1, '_', 1);
		
		for (new idxChoice = 0; idxChoice < g_choiceCnt; ++idxChoice)
		{
			strtok(g_mapChoice[idxChoice], existingPrefix, sizeof(existingPrefix)-1, junk, sizeof(junk)-1, '_', 1);
			
			if (equal(tentativePrefix, existingPrefix))
			{
				return true;
			}
		}
	}
	return false;
}

map_isTooRecent(map[])
{
	if (get_pcvar_num(cvar_banRecent))
	{
		for (new idxBannedMap = 0; idxBannedMap < g_cntRecentMap; ++idxBannedMap)
		{
			if (equal(map, g_recentMap[idxBannedMap]))
			{
				return true;
			}
		}
	}
	return false;
}

public vote_handleChoice(id, key)
{
	if (g_voteStatus & VOTE_HAS_EXPIRED)
	{
		client_cmd(id, "^"slot%i^"", key + 1);
		return;
	}
	
	g_snuffDisplay[id] = true;
	
	if (g_voted[id] == false)
	{
		new name[32];
		if (get_pcvar_num(cvar_voteAnnounceChoice))
		{
			get_user_name(id, name, sizeof(name)-1);
		}

		// dbg code ----
		get_user_name(id, name, sizeof(name)-1);
		//--------------

		// confirm the player's choice
		if (key == 9)
		{
			dbg_log(4, "	  %-32s (none)", name);

			if (get_pcvar_num(cvar_voteAnnounceChoice))
			{
				client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_CHOICE_NONE_ALL", name);
			}
			else
			{
				client_print(id, print_chat, "%L", id, "GAL_CHOICE_NONE");
			}
		}
		else
		{
			// increment votes cast count
			g_votesCast++;
			
			if (key == g_choiceCnt)
			{
				// only display the "none" vote if we haven't already voted (we can make it here from the vote status menu too)
				if (g_voted[id] == false)
				{
					dbg_log(4, "	  %-32s (extend)", name);

					if (get_pcvar_num(cvar_voteAnnounceChoice))
					{
						client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_CHOICE_EXTEND_ALL", name);
					}
					else
					{
						client_print(id, print_chat, "%L", id, "GAL_CHOICE_EXTEND");
					}
				}
			}
			else
			{
				dbg_log(4, "	  %-32s %s", name, g_mapChoice[key]);

				if (get_pcvar_num(cvar_voteAnnounceChoice))
				{
					client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_CHOICE_MAP_ALL", name, g_mapChoice[key]);
				}
				else
				{
					client_print(id, print_chat, "%L", id, "GAL_CHOICE_MAP", g_mapChoice[key]);
				}
			}
	
			// register the player's choice giving extra weight to admin votes
			new voteWeight = get_pcvar_num(cvar_voteWeight);
			if (voteWeight > 1 && has_flag(id, g_voteWeightFlags))
			{
				g_mapVote[key] += voteWeight;
				g_votesCast += (voteWeight - 1);
				client_print(id, print_chat, "%L", id, "GAL_VOTE_WEIGHTED", voteWeight);
			}
			else
			{
				g_mapVote[key]++;
			}
		}

		g_voted[id] = true;
		g_refreshVoteStatus = true;
	}
	else
	{
		client_cmd(id, "^"slot%i^"", key + 1);
	}
	
	// display the vote again, with status
	if (get_pcvar_num(cvar_voteStatus) == SHOWSTATUS_VOTE)
	{
		new arg[3];
		arg[0] = false;
		arg[1] = id;
		arg[2] = true;

		set_task(0.1, "vote_display", _, arg, sizeof(arg));
		//vote_display(arg);
	}
}

Float:map_getMinutesElapsed()
{
	dbg_log(2, "%32s mp_timelimit: %f", "map_getMinutesElapsed(in/out)", get_cvar_float("mp_timelimit"));		
	return get_cvar_float("mp_timelimit") - (float(get_timeleft()) / 60.0);
}

public vote_rock(id)
{
	// if an early vote is pending, don't allow any rocks
	if (g_voteStatus & VOTE_IS_EARLY)
	{
		client_print(id, print_chat, "%L", id, "GAL_ROCK_FAIL_PENDINGVOTE");
		return;
	}
	
	new Float:minutesElapsed = map_getMinutesElapsed();
	
	// if the player is the only one on the server, bring up the vote immediately
	if (get_realplayersnum() == 1 && minutesElapsed > floatmin(2.0, g_rtvWait))
	{
		vote_startDirector(true);
		return;
	}

	// make sure enough time has gone by on the current map
	if (g_rtvWait)
	{
		if (minutesElapsed < g_rtvWait)
		{
			client_print(id, print_chat, "%L", id, "GAL_ROCK_FAIL_TOOSOON", floatround(g_rtvWait - minutesElapsed, floatround_ceil));
			return;
		}
	}

	// rocks can only be made if a vote isn't already in progress
	if (g_voteStatus & VOTE_IN_PROGRESS)
	{
		client_print(id, print_chat, "%L", id, "GAL_ROCK_FAIL_INPROGRESS");
		return;
	}
	// and if the outcome of the vote hasn't already been determined
	else if (g_voteStatus & VOTE_IS_OVER)
	{
		client_print(id, print_chat, "%L", id, "GAL_ROCK_FAIL_VOTEOVER");
		return;
	}
	
	// determine how many total rocks are needed
	new rocksNeeded = vote_getRocksNeeded();

	// make sure player hasn't already rocked the vote
	if (g_rockedVote[id])
	{
		client_print(id, print_chat, "%L", id, "GAL_ROCK_FAIL_ALREADY", rocksNeeded - g_rockedVoteCnt);
		rtv_remind(TASKID_REMINDER + id);
		return;
	}

	// allow the player to rock the vote
	g_rockedVote[id] = true;
	client_print(id, print_chat, "%L", id, "GAL_ROCK_SUCCESS");

	// make sure the rtv reminder timer has stopped
	if (task_exists(TASKID_REMINDER))
	{
		remove_task(TASKID_REMINDER);
	}

	// determine if there have been enough rocks for a vote yet	
	if (++g_rockedVoteCnt >= rocksNeeded)
	{
		// announce that the vote has been rocked
		client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_ROCK_ENOUGH");

		// start up the vote director 
		vote_startDirector(true);
	}
	else
	{
		// let the players know how many more rocks are needed
		rtv_remind(TASKID_REMINDER);
		
		if (get_pcvar_num(cvar_rtvReminder))
		{
			// initialize the rtv reminder timer to repeat how many rocks are still needed, at regular intervals
			set_task(get_pcvar_float(cvar_rtvReminder) * 60.0, "rtv_remind", TASKID_REMINDER, _, _, "b");
		}
	}
}

vote_unrock(id)
{
	if (g_rockedVote[id])
	{
		g_rockedVote[id] = false;
		g_rockedVoteCnt--;
		// and such
	}
}	

vote_getRocksNeeded()
{
	return floatround(get_pcvar_float(cvar_rtvRatio) * float(get_realplayersnum()), floatround_ceil);
}

public rtv_remind(param)
{
	new who = param - TASKID_REMINDER;
	
	// let the players know how many more rocks are needed
	client_print(who, print_chat, "%L", LANG_PLAYER, "GAL_ROCK_NEEDMORE", vote_getRocksNeeded() - g_rockedVoteCnt);
}

public cmd_listmaps(id)
{
//	new arg1[8];
//	new start = read_argv(1, arg1, 7) ? str_to_num(arg1) : 1;

	map_listAll(id);

	return PLUGIN_HANDLED;
}

// change to the map
public map_change()
{
	// restore the map's timelimit, just in case we had changed it
	map_restoreOriginalTimeLimit();
	
	// grab the name of the map we're changing to	
	new map[MAX_MAPNAME_LEN + 1];
	get_cvar_string("amx_nextmap", map, sizeof(map)-1);

	isTimeToChangeLevel = false;

	// verify we're changing to a valid map
	if (!is_map_valid(map))
	{
		// probably admin did something dumb like changed the map time limit below
		// the time remaining in the map, thus making the map over immediately.
		// since the next map is unknown, just restart the current map.
		copy(map, sizeof(map)-1, g_currentMap);
	}
	server_cmd("changelevel %s", map);
}

public map_change_stays()
{
	isTimeToChangeLevel = false;
	isTimeToChangeLevel2 = false;

	// no longer is an early vote
	g_voteStatus &= ~VOTE_IS_EARLY;

	server_cmd("changelevel %s", g_currentMap);
}


public cmd_HL1_votemap(id)
{
	if (get_pcvar_num(cvar_cmdVotemap) == 0)
	{
		con_print(id, "%L", id, "GAL_DISABLED");
		return PLUGIN_HANDLED;
	}
	return PLUGIN_CONTINUE;
}

public cmd_HL1_listmaps(id)
{
	switch (get_pcvar_num(cvar_cmdListmaps))
	{
		case 0:
		{
			con_print(id, "%L", id, "GAL_DISABLED");
		}
		case 2:
		{
			map_listAll(id);
		}
		default:
		{
			return PLUGIN_CONTINUE;
		}
	}
	return PLUGIN_HANDLED;
}

map_listAll(id)
{
	static lastMapDisplayed[MAX_PLAYER_CNT + 1][2];

	// determine if the player has requested a listing before
	new userid = get_user_userid(id);
	if (userid != lastMapDisplayed[id][LISTMAPS_USERID])
	{
		lastMapDisplayed[id][LISTMAPS_USERID] = 0;
	}

	new command[32];
	read_argv(0, command, sizeof(command)-1);

	new arg1[8], start;
	new mapCount = get_pcvar_num(cvar_listmapsPaginate);

	if (mapCount)
	{
		if (read_argv(1, arg1, sizeof(arg1)-1))
		{
			if (arg1[0] == '*')
			{
				// if the last map previously displayed belongs to the current user,
				// start them off there, otherwise, start them at 1
				if (lastMapDisplayed[id][LISTMAPS_USERID])
				{
					start = lastMapDisplayed[id][LISTMAPS_LAST] + 1;
				}
				else
				{
					start = 1;
				}
			}
			else
			{
				start = str_to_num(arg1);
			}
		}
		else
		{
			start = 1;
		}
	
		if (id == 0 && read_argc() == 3 && read_argv(2, arg1, sizeof(arg1)-1))
		{
			mapCount = str_to_num(arg1);
		}
	}
		
	if (start < 1)
	{
		start = 1;
	}

	if (start >= g_nominationMapCnt)
	{
		start = g_nominationMapCnt - 1;
	}

	new end = mapCount ? start + mapCount - 1 : g_nominationMapCnt;

	if (end > g_nominationMapCnt)
	{
		end = g_nominationMapCnt;
	}

	// this enables us to use 'command *' to get the next group of maps, when paginated
	lastMapDisplayed[id][LISTMAPS_USERID] = userid;
	lastMapDisplayed[id][LISTMAPS_LAST] = end - 1;

	con_print(id, "^n----- %L -----", id, "GAL_LISTMAPS_TITLE", g_nominationMapCnt);

	new nominated[64], nominator_id, name[32], mapName[32], idx;
	for (idx = start - 1; idx < end; idx++)
	{
		nominator_id = nomination_getPlayer(idx);
		if (nominator_id)
		{
			get_user_name(nominator_id, name, sizeof(name)-1);
			formatex(nominated, sizeof(nominated)-1, "%L", id, "GAL_NOMINATEDBY", name);
		}
		else
		{ 
			nominated[0] = 0;
		}
		ArrayGetString(g_nominationMap, idx, mapName, sizeof(mapName)-1);
		con_print(id, "%3i: %s  %s", idx + 1, mapName, nominated);
	}

	if (mapCount && mapCount < g_nominationMapCnt)
	{
		con_print(id, "----- %L -----", id, "GAL_LISTMAPS_SHOWING", start, idx, g_nominationMapCnt);

		if (end < g_nominationMapCnt)
		{
			con_print(id, "----- %L -----", id, "GAL_LISTMAPS_MORE", command, end + 1, command);
		}
	}
}

con_print(id, message[], {Float,Sql,Result,_}:...)
{
	new consoleMessage[256];
	vformat(consoleMessage, sizeof(consoleMessage)-1, message, 3);
	
	if (id)
	{
		new authid[32];
		get_user_authid(id, authid, 31);
		
		if (!equal(authid, "STEAM_ID_LAN"))
		{		
			console_print(id, consoleMessage);
			return;
		}
	}

	server_print(consoleMessage);
}

public client_disconnect(id)
{
	g_voted[id] = false;
		
	// un-rock the vote
	vote_unrock(id);

	// cancel player's nominations
	new playerNominationMax = min(get_pcvar_num(cvar_nomPlayerAllowance), MAX_NOMINATION_CNT);
	new nominatedMaps[256], nominationCnt, idxMap, mapName[32];
	for (new idxNomination = 1; idxNomination <= playerNominationMax; ++idxNomination)
	{
		idxMap = g_nomination[id][idxNomination];
		if (idxMap >= 0)
		{
			ArrayGetString(g_nominationMap, idxMap, mapName, sizeof(mapName)-1);
			nominationCnt++;
			format(nominatedMaps, sizeof(nominatedMaps)-1, "%s%s, ", nominatedMaps, mapName);
			g_nomination[id][idxNomination] = -1;
		}
	}
	if (nominationCnt)
	{
		// strip the extraneous ", " from the string
		nominatedMaps[strlen(nominatedMaps) - 2] = 0;
		
		// inform the masses that the maps are no longer nominated
		nomination_announceCancellation(nominatedMaps);
	}

	new dbg_playerCnt = get_realplayersnum()-1;
	dbg_log(2, "%32s dbg_playerCnt:%i", "client_disconnect()", dbg_playerCnt);
}

public client_connect(id)
{
	vote_unrock(id);
}

public client_putinserver(id)
{
	if ((g_voteStatus & VOTE_IS_EARLY) && !is_user_bot(id) && !is_user_hltv(id))
	{
		set_task(20.0, "srv_announceEarlyVote", id);
	}
}

public srv_announceEarlyVote(id)
{
	if (is_user_connected(id))
	{
		//client_print(id, print_chat, "%L", id, "GAL_VOTE_EARLY");
		new text[101];
		formatex(text, sizeof(text)-1, "^x04%L", id, "GAL_VOTE_EARLY");
		print_color(id, text);
	}
}

nomination_announceCancellation(nominations[])
{
	client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_CANCEL_SUCCESS", nominations);
}

nomination_clearAll()
{
	for (new idxPlayer = 1; idxPlayer <= MAX_PLAYER_CNT; idxPlayer++)
	{
		for (new idxNomination = 1; idxNomination <= MAX_NOMINATION_CNT; idxNomination++)
		{
			g_nomination[idxPlayer][idxNomination] = -1;
		}
	}
	g_nominationCnt = 0;
}

map_announceNomination(id, map[])
{
	new name[32];
	get_user_name(id, name, sizeof(name)-1);
	
	client_print(0, print_chat, "%L", LANG_PLAYER, "GAL_NOM_SUCCESS", name, map);
}

#if AMXX_VERSION_NUM < 180
has_flag(id, flags[])
{
	return (get_user_flags(id) & read_flags(flags));
}
#endif

public sort_stringsi(const elem1[], const elem2[], const array[], data[], data_size)
{
	return strcmp(elem1, elem2, 1);
}

stock get_realplayersnum()
{
	new players[32], playerCnt;
	get_players(players, playerCnt, "ch");
	
	return playerCnt;
}

stock percent(is, of)
{
	return (of != 0) ? floatround(floatmul(float(is)/float(of), 100.0)) : 0;
}

print_color(id, text[])
{
	message_begin(MSG_ONE, get_user_msgid("SayText"), {0, 0, 0}, id);
	write_byte(id);
	write_string(text);
	message_end();
}	

map_restoreOriginalTimeLimit()
{
	dbg_log(2, "%32s mp_timelimit: %f  g_originalTimelimit: %f", "map_restoreOriginalTimeLimit(in)", get_cvar_float("mp_timelimit"), g_originalTimelimit);
	if ( isTimeLimitChanged )
	{	
		server_cmd("mp_timelimit %f", g_originalTimelimit);
		server_exec();
		isTimeLimitChanged = false;
	}
	dbg_log(2, "%32s mp_timelimit: %f  g_originalTimelimit: %f", "map_restoreOriginalTimeLimit(out)", get_cvar_float("mp_timelimit"), g_originalTimelimit);
}

dbg_log(const mode, const text[] = "", {Float,Sql,Result,_}:...)
{	
	new dbg = get_cvar_num("gal_debug");
	if (mode & dbg)
	{
		// format the text as needed
		new formattedText[1024];
		format_args(formattedText, 1023, 1);
		// grab the current game time
		new Float:gameTime = get_gametime();
		// log text to file
		log_to_file("_galileo.log", "{%3.4f} %s", gameTime, formattedText);
		
		if (dbg & 1 && formattedText[0])
		{
			// make quotes in log text palatable to 3rd party chat log viewers
			new isFound = 1;
			while (isFound) isFound = replace(formattedText, 1023, "^"", "'");
			// print to the server log so as to be picked up by programs such as HLSW
			log_message("^"<><><>^" triggered ^"amx_chat^" (text ^"[GAL] %s^")", formattedText);
		}
	}
	// not needed but gets rid of stupid compiler error
	if (text[0] == 0) return;
}
