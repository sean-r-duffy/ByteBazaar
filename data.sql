INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user1', 'Alice Johnson', 'pass1234');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user2', 'Bob Smith', 'bobsecretpass');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user3', 'Carol White', 'carolpw123');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user4', 'David Brown', 'davidpw');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user5', 'Eve Davis', 'evepass');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user6', 'Frank Miller', 'frankspass');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user7', 'Grace Lee', 'grace123');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user8', 'Henry Wilson', 'henrypw');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user9', 'Ivy Taylor', 'ivypass');
INSERT INTO byte_bazaar.buyer (username, name, password) VALUES ('user10', 'John Doe', 'johndoepass');
-- Assigning addresses to buyers
-- Each buyer gets at least one address
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user1', '123 Oak Street', 'Springfield', 'StateA', 12345);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user2', '456 Maple Avenue', 'Greenville', 'StateB', 23456);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user3', '789 Pine Lane', 'Fairview', 'StateC', 34567);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user4', '101 Ash Road', 'Lakeview', 'StateD', 45678);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user5', '202 Elm Street', 'Ridgewood', 'StateE', 56789);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user6', '303 Cedar Blvd', 'Brookside', 'StateF', 67890);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user7', '404 Birch Street', 'Cliffside', 'StateG', 78901);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user8', '505 Willow Drive', 'Riverdale', 'StateH', 89012);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user9', '606 Juniper Way', 'Seaside', 'StateI', 90123);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user10', '707 Redwood Circle', 'Pinecrest', 'StateJ', 10234);

-- Assigning additional addresses to some buyers
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user1', '808 Spruce Lane', 'Hilltown', 'StateA', 11223);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user2', '909 Oak Court', 'Sunnyvale', 'StateB', 12334);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user3', '111 Chestnut Street', 'Shady Oaks', 'StateC', 23445);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user4', '212 Alder Road', 'Autumn Falls', 'StateD', 34556);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user1', '313 Fir Avenue', 'Winterville', 'StateA', 45667);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user2', '414 Hemlock Street', 'Spring Hills', 'StateB', 56778);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user5', '515 Magnolia Blvd', 'Summerford', 'StateE', 67889);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user6', '616 Dogwood Drive', 'Autumn Ridge', 'StateF', 78990);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user7', '717 Cherry Lane', 'New Dawn', 'StateG', 89001);
INSERT INTO byte_bazaar.address (buyer_username, street, city, state, zip) VALUES ('user8', '818 Plum Street', 'Oldtown', 'StateH', 90112);
-- Inserting sample categories
INSERT INTO byte_bazaar.category (name, description) VALUES ('Electronics', 'Devices, gadgets and gizmos for everyday use');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Books', 'Range of fiction and non-fiction literature');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Clothing', 'Apparel for men, women, and children');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Home & Garden', 'Essentials for home improvement and gardening');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Sports & Fitness', 'Equipment and apparel for sports and fitness activities');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Toys & Games', 'Fun and entertainment for kids of all ages');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Beauty & Health', 'Beauty products and health supplements');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Automotive', 'Accessories and parts for vehicles');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Groceries', 'Food items and daily necessities');
INSERT INTO byte_bazaar.category (name, description) VALUES ('Pet Supplies', 'Essentials for pet care and maintenance');
-- Inserting products into categories
-- Each category gets at least one product
-- Category 1: Electronics
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Smartphone', 'Latest model with advanced features', 1, 699.99, 50);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Laptop', 'High performance for work and play', 1, 999.99, 30);

-- Category 2: Books
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Mystery Novel', 'A thrilling page-turner', 2, 15.99, 100);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Cookbook', 'Delicious recipes for home cooking', 2, 20.99, 70);

-- Category 3: Clothing
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('T-Shirt', 'Comfortable cotton tee', 3, 9.99, 150);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Jeans', 'Stylish and durable', 3, 39.99, 80);

-- Category 4: Home & Garden
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Gardening Tools', 'Essential tools for gardening', 4, 29.99, 40);

-- Category 5: Sports & Fitness
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Yoga Mat', 'Eco-friendly and durable', 5, 19.99, 60);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Football', 'Professional quality for sports enthusiasts', 5, 24.99, 90);

-- Category 6: Toys & Games
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Board Game', 'Fun for the whole family', 6, 34.99, 50);

-- Category 7: Beauty & Health
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Skin Cream', 'Nourishing and moisturizing', 7, 14.99, 120);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Vitamins', 'Daily supplements for health', 7, 19.99, 150);

