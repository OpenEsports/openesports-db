/*

	Database Structure 

	DB 1: League of Legends

	Leagues

	Tournaments

	Matches

	Teams

	Players

	
	DB 2: CSGO

	... etc; have each game in a separate database


	Also a DB for Mobile app chat, news

*/


/*

	DB name: leagueoflegends

	`regions`
		(INT) id autoincrement, primary key
		(VARCHAR) short_name  ; eg "NA"
		(VARCHAR) full_name   ; eg "North America"
		(BOOLEAN) is_wildcard ; eg "1"    --[[ other option is BIT(1), probably better performance
	
	`tournaments`
		(INT) id autoincrement, primary key
		(INT) region_id
		(VARCHAR) short_name  ; eg "NA LCS"
		(VARCHAR) full_name   ; eg "League of Legends Championship Series"
		(BOOLEAN) is_pro_regseason --[[ alternatively, have ENUM eg PRO_REGSEASON, PRO_PLAYOFFS, ACADEMY_REGSEASON, ACADEMY_PLAYOFFS
		(BOOLEAN) is_pro_playoffs
		(BOOLEAN) is_academy_regseason
		(BOOLEAN) is_academy_playoffs
		(INT) start_timestamp_expected --[[ Use expected and actual in case of delays rather than just one timestamp
		(INT) start_timestamp_actual
		(INT) end_timestamp_expected
		(INT) end_timestamp_actual
		(BOOLEAN) is_cancelled
		(BOOLEAN) is_live
			
		
	`stream_platform`
		(INT) id autoincrement, primary key
		(VARCHAR) name        ; eg Twitch
			

	`matches`
		(INT) id autoincrement, primary key
		(INT) tournament_id
		(INT) blue_team_id
		(INT) red_team_id
		(INT) winner_id                ; winner_id = the ID of the winning team  --[[ alternatively, use a boolean, 0 = blue, 1 = red
		(INT) start_timestamp_expected
		(INT) start_timestamp_actual
		(INT) end_timestamp_expected
		(INT) end_timestamp_actual
		(BOOLEAN) is_cancelled
		(BOOLEAN) is_live
		(INT) stream_platform_id
		

	`teams`
		(INT) id autoincrement, primary key

	`players`

*/