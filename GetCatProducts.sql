DELIMITER $$

USE `most_price_list`$$

DROP PROCEDURE IF EXISTS `GetCatProducts`$$

CREATE DEFINER=`kkroot`@`192.168.%.%` PROCEDURE `getCatProducts`(IN CategoryID INT)
BEGIN
	SELECT p.category_id,
	p.name,
	p.price_1,
	p.price_2
	FROM Products p
	JOIN Category c ON (c.id = p.category_id)
	WHERE c.id = CategoryID;
    END$$

DELIMITER ;