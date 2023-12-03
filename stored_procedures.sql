DELIMITER $$
  
-- Adding new Buyer or Seller Account
CREATE PROCEDURE `new_buyer_or_seller` (
    IN p_name VARCHAR(50), 
    IN p_username VARCHAR(40), 
    IN p_password VARCHAR(40), 
    IN p_type VARCHAR(6),
    OUT success INT
)
BEGIN
    IF p_type = 'buyer' THEN
        INSERT INTO buyer
        VALUES (p_username, p_name, p_password);
        SET success = 1;
    ELSEIF p_type = 'seller' THEN
        INSERT INTO seller
        VALUES(DEFAULT, p_name, p_username, p_password);
        SET success = 1;
    ELSE
        SET success = 0;
    END IF;
END $$
  
-- Change a user address
CREATE PROCEDURE `change_address` (
    IN p_address_id INT, 
    IN p_street VARCHAR(50), 
    IN p_city VARCHAR(50), 
    IN p_state VARCHAR(50),
    IN p_zip INT
)
BEGIN
    UPDATE address AS a
    SET a.street = p_street, a.city = p_city, a.state = p_state, a.zip = p_zip
    WHERE address_id = p_address_id;
END $$

-- Add an item to buyers cart
CREATE PROCEDURE `add_to_cart` (
    IN p_product_id INT, 
    IN p_username VARCHAR(50),
    IN p_quantity INT
)
BEGIN
	INSERT INTO cart
	VALUES (p_username, p_product_id, p_quantity);
END $$

-- List all products in a category
CREATE PROCEDURE search_products(
	IN p_category_id VARCHAR(50),
    OUT num_products INT
)
BEGIN 
	DECLARE num_products_in_category INT;
    SELECT COUNT(*) INTO num_products_in_category
    FROM product AS p
    WHERE p.category_id = p_category_id;
    
	  SELECT p.product_id, p.name
    FROM product AS p
    WHERE p.category_id = p_category_id;
END $$
  
-- Show previous orders for a buyer or sold items for a seller
CREATE PROCEDURE `show_prev_orders` (
    IN p_id VARCHAR(50), 
    IN p_type VARCHAR(6),
    OUT success INT,
    OUT error_msg VARCHAR(50)
)
BEGIN
    IF p_type = 'buyer' THEN
        SELECT b.username, p.name, p.price, sa.datetime
        FROM buyer AS b
        JOIN shipment AS sh
        ON sh.buyer_username = b.username
		    JOIN sale AS sa
        ON sa.shipment_id = sh.shipment_id
        JOIN product AS p
        ON p.product_id = sa.product_id
        WHERE b.username = p_id;
        SET success = 1;
    ELSEIF p_type = 'seller' THEN
        SELECT slr.name, p.name, p.price, sa.quantity, sa.datetime
		    FROM seller AS slr
		    JOIN sells AS sls
		    ON slr.seller_id = sls.seller_id
		    JOIN product AS p
		    ON p.product_id = sls.product_id
		    JOIN sale AS sa
		    ON p.product_id = sa.product_id
        WHERE slr.seller_id = p_id;
        SET success = 1;
    ELSE
        SET success = 0;
        SET error_msg = 'Invalid user type.';
    END IF;
END $$

-- Show all reviews for a product
CREATE PROCEDURE `display_reviews` (
    IN p_product_id VARCHAR(50)
)
BEGIN
    SELECT r.buyer_username, p.name, p.price,r.rating, r.text
	FROM review AS r
	JOIN product AS p
	ON r.product_id = p.product_id
    WHERE p.product_id = p_product_id;
END $$
DELIMITER ;
