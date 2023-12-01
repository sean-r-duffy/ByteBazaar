
-- SQL script to insert address records into the address table

INSERT INTO address (address_id, buyer_id, street, city, state, zip) VALUES
(1, 1, '123 Main St', 'Springfield', 'StateA', 12345),
(2, 1, '456 Oak Rd', 'Hilltown', 'StateB', 23456),
(3, 2, '789 Pine Ave', 'Laketown', 'StateC', 34567),
(4, 3, '101 Maple Ln', 'Rivertown', 'StateD', 45678),
(5, 3, '202 Elm St', 'Mountainview', 'StateE', 56789),
(6, 4, '303 Birch Blvd', 'Coastal City', 'StateF', 67890),
(7, 5, '404 Cedar Ct', 'Desertville', 'StateG', 78901),
(8, 6, '505 Dogwood Dr', 'Rainy City', 'StateH', 89012),
(9, 7, '606 Fir Pl', 'Sunnytown', 'StateI', 90123),
(10, 8, '707 Grove Way', 'Windy City', 'StateJ', 10234),
(11, 9, '808 Hawthorn Path', 'Cloudyville', 'StateK', 20345),
(12, 10, '909 Ivy Rd', 'Snowy City', 'StateL', 30456),
(13, 1, '1110 Jasmine Ave', 'Misty Town', 'StateM', 12345),
(14, 2, '1211 Kudzu Blvd', 'Foggyville', 'StateN', 23456),
(15, 4, '1312 Larch Ln', 'Chilly City', 'StateO', 34567),
(16, 6, '1413 Magnolia St', 'Warmtown', 'StateP', 45678),
(17, 7, '1514 Nectarine Ct', 'Hot City', 'StateQ', 56789),
(18, 8, '1615 Olive Dr', 'Humidtown', 'StateR', 67890),
(19, 9, '1716 Palm Pl', 'Dry City', 'StateS', 78901),
(20, 10, '1817 Quince Way', 'Breezyville', 'StateT', 89012);

-- SQL script to insert 10 distinct buyers into the buyers table

INSERT INTO buyer (buyer_id, name, username, password) VALUES
(1, 'John Doe', 'johndoe', 'jdpass123'),
(2, 'Jane Smith', 'janesmith', 'jspass123'),
(3, 'Alice Johnson', 'alicej', 'ajpass123'),
(4, 'Bob Williams', 'bobw', 'bwpass123'),
(5, 'Carol Davis', 'carold', 'cdpass123'),
(6, 'Mike Brown', 'mikeb', 'mbpass123'),
(7, 'Sarah Miller', 'sarahm', 'smpass123'),
(8, 'Tony Wilson', 'tonyw', 'twpass123'),
(9, 'Linda Martinez', 'lindam', 'lmpass123'),
(10, 'Kevin Garcia', 'keving', 'kgpass123');

-- SQL script to insert campaign records into the campaign table

INSERT INTO campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES
('CMP01', 1, 1, 'http://example.com/product/1?ref=taylorswift', 'Instagram', 500),
('CMP02', 2, 1, 'http://example.com/product/2?ref=taylorswift', 'Twitter', 300),
('CMP03', 4, 2, 'http://example.com/product/4?ref=lebronjames', 'Instagram', 450),
('CMP04', 5, 3, 'http://example.com/product/5?ref=kimkardashian', 'Instagram', 600),
('CMP05', 7, 3, 'http://example.com/product/7?ref=kimkardashian', 'Facebook', 350),
('CMP06', 10, 4, 'http://example.com/product/10?ref=cristianor', 'Instagram', 700),
('CMP07', 13, 4, 'http://example.com/product/13?ref=cristianor', 'Twitter', 500),
('CMP08', 16, 5, 'http://example.com/product/16?ref=arianagrande', 'Instagram', 600),
('CMP09', 19, 6, 'http://example.com/product/19?ref=beyonce', 'Instagram', 550),
('CMP10', 22, 7, 'http://example.com/product/22?ref=justinbieber', 'YouTube', 400),
('CMP11', 25, 8, 'http://example.com/product/25?ref=selenagomez', 'Instagram', 500),
('CMP12', 28, 9, 'http://example.com/product/28?ref=rihanna', 'Instagram', 650),
('CMP13', 3, 10, 'http://example.com/product/3?ref=ellend', 'Instagram', 300),
('CMP14', 6, 10, 'http://example.com/product/6?ref=ellend', 'Facebook', 250),
('CMP15', 9, 10, 'http://example.com/product/9?ref=ellend', 'Twitter', 300);

