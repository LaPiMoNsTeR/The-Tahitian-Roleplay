#include <a_samp>
#include <database/a_mysql>
#include <database/connection>
#include <lib/streamer>
#include <lib/sscanf2>
#include <lib/zcmd>

new sql;



enum pData
{
	NAME[31],
	MONEY
};

new p[MAX_PLAYERS][pData];

main()
{
	print("\n----------------------------------");
	print(" the tahitian roleplay");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	
	sql = mysql_connect(SQL_HOST, SQL_USER, SQL_DATABASE, SQL_PASSWORD);
	if(mysql_errno() != 0)
	    printf("[SQL] Connexion à la base de données %s échoué.", SQL_DATABASE);
	else
		printf("[SQL] Connexion à la base de données %s ok.", SQL_DATABASE);
	
	return 1;
}

public OnGameModeExit()
{
	mysql_close();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	new query[128];
	GetPlayerName(playerid, p[playerid][NAME], MAX_PLAYER_NAME);
	mysql_format(sql, query, sizeof(query), "SELECT * FROM users WHERE user_name='%e'", p[playerid][NAME]);
	mysql_tquery(sql, query, "OnPlayerDataLoaded", "d", playerid);
	
	SendFormattedMessage(playerid, 0xFFFFFFFF, "Bienvenue %s !", p[playerid][NAME]);
	return 1;
}

forward OnPlayerDataLoaded(playerid);
public OnPlayerDataLoaded(playerid)
{
	printf("Chargement des données de %s ...", p[playerid][NAME]);
	
	new query[128];
    if(cache_get_row_count() == 0)
    {
		mysql_format(sql, query, sizeof(query), "INSERT INTO users(user_name, user_money) VALUES('%s', %d)", p[playerid][NAME], 1000);
		mysql_tquery(sql, query);

		printf("Création de l'utilisateur %s...", p[playerid][NAME]);

		p[playerid][MONEY] = 1000;
    }
    else
    {
        cache_get_field_content(0, "user_money", p[playerid][MONEY]);
    }
    printf("Chargement des données de %s terminé.", p[playerid][NAME]);

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

CMD:money(playerid, params[])
{
	new targetid;
	if(sscanf(params, "u", targetid))
	{
	    SendFormattedMessage(playerid, 0xFFFFFFFF, "Vous avez %d d'argent.", p[playerid][MONEY]);
	}
	else if(targetid == INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid, 0xFFFFFFFF, "Joueur introuvable.");
	}
	else
	{
	    SendFormattedMessage(playerid, 0xFFFFFFFF, "%s a %d d'argent.", p[targetid][NAME], p[targetid][MONEY]);
	}
	return 1;
}

CMD:v(playerid, params[])
{
	new vModel, Float:loc[4];
	if(sscanf(params, "i", vModel))
	{
	
	}
	else if(vModel < 400 || vModel > 611)
	{
		SendClientMessage(playerid, 0xFFFFFFFF, "Ce vehicule n'existe pas.");
	}
	else
	{
	    GetPlayerPos(playerid, loc[0], loc[1], loc[2]);
	    GetPlayerFacingAngle(playerid, loc[3]);
	    CreateVehicle(vModel, loc[0], loc[1], loc[2], loc[3], 0, 0, 0);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}




stock SendFormattedMessage(playerid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[255]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 255
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
}
