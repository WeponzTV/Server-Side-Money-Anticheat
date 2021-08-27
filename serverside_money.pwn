#include <a_samp>

forward OnPlayerHackMoney();

enum player_data
{
	player_money
};
new PlayerData[MAX_PLAYERS][player_data];

stock GivePlayerMoneyEx(playerid, amount)
{
    PlayerData[playerid][player_money] += amount;
	return GivePlayerMoney(playerid, amount);
}

#if defined _ALS_GivePlayerMoney
    #undef GivePlayerMoney
#else
    #define _ALS_GivePlayerMoney
#endif

#define GivePlayerMoney GivePlayerMoneyEx

main() {}

public OnGameModeInit()
{
	SetTimer("OnPlayerHackMoney", 1000, true);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    PlayerData[playerid][player_money] = 0;
	return 1;
}

public OnPlayerHackMoney()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i))
	    {
	        //Money Check
	        if(GetPlayerMoney(i) != PlayerData[i][player_money])
	        {
	            new money = PlayerData[i][player_money];

	            PlayerData[i][player_money] = 0;

	            ResetPlayerMoney(i);

	            GivePlayerMoney(i, money);
	        }
	    }
	}
	return 1;
}


