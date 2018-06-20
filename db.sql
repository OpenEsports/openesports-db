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

	`leagues`
		(INT) id autoincrement
		(VARCHAR) region      ; eg "North America"
		(VARCHAR) short_name  ; eg "NA LCS"
		(VARCHAR) full_name   ; eg League of Legends Championship Series
		(BOOLEAN) is_wildcard ; eg "1"    --[[ other option is BIT(1), probably better performance
		
	
	`tournaments`

	`matches`

	`teams`

	`players`

*/