-- SQL script to insert cart records into the cart table

INSERT INTO cart (buyer_id, product_id, quantity) VALUES
(1, 1, 1), (1, 2, 2), (1, 3, 1), (1, 4, 1), -- Buyer 1 with 4 products
(2, 5, 2), (2, 6, 1), (2, 7, 1),            -- Buyer 2 with 3 products
(3, 8, 3), (3, 9, 2),                       -- Buyer 3 with 2 products
(4, 10, 1), (4, 11, 1), (4, 12, 1), (4, 13, 2), (4, 14, 1), -- Buyer 4 with 5 products
(5, 15, 1), (5, 16, 1), (5, 17, 1), (5, 18, 1), (5, 19, 1), (5, 20, 1); -- Buyer 5 with 6 products

-- SQL script to insert 10 distinct categories into the category table

INSERT INTO category (category_id, name, description) VALUES
(1, 'Electronics', 'Devices and gadgets such as smartphones, laptops, and TVs'),
(2, 'Books', 'All kinds of books from fiction to educational material'),
(3, 'Clothing', 'Apparel for men, women, and children in various styles'),
(4, 'Home Appliances', 'Appliances for household use like refrigerators and microwaves'),
(5, 'Sports', 'Sports equipment and gear for various types of sports'),
(6, 'Gardening', 'Tools and supplies for gardening and outdoor activities'),
(7, 'Toys', 'Toys and games for children of all ages'),
(8, 'Groceries', 'Food items and everyday grocery products'),
(9, 'Automotive', 'Automobile parts and accessories'),
(10, 'Health & Beauty', 'Healthcare products and beauty supplies');
INSERT INTO image (url, product_id) VALUES
('https://media.idownloadblog.com/wp-content/uploads/2016/06/Bose-QuietComfort-35-image-002.jpg', 3),
('https://vignette.wikia.nocookie.net/5e37fe7c-51a9-4b46-a057-aa31ebbe906b/scale-to-width-down/1200', 4),
('https://www.tennisnuts.com/images/product/main/NIKE-FREE-50-642198_406_A_PREM.jpg?61', 9),
('https://trendyreviewed.com/wp-content/uploads/2020/01/Microwave-Ovens.jpg', 10),
('https://www.goalinn.com/f/13660/136608209/nike-all-field-3.0-american-football-ball.jpg', 14),
('https://giftstomorrow.co.uk/wp-content/uploads/2020/06/81ZqwIztj-L._AC_SL1500_.jpg', 18),
('https://upload.wikimedia.org/wikipedia/commons/1/19/Lego_bricks.jpg', 19),
('https://6.oliveoiltimes.com/wp-content/uploads/2014/07/49156976_ml.jpg', 23),
('https://autowise.com/wp-content/uploads/2019/06/MEGUIARS-car-air-freshener.jpg', 25),
('https://www.originalsprout.co.uk/wp-content/uploads/2016/02/web-354ml-Natural-Shampoo.jpg', 29)

-- SQL script to insert celebrities into the influencer table

