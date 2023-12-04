-- Show previous orders for a buyer or sold items for a seller
CREATE PROCEDURE `byte_bazaar`.`show_prev_orders` (
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
END