-- Category 8: Automotive
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Car Air Freshener', 'Keeps your car smelling fresh', 8, 4.99, 200);

-- Category 9: Groceries
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Organic Pasta', 'Healthy and tasty', 9, 2.99, 300);

-- Category 10: Pet Supplies
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Dog Food', 'Nutritious meal for your pet', 10, 49.99, 60);

-- Adding additional products to some categories
-- Additional products for Category 1: Electronics
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Tablet', 'Portable and powerful', 1, 499.99, 40);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Camera', 'Capture your moments', 1, 299.99, 35);

-- Additional products for Category 2: Books
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Science Fiction', 'An epic space adventure', 2, 12.99, 90);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Biography', 'Inspirational life stories', 2, 18.99, 75);

-- Additional products for Category 3: Clothing
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Sweater', 'Warm and cozy', 3, 29.99, 70);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Jacket', 'Fashionable and functional', 3, 59.99, 50);

-- Additional products for Category 4: Home & Garden
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Kitchen Knife Set', 'Precision cutting for culinary enthusiasts', 4, 49.99, 55);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Bedding Set', 'Comfortable and stylish', 4, 79.99, 45);

-- Additional products for Category 5: Sports & Fitness
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Dumbbells', 'For strength training at home', 5, 35.99, 80);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Tennis Racket', 'High-quality for tennis players', 5, 89.99, 40);

-- Additional products for Category 6: Toys & Games
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Action Figure', 'Collectible item for fans', 6, 14.99, 100);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Puzzle', 'Challenging and fun for all ages', 6, 19.99, 80);

-- Additional products for Category 7: Beauty & Health
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Hair Shampoo', 'Gentle and effective for daily use', 7, 9.99, 130);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Body Lotion', 'Hydrating for all skin types', 7, 11.99, 110);

-- Additional products for Category 8: Automotive
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Car Wash Kit', 'Everything you need for a clean car', 8, 19.99, 70);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Phone Holder for Car', 'Convenient for navigation', 8, 14.99, 85);

-- Additional products for Category 9: Groceries
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Cereal', 'Healthy breakfast option', 9, 3.99, 250);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Tea', 'Refreshing and aromatic', 9, 5.99, 200);

-- Additional products for Category 10: Pet Supplies
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Cat Toy', 'Fun and engaging for cats', 10, 6.99, 120);
INSERT INTO byte_bazaar.product (name, description, category_id, price, inventory) VALUES ('Bird Feeder', 'Attract and feed wild birds', 10, 24.99, 80);

-- Inserting social media platforms
INSERT INTO byte_bazaar.platform (name) VALUES ('Facebook');
INSERT INTO byte_bazaar.platform (name) VALUES ('Twitter');
INSERT INTO byte_bazaar.platform (name) VALUES ('Instagram');
INSERT INTO byte_bazaar.platform (name) VALUES ('YouTube');
INSERT INTO byte_bazaar.platform (name) VALUES ('LinkedIn');
INSERT INTO byte_bazaar.platform (name) VALUES ('Pinterest');
INSERT INTO byte_bazaar.platform (name) VALUES ('Snapchat');
INSERT INTO byte_bazaar.platform (name) VALUES ('TikTok');
INSERT INTO byte_bazaar.platform (name) VALUES ('Reddit');
INSERT INTO byte_bazaar.platform (name) VALUES ('WhatsApp');
-- Inserting sample influencers
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Alex Trendy', 'alextrendy', 'pass123');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Bella Style', 'bellastyle', 'bellapass');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Charlie Fit', 'charliefit', 'charliepw123');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Diana Vogue', 'dianavogue', 'dianapw');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Ethan Tech', 'ethantech', 'ethanpass');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Fiona Gourmet', 'fionagourmet', 'fionaspass');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('George Travels', 'georgetravels', 'george123');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Hannah Wellness', 'hannahwellness', 'hannahpw');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Ian Games', 'iangames', 'ianpass');
INSERT INTO byte_bazaar.influencer (name, username, password) VALUES ('Julia Arts', 'juliaarts', 'juliadoepass');
-- Inserting campaigns
-- Campaigns for various products by different influencers on different platforms
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP001', 1, 1, 'http://example.com/camp1', 'Instagram', 100);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP002', 2, 2, 'http://example.com/camp2', 'Facebook', 150);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP003', 4, 3, 'http://example.com/camp3', 'YouTube', 200);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP004', 5, 4, 'http://example.com/camp4', 'Twitter', 250);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP005', 6, 5, 'http://example.com/camp5', 'LinkedIn', 300);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP006', 7, 6, 'http://example.com/camp6', 'Pinterest', 350);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP007', 8, 7, 'http://example.com/camp7', 'Snapchat', 400);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP008', 9, 8, 'http://example.com/camp8', 'TikTok', 450);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP009', 10, 9, 'http://example.com/camp9', 'Reddit', 500);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP010', 3, 10, 'http://example.com/camp10', 'WhatsApp', 550);
-- Additional campaigns
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP011', 1, 2, 'http://example.com/camp11', 'Facebook', 600);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP012', 2, 3, 'http://example.com/camp12', 'Instagram', 650);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP013', 4, 4, 'http://example.com/camp13', 'YouTube', 700);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP014', 5, 5, 'http://example.com/camp14', 'Twitter', 750);
INSERT INTO byte_bazaar.campaign (campaign_id, product_id, influencer_id, url, platform_name, units_sold) VALUES ('CAMP015', 6, 6, 'http://example.com/camp15', 'LinkedIn', 800);
-- Inserting items into the carts of 5 buyers
-- Buyer 1 has 4 items in the cart
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user1', 1, 2);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user1', 3, 1);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user1', 5, 1);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user1', 7, 1);