INSERT INTO influencer (influencer_id, name, username, password) VALUES
(1, 'Taylor Swift', 'taylorswift', 'tspass123'),
(2, 'LeBron James', 'lebronjames', 'ljpass123'),
(3, 'Kim Kardashian', 'kimkardashian', 'kkpass123'),
(4, 'Cristiano Ronaldo', 'cristianor', 'crpass123'),
(5, 'Ariana Grande', 'arianagrande', 'agpass123'),
(6, 'Beyoncé Knowles', 'beyonce', 'bpass123'),
(7, 'Justin Bieber', 'justinbieber', 'jbpass123'),
(8, 'Selena Gomez', 'selenagomez', 'sgpass123'),
(9, 'Rihanna Fenty', 'rihanna', 'rpass123'),
(10, 'Ellen DeGeneres', 'ellend', 'epass123');

-- Updated SQL script to insert payment method records with 9-digit card numbers

INSERT INTO payment (card_number, buyer_id) VALUES
(111222333, 1),
(222333444, 1),
(333444555, 2),
(444555666, 2),
(555666777, 3),
(666777888, 3),
(777888999, 4),
(888999000, 5),
(999000111, 5),
(000111222, 6),
(123456789, 6),
(234567890, 7),
(345678901, 8),
(456789012, 8),
(567890123, 9),
(678901234, 10),
(789012345, 10),
(890123456, 10),
(901234567, 10),
(112233445, 1);

-- SQL script to insert social media platforms into the platform table

INSERT INTO platform (name) VALUES
('Instagram'),
('Twitter'),
('Facebook'),
('TikTok'),
('YouTube'),
('Snapchat'),
('LinkedIn'),
('Pinterest'),
('Reddit'),
('Tumblr');

-- SQL script to insert 3 products per category into the product table

-- Products for Electronics
INSERT INTO product (product_id, name, description, category_id, price, inventory) VALUES
(1, 'Smartphone X12', 'Latest model with high-resolution camera', 1, 999.99, 50),
(2, '4K LED TV', '55 inch 4K Ultra HD television', 1, 1299.99, 30),
(3, 'Bluetooth Headphones', 'Noise cancelling wireless headphones', 1, 199.99, 100),

-- Products for Books
(4, 'The Great Adventure', 'Action-packed fantasy novel', 2, 15.99, 200),
(5, 'Cooking Made Easy', 'A cookbook for beginners and experts', 2, 29.99, 150),
(6, 'Science for Kids', 'Educational book about basic science', 2, 12.99, 100),

-- Products for Clothing
(7, 'Summer T-Shirt', 'Light and comfortable cotton t-shirt', 3, 19.99, 250),
(8, 'Leather Jacket', 'Stylish black leather jacket', 3, 89.99, 50),
(9, 'Running Shoes', 'Durable and comfortable running shoes', 3, 59.99, 150),

-- Products for Home Appliances
(10, 'Microwave Oven', 'Compact and energy-efficient microwave', 4, 99.99, 75),
(11, 'Vacuum Cleaner', 'Powerful and quiet vacuum cleaner', 4, 149.99, 80),
(12, 'Air Purifier', 'HEPA filter air purifier for home', 4, 199.99, 60),

-- Products for Sports
(13, 'Yoga Mat', 'Non-slip eco-friendly yoga mat', 5, 29.99, 120),
(14, 'Football', 'Professional grade football', 5, 34.99, 200),
(15, 'Tennis Racket', 'Lightweight and durable tennis racket', 5, 89.99, 90),

-- Products for Gardening
(16, 'Gardening Tool Set', 'Complete set of essential gardening tools', 6, 49.99, 150),
(17, 'Flower Pots', 'Set of 3 ceramic flower pots', 6, 24.99, 200),
(18, 'Watering Can', 'Stainless steel watering can', 6, 29.99, 100),

-- Products for Toys
(19, 'Building Blocks', 'Educational and fun building blocks set', 7, 39.99, 150),
(20, 'Remote Control Car', 'High-speed remote control car', 7, 59.99, 100),
(21, 'Puzzle Game', '1000-piece jigsaw puzzle', 7, 19.99, 200),

