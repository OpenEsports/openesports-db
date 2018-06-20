/*

	`articles`
		(UNSIGNED INT) id autoincrement, primary key
	
	
	`message`
		(UNSIGNED INT) id autoincrement, primary key
		(UNSIGNED INT) article_id
		(UNSIGNED INT) account_id
		(VARCHAR) message

	`accounts`
		(UNSIGNED INT) id autoincrement, primary key

	`devices`
		(UNSIGNED INT) id autoincrement, primary key
		(UNSIGNED INT) account_id
		(UNSIGNED INT) unique_id
	