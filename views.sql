-- Number of Sales by Seller
CREATE VIEW sales_by_seller AS
SELECT slr.name AS 'seller_name', COUNT(*) AS 'num_sales'
FROM seller AS slr
JOIN sells AS sls
ON slr.seller_id = sls.seller_id
JOIN product AS p 
ON p.product_id = sls.product_id
JOIN sale AS sa
ON sa.product_id = sls.product_id
GROUP BY slr.name;

-- Shows all account names, usernames and passwords 
CREATE VIEW all_account_info AS 
SELECT b.name AS 'buyer_name', b.username AS 'buyer_username', b.password AS 'buyer_password'
FROM buyer AS b
UNION 
SELECT s.name, s.username, s.password
FROM seller AS s;

-- Seller sells product to buyer on certain datetime
CREATE VIEW sold_to AS 
SELECT slr.seller_id AS 'seller_id', slr.name AS 'seller_name', p.product_id AS 'product_id', b.username AS 'buyer_username', sa.sale_id AS 'sale_id', sa.datetime AS 'sale_date'
FROM seller AS slr
JOIN sells AS sls
ON slr.seller_id = sls.seller_id
JOIN product AS p 
ON sls.product_id = p.product_id
JOIN sale AS sa
ON sa.product_id = p.product_id
JOIN shipment AS sh
ON sa.shipment_id = sh.shipment_id
JOIN buyer AS b
ON sh.buyer_username = b.username;
