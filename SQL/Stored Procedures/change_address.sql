-- Change a user address
CREATE PROCEDURE `byte_bazaar`.`change_address` (
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
END