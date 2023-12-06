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

END