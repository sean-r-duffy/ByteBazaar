from tables import *
from sqlalchemy import select, exists
from sqlalchemy.sql import func


class DataBase():
    def __init__(self):
        pass

    def register_user(self, role, username, password):
        if role == 'Customer':
            role = 'buyer'
        else:
            role = 'seller'
        with Session(engine) as session:
            session.execute(text('CALL new_buyer_or_seller(:name, :username, :password, :role, @success)'),
                            {'name': '', 'username': username, 'password': password, 'role': role})
            session.commit()

        return True

    def authenticate_user(self, username, password):
        with Session(engine) as session:
            in_buyer = session.query(exists()
                                     .where(Buyer.username == username, Buyer.password == password)).scalar()
            in_seller = session.query(exists()
                                      .where(Seller.username == username, Seller.password == password)).scalar()
            response = in_buyer or in_seller
        return response

    def get_products(self, category):
        with Session(engine) as session:
            category_id = session.execute(select(Category.category_id)
                                          .where(Category.name == category)).scalar()
            products = session.execute(text('CALL byte_bazaar.search_products(:category_id, @num_products);'),
                                       {'category_id': category_id})
            products = [x for x in products]
        return products

    def get_rating(self, product_id):
        with Session(engine) as session:
            rating = session.scalar(text('SELECT avg_rating(:product_id)'),
                                    {'product_id': product_id})
        return rating

    def get_categories(self):
        with Session(engine) as session:
            categories = session.scalars(select(Category.name))
        return categories

    def add_product_to_cart(self, username, product_id):
        with Session(engine) as session:
            cart = session.execute(select(Cart).where(Cart.buyer_username == username,
                                                      Cart.product_id == product_id)).scalar()
            if cart is not None:
                cart.quantity += 1
            else:
                session.execute(text('CALL byte_bazaar.add_to_cart(:product_id, :username, 1);'),
                                {'product_id': product_id, 'username': username})
            session.commit()
        return True

    def get_user_cart(self, username):
        with Session(engine) as session:
            cart_products = session.execute(select(Product, Cart).join(Cart, Cart.product_id == Product.product_id)
                                            .where(Cart.buyer_username == username))
            list_of_products = [(x.Product, x.Cart.quantity) for x in cart_products]
        return list_of_products

    def get_cart_subtotal(self, username):
        with Session(engine) as session:
            subtotal = session.execute(text('SELECT cart_subtotal(:username)'), {'username': username}).scalar()
        if subtotal is None:
            return 0
        else:
            return subtotal

    def get_user_addresses(self, username):
        with Session(engine) as session:
            addresses = session.scalars(select(Address).join(Buyer, Address.buyer_username == Buyer.username)
                                        .where(Buyer.username == username))
            addresses = [x for x in addresses]
        return addresses

    def buy_user_products(self, username, address_id, card_number, promo_code=None):
        with Session(engine) as session:
            last_shipment_id = session.scalar(func.max(Shipment.shipment_id))
            if last_shipment_id is None:
                shipment_id = 1
            else:
                shipment_id = last_shipment_id + 1
            carts = session.scalars(select(Cart).where(Cart.buyer_username == username))
            for cart in carts:
                sale = Sale(shipment_id=shipment_id, product_id=cart.product_id, quantity=cart.quantity,
                            datetime=func.now(), promo_code=promo_code)
            session.commit()
        shipment = Shipment(address_id=address_id, buyer_username=username, card_number=card_number)
        shipment.insert()
        return True

    def delete_cart_product(self, username, product_id):
        with Session(engine) as session:
            cart = session.execute(select(Cart).where(Cart.buyer_username == username,
                                                      Cart.product_id == product_id)).scalar()
            if cart.quantity == 1:
                session.delete(cart)
            else:
                cart.quantity -= 1
            session.commit()
        return True

    def empty_cart(self, username):
        with Session(engine) as session:
            carts = session.scalars(select(Cart).where(Cart.buyer_username == username))
            for x in carts:
                session.delete(x)
            session.commit()
        return True

    def get_user_payments(self, username):
        with Session(engine) as session:
            payments = session.scalars(select(Payment).where(Payment.buyer_username == username))
            payments = [x for x in payments]
        return payments

    def update_address(self, address_id, street, city, state, postal):

        with Session(engine) as session:
            session.execute(text('CALL byte_bazaar.change_address(:address_id, :street, :city, :state, :postal);'),
                            {'address_id': address_id,
                             'street': street,
                             'city': city,
                             'state': state,
                             'postal': postal})
            session.commit()

    def delete_address(self, address_id):
        with Session(engine) as session:
            address = session.execute(select(Address).where(Address.address_id == address_id)).scalar()
        address.delete()
        return True

    def insert_address(self, username, street, city, state, postal):
        address = Address(buyer_username=username, street=street, city=city, state=state, zip=postal)
        address.insert()
        return True

    def delete_payment(self, old_card_number):
        with Session(engine) as session:
            payment = session.execute(select(Payment).where(Payment.card_number == old_card_number)).scalar()
        payment.delete()
        return True

    def insert_payment(self, username, card_number):
        payment = Payment(card_number=card_number, buyer_username=username)
        payment.insert()
        return True

    def update_payment(self, username, old_card_number, new_card_number):
        self.delete_payment(old_card_number)
        self.insert_payment(username, new_card_number)

    def add_product(self, product_name, product_category, product_description, product_price):
        with Session(engine) as session:
            category_id = session.execute(select(Category.category_id)
                                          .where(Category.name == product_category)).scalar()
            if category_id is not None:
                product = Product(name=product_name, description=product_description,
                                  price=product_price, category_id=category_id)
                session.add(product)
                session.commit()
                response = True
            else:
                response = False
        return response

    def get_seller_sales(self, username):
        with Session(engine) as session:
            sales = session.execute(text('CALL byte_bazaar.show_prev_orders(:username, :role)'),
                                    {'username': username, 'role': 'seller'})
            sales = [x for x in sales]
        return sales

    def get_reviews(self, product_id):
        with Session(engine) as session:
            reviews = session.scalars(select(Review).where(Review.product_id == product_id))
            reviews = [x for x in reviews]
        return reviews

    def add_review(self, username, product_id, rating, description):
        review = Review(buyer_username=username, product_id=product_id, rating=rating, text=description)
        review.insert()
        return True

    def get_images(self, product_id):
        with Session(engine) as session:
            urls = session.scalars(select(Image.url).where(Image.product_id == product_id))
            urls = [x for x in urls]
        return urls
