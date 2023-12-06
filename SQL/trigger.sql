-- Empty Cart Trigger
CREATE TRIGGER empty_cart 
AFTER INSERT ON shipment
FOR EACH ROW 
BEGIN 
	DELETE FROM cart
    WHERE cart.buyer_username = NEW.buyer_username;
END
