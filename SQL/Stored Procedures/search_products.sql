-- TODO: Test
-- List all products in a category
CREATE PROCEDURE `byte_bazaar`.`search_products`(
	IN p_category_id VARCHAR(50),
    OUT num_products INT
)
BEGIN 
	DECLARE num_products_in_category INT;
    SELECT COUNT(*) INTO num_products_in_category
    FROM product AS p
    WHERE p.category_id = p_category_id;
    
	  SELECT *
    FROM product AS p
    WHERE p.category_id = p_category_id;
END