-- Products for Groceries
(22, 'Organic Honey', 'Pure and natural organic honey', 8, 9.99, 300),
(23, 'Olive Oil', 'Extra virgin olive oil', 8, 14.99, 200),
(24, 'Green Tea', 'Antioxidant-rich green tea', 8, 7.99, 250),

-- Products for Automotive
(25, 'Car Air Freshener', 'Long-lasting lemon scent air freshener', 9, 4.99, 500),
(26, 'Oil Filter', 'High-quality oil filter for cars', 9, 19.99, 200),
(27, 'Tire Shine', 'Long-lasting tire shine spray', 9, 14.99, 150),

-- Products for Health & Beauty
(28, 'Facial Moisturizer', 'Hydrating and nourishing facial cream', 10, 29.99, 120),
(29, 'Shampoo', 'Organic and sulfate-free shampoo', 10, 19.99, 200),
(30, 'Body Lotion', 'Moisturizing body lotion with aloe vera', 10, 14.99, 180);

-- SQL script to insert review records into the review table

INSERT INTO review (buyer_id, product_id, rating, text) VALUES
(1, 1, 8, 'Great product, highly recommend!'),
(1, 2, 7, 'Good quality but a bit expensive.'),
(2, 2, 9, 'Absolutely love this product!'),
(2, 3, 6, 'Decent, but there are better options out there.'),
(3, 4, 5, 'Average product, nothing special.'),
(3, 7, 7, 'Good for the price.'),
(4, 5, 8, 'Very satisfied with this purchase.'),
(4, 6, 9, 'Exceeded my expectations!'),
(5, 7, 6, 'Not bad, but could be better.'),
(1, 8, 7, 'Pretty good overall.'),
(2, 9, 8, 'Very happy with this.'),
(3, 10, 4, 'Below average. Would not buy again.'),
(5, 11, 9, 'One of the best I have used.'),
(5, 12, 8, 'Solid product, does what it promises.'),
(1, 13, 7, 'Good, but not great.'),
(2, 14, 6, 'Okay, but I had higher expectations.'),
(4, 15, 5, 'Mediocre, not very impressed.'),
(3, 16, 8, 'Pretty good, would recommend.'),
(4, 17, 9, 'Excellent product, very happy with it.'),
(2, 18, 7, 'Good quality, but a bit pricey.');

-- SQL script to insert sale records into the sale table

INSERT INTO sale (sale_id, order_id, product_id, quantity, datetime, promo_code) VALUES
(1, 1, 1, 2, '2023-11-01 10:00:00', 'CMP01'),
(2, 2, 2, 1, '2023-11-02 11:30:00', 'CMP02'),
(3, 3, 4, 1, '2023-11-03 09:15:00', 'CMP03'),
(4, 4, 7, 3, '2023-11-04 14:45:00', NULL),
(5, 5, 10, 2, '2023-11-05 16:00:00', 'CMP06'),
(6, 6, 13, 1, '2023-11-06 12:00:00', 'CMP07'),
(7, 7, 16, 1, '2023-11-07 15:30:00', 'CMP08'),
(8, 8, 19, 1, '2023-11-08 10:20:00', 'CMP09'),
(9, 9, 22, 1, '2023-11-09 13:50:00', 'CMP10'),
(10, 10, 25, 2, '2023-11-10 11:10:00', 'CMP11'),
(11, 11, 28, 1, '2023-11-11 17:30:00', 'CMP12'),
(12, 12, 3, 1, '2023-11-12 09:00:00', NULL),
(13, 13, 6, 2, '2023-11-13 14:10:00', NULL),
(14, 14, 9, 1, '2023-11-14 16:40:00', NULL),
(15, 15, 12, 1, '2023-11-15 18:00:00', NULL),
(16, 16, 15, 1, '2023-11-16 10:30:00', NULL),
(17, 17, 18, 1, '2023-11-17 15:20:00', NULL),
(18, 18, 21, 1, '2023-11-18 12:15:00', NULL),
(19, 19, 24, 2, '2023-11-19 14:35:00', NULL),
(20, 20, 27, 1, '2023-11-20 09:05:00', NULL),
(21, 21, 2, 1, '2023-11-21 11:00:00', 'CMP02'),
(22, 22, 5, 1, '2023-11-22 12:50:00', NULL),
(23, 23, 8, 1, '2023-11-23 15:00:00', NULL),
(24, 24, 11, 1, '2023-11-24 17:15:00', NULL),
(25, 25, 14, 1, '2023-11-25 10:40:00', NULL),
(26, 26, 17, 2, '2023-11-26 13:30:00', NULL),
(27, 27, 20, 1, '2023-11-27 16:00:00', NULL),
(28, 28, 23, 1, '2023-11-28 18:20:00', NULL),
(29, 29, 26, 1, '2023-11-29 09:10:00', NULL),
(30, 30, 29, 2, '2023-11-30 11:45:00', NULL);