-- Buyer 2 has 3 items in the cart
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user2', 2, 2);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user2', 4, 1);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user2', 6, 3);

-- Buyer 3 has 2 items in the cart
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user3', 8, 1);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user3', 10, 2);

-- Buyer 4 has 3 items in the cart
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user4', 11, 1);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user4', 13, 2);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user4', 15, 1);

-- Buyer 5 has 3 items in the cart
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user5', 12, 1);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user5', 14, 2);
INSERT INTO byte_bazaar.cart (buyer_username, product_id, quantity) VALUES ('user5', 16, 3);
-- Inserting images for various products
-- Products 1, 2, and 3 will have multiple images
-- Product 1 images
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image1-1.jpg', 1);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image1-2.jpg', 1);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image1-3.jpg', 1);

-- Product 2 images
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image2-1.jpg', 2);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image2-2.jpg', 2);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image2-3.jpg', 2);

-- Product 3 images
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image3-1.jpg', 3);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image3-2.jpg', 3);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image3-3.jpg', 3);

-- Single images for Products 4 to 7
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image4.jpg', 4);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image5.jpg', 5);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image6.jpg', 6);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image7.jpg', 7);

-- Additional images for Products 1 and 2
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image1-4.jpg', 1);
INSERT INTO byte_bazaar.image (url, product_id) VALUES ('http://example.com/image2-4.jpg', 2);
-- Inserting payment methods for buyers
-- Ensuring each buyer has at least one payment method
-- Starting card number from a 9-digit value
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456789, 'user1');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456790, 'user2');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456791, 'user3');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456792, 'user4');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456793, 'user5');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456794, 'user6');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456795, 'user7');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456796, 'user8');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456797, 'user9');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456798, 'user10');

-- Additional payment methods for some buyers
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456799, 'user1');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456800, 'user2');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456801, 'user3');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456802, 'user4');
INSERT INTO byte_bazaar.payment (card_number, buyer_username) VALUES (123456803, 'user5');
-- Inserting reviews for various products by different buyers
-- Buyer 1 reviews
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user1', 1, 5, 'Excellent product, highly recommend!');
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user1', 2, 4, 'Good quality, but a bit pricey.');

-- Buyer 2 reviews
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user2', 3, 5, 'Great value for money.');
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user2', 4, 3, 'Average product, expected better.');

-- Buyer 3 reviews
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user3', 5, 4, 'Good quality, happy with the purchase.');

-- Buyer 4 reviews
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user4', 6, 5, 'Fantastic! Exceeds expectations.');

-- Buyer 5 reviews
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user5', 7, 2, 'Not satisfied, product has issues.');

-- Buyer 6 reviews
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user6', 8, 4, 'Overall good, but has some minor flaws.');

-- Buyer 7 reviews
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user7', 9, 5, 'Perfect product, will buy again!');

-- Buyer 8 reviews
INSERT INTO byte_bazaar.review (buyer_username, product_id, rating, text) VALUES ('user8', 10, 3, 'Mediocre, not as described.');

-- Additional reviews for various products by buyers
-- Repeating this process to reach a total of 30 reviews
-- ...

