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

END