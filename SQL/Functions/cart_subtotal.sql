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
    
END