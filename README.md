# JSON

INSTRUCTIONS: Replace insert_name_of_db with whatever name you gave the DB.

## Ex1

First run below code to create the JSON culumn to the posts table:

	USE insert_name_of_db;
	ALTER TABLE posts
	ADD column CommentsJsonArr json;

Below code should add the stored procedure:

	USE insert_name_of_db;
	DROP PROCEDURE IF EXISTS denormalizeComments;
	DELIMITER $$
	CREATE PROCEDURE `denormalizeComments` (in postId int(11))
	BEGIN
	UPDATE posts SET
	CommentsJsonArr = (
		SELECT JSON_ARRAYAGG(jsonComments.jsonObj) from (
			SELECT JSON_OBJECT(
				'Id', Id,
				'PostId', PostId,
				'Score', Score,
				'Text', Text,
				'CreationDate', CreationDate,
				'UserId', UserId
			) AS jsonObj
			FROM comments
			WHERE PostId = postId
		) AS jsonComments
	)
	WHERE ID = postId;
	END $$
	DELIMITER ;

## Ex2

Creating the trigger:

	use insert_name_of_db;
	DROP TRIGGER IF EXISTS after_comment_insert;
	DELIMITER $$

	CREATE TRIGGER after_comment_insert
	AFTER INSERT ON comments
	FOR EACH ROW
	BEGIN
		CALL denormalizeComments(NEW.PostId);
	END $$

	DELIMITER ;


	CREATE PROCEDURE `insertComment` (IN id int(11),IN postId int(11),IN userId int(11))
	BEGIN
		INSERT INTO comments
		(`Id`, `PostId`, `UserId`)
		VALUES (id, postId, userId);
		CALL denormalizeComments(postId);
	END $$
	DELIMITER ;






