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

	`champions`

	`items`
	
	`tournaments`
		(INT) id autoincrement, primary key
		(INT) region_id
		(VARCHAR) short_name  ; eg "NA LCS"
		(VARCHAR) full_name   ; eg "League of Legends Championship Series"
		(VARCHAR) logo_url
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
			
		
	`stream_platform` --[[ this is shared with other games, reorganize. create separate DB with shared data between games
		(INT) id autoincrement, primary key
		(VARCHAR) name        ; eg Twitch
			
	`matches`
		(INT) id autoincrement, primary key
		(INT) tournament_id
		(INT) blue_team_id
		(INT) red_team_id
		(INT) winner_id                ; winner_id = the ID of the winning team  --[[ alternatively, use an ENUM [BLUE, RED, FALSE] where false is the match is undecided / in progress
		(INT) start_timestamp_expected
		(INT) start_timestamp_actual
		(INT) end_timestamp_expected
		(INT) end_timestamp_actual
		(BOOLEAN) is_cancelled
		(BOOLEAN) is_live
		(BOOLEAN) is_paused
		(INT) stream_platform_id

	`matchdata_final`
		(INT) id autoincrement, primary key
		(INT) match_id
		(INT) blue_gold
		(INT) blue_kills
		(INT) blue_turrets --[[ todo, include which turrets were destroyed, display in app both live and final, also add inhib data
		(INT) blue_drakes --[[ todo, include drake type
		(INT) blue_elders
		(INT) blue_heralds
		(INT) blue_barons
		(INT) red_gold
		(INT) red_kills
		(INT) red_turrets --[[ todo, include which turrets were destroyed, display in app both live and final, also add inhib data
		(INT) red_drakes --[[ todo, include drake type
		(INT) red_elders
		(INT) red_heralds
		(INT) red_barons

	--[[ todo: `matchdata_events`, eg player takes turret, player1 kills player2, etc

	`matchdata_live`
		(INT) id autoincrement, primary key
		(INT) match_id
		(INT) blue_gold
		(INT) blue_kills
		(INT) blue_turrets --[[ todo, include which turrets were destroyed, display in app both live and final, also add inhib data
		(INT) blue_drakes --[[ todo, include drake type
		(INT) blue_elders
		(INT) blue_heralds
		(INT) blue_barons
		(INT) red_gold
		(INT) red_kills
		(INT) red_turrets --[[ todo, include which turrets were destroyed, display in app both live and final, also add inhib data
		(INT) red_drakes --[[ todo, include drake type
		(INT) red_elders
		(INT) red_heralds
		(INT) red_barons
		(INT) game_seconds            ; seconds since match start, in-game time, excluding pauses
		(BOOLEAN) baron_alive         ; 0 = dead or has not spawned yet
		(BOOLEAN) herald_alive        ;
		(BOOLEAN) drake_alive         ;
		(ENUM [RED, BLUE, FALSE]) baron_buff
		(ENUM [RED, BLUE, FALSE]) herald_buff ; which team has herald buff
		(ENUM [RED, BLUE, FALSE]) herald_map ; is the herald on the map, if so, which team
		(ENUM [CLOUD,OCEAN,INFERNO, MOUNTAIN, FALSE]) next_drake    ; false = unknown
		(ENUM [CLOUD,OCEAN,INFERNO, MOUNTAIN, FALSE]) active_drake  ; false = drake has not spawned or is dead

	`matchdata_team_live` --[[ maybe rename this
		(INT) id autoincrement, primary key
		(INT) match_id
		(INT) team_id
		(BOOLEAN) turret_outer_top    ; 0 = turret is dead --[[ todo: handle azir turrets
		(BOOLEAN) turret_outer_mid --[[ todo: handle azir turrets
		(BOOLEAN) turret_outer_bot --[[ todo: handle azir turrets
		(BOOLEAN) turret_inner_top    ; 0 = turret is dead --[[ todo: handle azir turrets
		(BOOLEAN) turret_inner_mid --[[ todo: handle azir turrets
		(BOOLEAN) turret_inner_bot --[[ todo: handle azir turrets
		(BOOLEAN) turret_inhib_top    ; 0 = turret is dead --[[ todo: handle azir turrets
		(BOOLEAN) turret_inhib_mid --[[ todo: handle azir turrets
		(BOOLEAN) turret_inhib_bot --[[ todo: handle azir turrets
		(BOOLEAN) turret_nexus_top    ; 0 = turret is dead --[[ todo: handle azir turrets
		(BOOLEAN) turret_nexus_bot --[[ todo: handle azir turrets
		(BOOLEAN) inhib_top          ; 0 = inhib is dead --[[ todo: handle azir turrets
		(BOOLEAN) inhib_mid
		(BOOLEAN) inhib_bot

	`match_playerdata_final`
		(INT) id autoincrement, primary key
		(INT) match_id
		(INT) player_id
		(ENUM:[top,jg,mid,bot,support]) role
		(INT) cs
		(INT) kills
		(INT) assists
		(INT) deaths
		(INT) gold
		(INT) item_slot0 ; id of item in this slot
		(INT) item_slot1
		(INT) item_slot2
		(INT) item_slot3
		(INT) item_slot4
		(INT) item_slot5
		(INT) trinket
		(INT) total_damage --[[ add more detailed stats such as damage to turrets, damage to champions, damage taken, etc
	
	`match_playerdata_live`
		(INT) id autoincrement, primary key
		(INT) recent_update           ; timestamp of most recent update
		(INT) match_id
		(INT) player_id
		(ENUM:[top,jg,mid,bot,support]) role
		(INT) cs
		(INT) kills
		(INT) assists
		(INT) deaths
		(BOOLEAN) is_alive            ; if player is dead or alive
		(SIGNED INT) gold             ; gold in inventory
		(UNSIGNED INT) total_gold     ; total gold gained
		(INT) item_slot0 ; id of item in this slot
		(INT) item_slot1
		(INT) item_slot2
		(INT) item_slot3
		(INT) item_slot4
		(INT) item_slot5
		(BOOLEAN) item_slot0_cd       ; if item is on cooldown
		(BOOLEAN) item_slot1_cd
		(BOOLEAN) item_slot2_cd
		(BOOLEAN) item_slot3_cd
		(BOOLEAN) item_slot4_cd
		(BOOLEAN) item_slot5_cd
		--[[ add when will item be off CD
		(BOOLEAN) trinket
		(INT) damage --[[ add more detailed stats such as damage to turrets, damage to champions, damage taken, etc
		

	`teams`
		(INT) id autoincrement, primary key
		(VARCHAR) short_name         ; eg "C9"
		(VARCHAR) full_name          ; eg "Cloud 9"
		(VARCHAR) logo_url           ;
		(INT) region_id              ; team local region ID
		(INT) starter_top            ; Player ID for starting top laner 
		(INT) starter_jg             ; Player ID for starting top laner --[[ maybe replace with recent player? maybe have starter and recent? in a case like C9 when they start Keith/Zeyzal bot then switch back to Sneaky/Smoothie for the rest of the season, it would probably make more sense to show Sneaky/Smoothie instead of Keith/Zeyzal for C9's bot lane.
		(INT) starter_mid            ; Player ID for starting mid laner
		(INT) starter_bot            ; Player ID for starting bot laner
		(INT) starter_support        ; Player ID for starting support

	`players`

*/