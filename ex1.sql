use stackoverflow;
DROP VIEW IF EXISTS postInfoView;
CREATE VIEW postInfoView AS
SELECT
users.DisplayName AS userName,
posts. postText,
postScore
FROM posts INNER JOIN users ON posts.OwnerUserId = users.Id

DROP PROCEDURE IF EXISTS createQAMatView;
DELIMITER $$
CREATE PROCEDURE `createMatView` (IN id int(11),IN postId int(11),IN userId int(11))
BEGIN
	DROP TABLE IF EXISTS qa_mat_view;
	CREATE TABLE qa_mat_view(
		Question JSON,
		Answer JSON
    );
     
END $$
DELIMITER ;


INSERT INTO qa_mat_view (`Question`, `Answer`)
SELECT question, answer 
FROM ()


SELECT 