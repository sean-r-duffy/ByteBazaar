-- Show all reviews for a product
CREATE PROCEDURE `byte_bazaar`.`display_reviews` (
    IN p_product_id VARCHAR(50)
)
BEGIN
    SELECT r.buyer_username, p.name, p.price,r.rating, r.text
	FROM review AS r
	JOIN product AS p
	ON r.product_id = p.product_id
    WHERE p.product_id = p_product_id;
END