CREATE TABLE buyer (
    buyer_id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    username VARCHAR(40),
    password VARCHAR(40)
);

CREATE TABLE category (
    category_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(200)
);

CREATE TABLE seller (
    seller_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    username VARCHAR(40),
    password VARCHAR(40)
);

CREATE TABLE influencer (
    influencer_id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    username VARCHAR(40),
    password VARCHAR(40)
);

CREATE TABLE platform (
    name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE product (
    product_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(200),
    category_id INTEGER,
    price FLOAT,
    inventory INTEGER,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE image (
    url VARCHAR(100) PRIMARY KEY,
    product_id INTEGER,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE sells (
    seller_id INTEGER,
    product_id INTEGER,
    PRIMARY KEY (seller_id, product_id),
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE campaign (
    campaign_id VARCHAR(20) PRIMARY KEY,
    product_id INTEGER,
    influencer_id INTEGER,
    url VARCHAR(100),
    platform_name VARCHAR(50),
    units_sold INTEGER,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (influencer_id) REFERENCES influencer(influencer_id),
    FOREIGN KEY (platform_name) REFERENCES platform(name)
);

CREATE TABLE cart (
    buyer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    PRIMARY KEY (buyer_id, product_id),
    FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE review (
    buyer_id INTEGER,
    product_id INTEGER,
    rating INTEGER,
    text VARCHAR(1000),
    PRIMARY KEY (buyer_id, product_id),
    FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    CHECK (rating <= 10 AND rating >= 0)
);

CREATE TABLE address (
    address_id INTEGER PRIMARY KEY,
    buyer_id INTEGER,
    street VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    zip INTEGER,
    FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id)
);

CREATE TABLE shipment (
    order_id INTEGER PRIMARY KEY,
    address_id INTEGER,
    buyer_id INTEGER,
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id)
);

CREATE TABLE sale (
    sale_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    datetime DATETIME,
    promo_code VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES shipment(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (promo_code) REFERENCES campaign(campaign_id)
);

CREATE TABLE payment (
    card_number INTEGER PRIMARY KEY,
    buyer_id INTEGER,
    FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id)
);


