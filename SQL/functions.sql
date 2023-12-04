-- TODO: Split and add to DB
DELIMITER $$

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

END $$

CREATE FUNCTION revenue_by_seller(
	p_seller_id INT
)
RETURNS DECIMAL(20, 2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN 
	DECLARE total_revenue DECIMAL(20, 2);

	SELECT SUM(p.price * sa.quantity) INTO total_revenue
	FROM seller AS slr
	JOIN sells AS sls
	ON slr.seller_id = sls.seller_id
	JOIN product AS p
	ON p.product_id = sls.product_id
	JOIN sale AS sa
	ON sa.product_id = p.product_id
	GROUP BY slr.seller_id
    HAVING slr.seller_id = p_seller_id;

	RETURN total_revenue;

END $$

CREATE FUNCTION cart_subtotal(
	p_username VARCHAR(40)
)
RETURNS DECIMAL(20, 2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN 
	DECLARE total_cost DECIMAL(20, 2);

	SELECT SUM(c.quantity * p.price) INTO total_cost
	FROM cart AS c
	JOIN product AS p
	ON p.product_id = c.product_id
	GROUP BY c.buyer_username
    HAVING c.buyer_username = p_username;

	RETURN total_cost;
    
END $$

DELIMITER $$

CREATE FUNCTION avg_rating(
	p_product_id INT
)
RETURNS DECIMAL(20, 2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN 
	DECLARE avg_rating DECIMAL(20, 2);

	SELECT AVG(r.rating) INTO avg_rating
	FROM review AS r
	GROUP BY r.product_id
    HAVING r.product_id = p_product_id;

	RETURN avg_rating;

END $$

DELIMITER ;
