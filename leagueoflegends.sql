/*

	`regions`
		(UNSIGNED INT) id autoincrement, primary key
		(VARCHAR) short_name  ; eg "NA"
		(VARCHAR) full_name   ; eg "North America"
		(BOOLEAN) is_wildcard ; eg "1"    --[[ other option is BIT(1), probably better performance

	`champions`
	(UNSIGNED INT 5) id autoincrement, primary key    ; --[[maybe INT 4, Riot would have to release 9 champions per year for the next 100 years to exceed INT 4

	`items`

	`summoner_spells`
		(UNSIGNED INT) id autoincrement, primary key
		(VARCHAR) spell_name
	
	`tournaments`
		(UNSIGNED INT) id autoincrement, primary key
		(UNSIGNED INT) region_id
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
			
	`matches`
		(UNSIGNED INT) id autoincrement, primary key
		(UNSIGNED INT) tournament_id
		(UNSIGNED INT) blue_team_id
		(UNSIGNED INT) red_team_id
		(UNSIGNED INT) winner_id                ; winner_id = the ID of the winning team  --[[ alternatively, use an ENUM [BLUE, RED, FALSE] where false is the match is undecided / in progress
		(INT) start_timestamp_expected
		(INT) start_timestamp_actual
		(INT) end_timestamp_expected
		(INT) end_timestamp_actual
		(BOOLEAN) is_cancelled
		(BOOLEAN) is_live
		(BOOLEAN) is_paused
		(UNSIGNED INT) stream_platform_id

	`matchdata_final`
		(UNSIGNED INT) id autoincrement, primary key
		(UNSIGNED INT) match_id
		(UNSIGNED INT) blue_gold
		(UNSIGNED INT) blue_kills
		(UNSIGNED INT) blue_turrets --[[ todo, include which turrets were destroyed, display in app both live and final, also add inhib data
		(UNSIGNED INT) blue_drakes --[[ todo, include drake type
		(UNSIGNED INT) blue_elders
		(UNSIGNED INT) blue_heralds
		(UNSIGNED INT) blue_barons
		(UNSIGNED INT) red_gold
		(UNSIGNED INT) red_kills
		(UNSIGNED INT) red_turrets --[[ todo, include which turrets were destroyed, display in app both live and final, also add inhib data
		(UNSIGNED INT) red_drakes --[[ todo, include drake type
		(UNSIGNED INT) red_elders
		(UNSIGNED INT) red_heralds
		(UNSIGNED INT) red_barons
		(UNSIGNED INT) red_ban0
		(UNSIGNED INT) red_ban1
		(UNSIGNED INT) red_ban2
		(UNSIGNED INT) red_ban3
		(UNSIGNED INT) red_ban4
		(UNSIGNED INT) blue_ban0
		(UNSIGNED INT) blue_ban1
		(UNSIGNED INT) blue_ban2
		(UNSIGNED INT) blue_ban3
		(UNSIGNED INT) blue_ban4

	--[[ todo: `matchdata_events`, eg player takes turret, player1 kills player2, etc

	`matchdata_live`
		(UNSIGNED INT) id autoincrement, primary key
		(UNSIGNED INT) match_id
		(UNSIGNED INT) blue_gold
		(UNSIGNED INT) blue_kills
		(UNSIGNED INT) blue_turrets --[[ todo, include which turrets were destroyed, display in app both live and final, also add inhib data
		(UNSIGNED INT) blue_drakes --[[ todo, include drake type
		(UNSIGNED INT) blue_elders
		(UNSIGNED INT) blue_heralds
		(UNSIGNED INT) blue_barons
		(UNSIGNED INT) red_gold
		(UNSIGNED INT) red_kills
		(UNSIGNED INT) red_turrets --[[ todo, include which turrets were destroyed, display in app both live and final, also add inhib data
		(UNSIGNED INT) red_drakes --[[ todo, include drake type
		(UNSIGNED INT) red_elders
		(UNSIGNED INT) red_heralds
		(UNSIGNED INT) red_barons
		(UNSIGNED INT) game_seconds            ; seconds since match start, in-game time, excluding pauses
		(BOOLEAN) baron_alive         ; 0 = dead or has not spawned yet
		(BOOLEAN) herald_alive        ;
		(BOOLEAN) drake_alive         ;
		(ENUM [RED, BLUE, FALSE]) baron_buff
		(ENUM [RED, BLUE, FALSE]) herald_buff ; which team has herald buff
		(ENUM [RED, BLUE, FALSE]) herald_map ; is the herald on the map, if so, which team
		(ENUM [CLOUD,OCEAN,INFERNO, MOUNTAIN, FALSE]) next_drake    ; false = unknown
		(ENUM [CLOUD,OCEAN,INFERNO, MOUNTAIN, FALSE]) active_drake  ; false = drake has not spawned or is dead
		(UNSIGNED INT) red_ban0
		(UNSIGNED INT) red_ban1
		(UNSIGNED INT) red_ban2
		(UNSIGNED INT) red_ban3
		(UNSIGNED INT) red_ban4
		(UNSIGNED INT) blue_ban0
		(UNSIGNED INT) blue_ban1
		(UNSIGNED INT) blue_ban2
		(UNSIGNED INT) blue_ban3
		(UNSIGNED INT) blue_ban4

	`matchdata_team_live` --[[ maybe rename this
		(UNSIGNED INT) id autoincrement, primary key
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
		(UNSIGNED INT) id autoincrement, primary key
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
		(INT) summoner_spell0              ; id of summoner spell 0
		(BOOLEAN) summoner_spell0_cd       ; if summoner spell 0 is on cd
		(INT) summoner_spell1              ; id of summoner  spell 1
		(BOOLEAN) summoner_spell1_cd       ; if summoner spell 0 is on cd
		(INT) total_damage --[[ add more detailed stats such as damage to turrets, damage to champions, damage taken, etc
	
	`match_playerdata_live`
		(UNSIGNED INT) id autoincrement, primary key
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
		(BOOLEAN) trinket
		--[[ add when will item be off CD
		(INT) summoner_spell0              ; id of summoner spell 0
		(BOOLEAN) summoner_spell0_cd       ; if summoner spell 0 is on cd
		(INT) summoner_spell1              ; id of summoner  spell 1
		(BOOLEAN) summoner_spell1_cd       ; if summoner spell 0 is on cd
		
		(INT) damage --[[ add more detailed stats such as damage to turrets, damage to champions, damage taken, etc
		

	`teams`
		(UNSIGNED INT) id autoincrement, primary key
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