-- Note: Additional review entries would continue in a similar pattern, ensuring some products have multiple reviews and some buyers leave more reviews than others.
-- Inserting shipments for various buyers
-- Buyer 1 shipments
/* 
For some reason this line fixes an error in this series of insert statements,
no clue why
*/
ALTER TABLE byte_bazaar.shipment AUTO_INCREMENT = 2;
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (11, 'user10');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (2, 'user1');

-- Buyer 2 shipments
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (3, 'user2');

-- Buyer 3 shipments
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (4, 'user3');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (5, 'user3');

-- Buyer 4 shipments
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (6, 'user4');

-- Buyer 5 shipments
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (7, 'user5');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (8, 'user5');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (9, 'user5');

-- Buyer 6 shipments
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (10, 'user6');

-- Additional shipments for various buyers
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (11, 'user1');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (12, 'user2');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (13, 'user3');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (14, 'user4');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (15, 'user5');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (16, 'user6');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (17, 'user7');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (18, 'user8');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (19, 'user9');
INSERT INTO byte_bazaar.shipment (address_id, buyer_username) VALUES (20, 'user10');

-- Note: The address_id values are based on the assumption that each buyer has at least one associated address from the previously created `address` table.
-- Inserting sales records, each linked to a distinct shipment
-- Using the specified shipment_id starting from 2
-- Associating sales with products and, where applicable, promo codes from campaigns

-- Assuming product_ids and promo_codes based on previous tables
-- Each sale has a unique datetime and an optional promo code

-- Inserting sales records, each linked to a distinct shipment
-- Using the specified shipment_id starting from 2
-- Associating sales with products and, where applicable, promo codes from campaigns

-- Assuming product_ids and promo_codes based on previous tables
-- Each sale has a unique datetime and an optional promo code

INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (2, 1, 1, '2023-01-01 10:00:00', 'CAMP001');
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (3, 2, 2, '2023-01-02 11:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (4, 3, 1, '2023-01-03 12:00:00', 'CAMP003');
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (5, 4, 1, '2023-01-04 13:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (6, 5, 2, '2023-01-05 14:00:00', 'CAMP005');
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (7, 6, 1, '2023-01-06 15:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (8, 7, 3, '2023-01-07 16:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (9, 8, 1, '2023-01-08 17:00:00', 'CAMP008');
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (10, 9, 2, '2023-01-09 18:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (11, 10, 1, '2023-01-10 19:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (12, 11, 1, '2023-01-11 10:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (13, 12, 2, '2023-01-12 11:00:00', 'CAMP012');
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (14, 13, 1, '2023-01-13 12:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (15, 14, 3, '2023-01-14 13:00:00', 'CAMP014');
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (16, 15, 1, '2023-01-15 14:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (17, 16, 2, '2023-01-16 15:00:00', 'CAMP012');
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (18, 17, 1, '2023-01-17 16:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (19, 18, 1, '2023-01-18 17:00:00', 'CAMP013');
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (20, 19, 2, '2023-01-19 18:00:00', NULL);
INSERT INTO byte_bazaar.sale (shipment_id, product_id, quantity, datetime, promo_code) VALUES (21, 20, 1, '2023-01-20 19:00:00', 'CAMP014');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('ElectroGoods Inc.', 'electrogoods', 'electro123');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('BookWorld Ltd.', 'bookworld', 'worldofbooks');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('FashionFiesta Co.', 'fashionfiesta', 'fashionpass');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('TechTrendz LLC', 'techtrendz', 'tech1234');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('HealthyLife Organics', 'healthylife', 'organicpass');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('GadgetGuru Inc.', 'gadgetguru', 'gadgetpass');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('SportsStar LLC', 'sportsstar', 'sportspass');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('HomeEssentials Ltd.', 'homeessentials', 'home123');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('BeautyBoutique Co.', 'beautyboutique', 'beautypass');
INSERT INTO byte_bazaar.seller (name, username, password) VALUES ('PetPals LLC', 'petpals', 'petpass123');
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (1, 1);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (2, 2);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (3, 3);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (4, 4);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (5, 5);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (6, 6);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (7, 7);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (8, 8);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (9, 9);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (10, 10);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (1, 11);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (2, 12);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (3, 13);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (4, 14);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (5, 15);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (6, 16);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (7, 17);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (8, 18);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (9, 19);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (10, 20);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (1, 21);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (2, 22);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (3, 23);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (4, 24);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (5, 25);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (6, 26);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (7, 27);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (8, 28);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (9, 29);
INSERT INTO byte_bazaar.sells (seller_id, product_id) VALUES (10, 30);
