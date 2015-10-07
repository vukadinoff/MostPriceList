DELIMITER $$

USE `most_price_list`$$

DROP PROCEDURE IF EXISTS `GetCatProducts`$$

CREATE DEFINER=`kkroot`@`192.168.%.%` PROCEDURE `getCatProducts`(IN CategoryID INT,Rate FLOAT)
BEGIN	
	SELECT p.id AS ProductID,
	p.name AS ProductName,
	p.price_1 AS Price1,
	p.price_2 AS Price2,
	p.price_2*Rate AS Price2lv,
	p.price_2*Rate+(p.price_2*Rate*0.2) AS Price2lvDDS
	FROM Products p
	JOIN Category c ON (c.id = p.category_id)
	WHERE c.id = CategoryID;
    END$$

DELIMITER ;