-- SQL script to insert 10 distinct company sellers into the seller table

INSERT INTO seller (seller_id, name, username, password) VALUES
(1, 'Tech Gadgets Inc', 'techgadgets', 'tgpass123'),
(2, 'Book World Ltd', 'bookworld', 'bwpass123'),
(3, 'Fashion Hub LLC', 'fashionhub', 'fhpass123'),
(4, 'Home Solutions Co', 'homesolutions', 'hspass123'),
(5, 'Sports Gear International', 'sportsgear', 'sgpass123'),
(6, 'Green Gardens Ltd', 'greengardens', 'ggpass123'),
(7, 'Toy Universe Corp', 'toyuniverse', 'tupass123'),
(8, 'Fresh Groceries Co', 'freshgroceries', 'fgpass123'),
(9, 'Auto Parts Central', 'autoparts', 'appass123'),
(10, 'Health & Beauty Essentials', 'healthbeauty', 'hbpass123');

-- SQL script to insert records into the sells table

-- Assigning products to sellers, ensuring each seller sells at least one product
INSERT INTO sells (seller_id, product_id) VALUES
(1, 1), (1, 2), (1, 3),    -- Seller 1 sells products 1, 2, 3
(2, 4), (2, 5), (2, 6),    -- Seller 2 sells products 4, 5, 6
(3, 7), (3, 8), (3, 9),    -- Seller 3 sells products 7, 8, 9
(4, 10), (4, 11), (4, 12), -- Seller 4 sells products 10, 11, 12
(5, 13), (5, 14), (5, 15), -- Seller 5 sells products 13, 14, 15
(6, 16), (6, 17), (6, 18), -- Seller 6 sells products 16, 17, 18
(7, 19), (7, 20), (7, 21), -- Seller 7 sells products 19, 20, 21
(8, 22), (8, 23), (8, 24), -- Seller 8 sells products 22, 23, 24
(9, 25), (9, 26), (9, 27), -- Seller 9 sells products 25, 26, 27
(10, 28), (10, 29), (10, 30); -- Seller 10 sells products 28, 29, 30

-- SQL script to insert shipment records into the shipment table

INSERT INTO shipment (order_id, address_id, buyer_id) VALUES
(1, 1, 1), (2, 2, 1), (3, 3, 2), (4, 4, 3), (5, 5, 3),
(6, 6, 4), (7, 7, 5), (8, 8, 6), (9, 9, 7), (10, 10, 8),
(11, 11, 9), (12, 12, 10), (13, 1, 1), (14, 3, 2), (15, 4, 3),
(16, 6, 4), (17, 8, 6), (18, 9, 7), (19, 10, 8), (20, 11, 9),
(21, 13, 1), (22, 15, 4), (23, 17, 7), (24, 19, 9), (25, 2, 1),
(26, 14, 2), (27, 16, 6), (28, 18, 8), (29, 20, 10), (30, 12, 10);
