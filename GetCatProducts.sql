DELIMITER $$

USE `most_price_list`$$

DROP PROCEDURE IF EXISTS `GetCatProducts`$$

CREATE DEFINER=`kkroot`@`192.168.%.%` PROCEDURE `GetCatProducts`()

BEGIN
	
	SELECT * FROM Products;
    
END$$

DELIMITER ;