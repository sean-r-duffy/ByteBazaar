CREATE FUNCTION get_inventory(
	p_product_id INT
)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN 
	DECLARE product_inventory INT;

	SELECT SUM(p.inventory) INTO product_inventory
	FROM product AS p 
	WHERE p.product_id = p_product_id;

	RETURN product_inventory;

END