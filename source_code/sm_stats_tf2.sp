#pragma semicolon 1
#pragma newdecls required
#pragma tabsize 0
#define Version "1.0.0@testing1"
#define VersionAlt "v" ... Version
#define MaxPlayers 65 // 101 cuz -unrestricted_maxplayers ?
#define MaxItemDef 30758 // will later be updated to use indexes instead of itemdef
#define GameType "tf2"
#define core_chattag "[SM Stats: TF2]"
#define core_chattag2 "SM Stats: TF2"

#define load_plugin_core
#define load_menus
#define load_forwards
#define load_players
#define updater_info
#define updater_gamestats

#define sql_loadtable_playerlist
#define sql_loadtable_weapons
#define sql_loadtable_kill_log
#define sql_loadtable_item_log
#define sql_loadtable_maps_log
//#define sql_loadtable_achievements
#define sql_loadtable_settings

#define query_error_uniqueid_CP_OnCapturedPoint 1
#define query_error_uniqueid_CP_OnCaptureBlocked 2
#define query_error_uniqueid_CTF_OnFlagPickedUp 3
#define query_error_uniqueid_CTF_OnFlagStolen 4
#define query_error_uniqueid_CTF_OnFlagCaptured 5
#define query_error_uniqueid_CTF_OnFlagDefended 6
#define query_error_uniqueid_CTF_OnFlagDropped 7
#define query_error_uniqueid_OnPlayerUbercharged 8
#define query_error_uniqueid_OnPlayerUsedTeleporter 9
#define query_error_uniqueid_OnPlayerTeleported 10
#define query_error_uniqueid_OnPlayerStealSandvich 11
#define query_error_uniqueid_OnPlayerStunned 12
#define query_error_uniqueid_Halloween_OnHHHFragged 13
#define query_error_uniqueid_Halloween_OnMonoculusFragged 14
#define query_error_uniqueid_Halloween_OnMerasmusFragged 15
#define query_error_uniqueid_Halloween_OnSkeletonKingFragged 16
#define query_error_uniqueid_Halloween_OnMonoculusStunned 17
#define query_error_uniqueid_Halloween_OnMerasmusStunned 18
#define query_error_uniqueid_OnRobotsFragged 52
#define query_error_uniqueid_OnPlayerExtinguished 54
#define query_error_uniqueid_OnPlayerJarated 57
#define query_error_uniqueid_OnPlayerMilked 58
#define query_error_uniqueid_OnPlayerGasPassed 59
#define query_error_uniqueid_MvM_OnBombResetted 60
#define query_error_uniqueid_MvM_OnSentryBusterFragged 61
#define query_error_uniqueid_MvM_OnTankDestroyed 62
#define query_error_uniqueid_PassBall_Get 71
#define query_error_uniqueid_PassBall_Score 72
#define query_error_uniqueid_PassBall_Dropped 73
#define query_error_uniqueid_PassBall_Catched 74
#define query_error_uniqueid_PassBall_Stolen 75
#define query_error_uniqueid_PassBall_Blocked 76
#define query_error_uniqueid_OnUpdateDamageDone 79
#define query_error_uniqueid_UpdatePlayTime 80
#define query_error_uniqueid_UpdateMapTimeInserting 81
#define query_error_uniqueid_UpdateMapTimeUpdating 82
#define query_error_uniqueid_UpdateMapTimeUpdatingSeconds 83
#define query_error_uniqueid_OnPlayerNameUpdate 84
#define query_error_uniqueid_OnPlayerDisconnectUpdateLastConnected 85
#define query_error_uniqueid_OnPlayerDisconnectUpdatePlayTime 86
#define query_error_uniqueid_OnUpdatedMenuSettingValue 87

SMStats_TF2GameInfo g_Game[MaxPlayers+1];

#include <sm_stats>
#include <sm_stats_core>
#include <tf2_stocks>

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	char gamefolder[16];
	GetGameFolderName(gamefolder, sizeof(gamefolder));
	
	if(!StrEqual(gamefolder, "tf"))
	{
		SetFailState("This SM Stats game addon may only be running in:"
		... "\nTeam Fortress 2."
		);
	}
	
	CreateNative("SMStats.Native_GetPlayerSessionInfo", Native_GetPlayerSessionInfo);
	CreateNative("_sm_stats_detect_ban_player_auth", Native_BanPlayer_Auth);
	CreateNative("_sm_stats_detect_ban_player_ip", Native_BanPlayer_IPAddress);
	
	return APLRes_Success;
}

public Plugin myinfo =
{
	name = "SM Stats: Team Fortress 2",
	author = "teamkiller324",
	description = "Tracks frags, maps, events, achievements, etc.",
	version = Version,
	url = "https://github.com/Teamkiller324/SMStats"
}

#include "sm_stats_tf2/menus.sp"
#include "sm_stats_tf2/functions.sp"
#include "sm_stats_tf2/game.sp"

#include "sm_stats/functions.sp"
#include "sm_stats/damage_done.sp"
#include "sm_stats/natives.sp"
#include "sm_stats/assister.sp"
#include "sm_stats/forwards.sp"

// updater
#define UpdaterURL "https://raw.githubusercontent.com/Teamkiller324/SMStats/main/sm_updater/SMStats_TF2.txt"
#include "sm_stats/updater.sp"