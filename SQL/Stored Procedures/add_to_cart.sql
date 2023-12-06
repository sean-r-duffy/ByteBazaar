-- Add an item to buyers cart
CREATE PROCEDURE `byte_bazaar`.`add_to_cart` (
    IN p_product_id INT, 
    IN p_username VARCHAR(50),
    IN p_quantity INT
)
BEGIN
	INSERT INTO cart
	VALUES (p_username, p_product_id, p_quantity);
END