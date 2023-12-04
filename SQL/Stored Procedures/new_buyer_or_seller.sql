-- Adding new Buyer or Seller Account
CREATE PROCEDURE `byte_bazaar`.`new_buyer_or_seller` (
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
END