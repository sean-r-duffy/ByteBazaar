from dummy_values import *
from tables import *
from sqlalchemy import select, exists


class DataBase():
    def __init__(self):
        pass

    def register_user(self, role, username, password):
        if role == 'Customer':
            Buyer(username=username, password=password).insert()
            response = True
        elif role == 'Seller':
            Seller(username=username, password=password).insert()
            response = True
        else:
            response = False
        return response

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
            products = session.scalars(select(Product)
                                       .join(Category, Product.category_id == Category.category_id)
                                       .where(Category.name == category))
            products = [x for x in products]
        return products

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
                cart = Cart(buyer_username=username, product_id=product_id, quantity=1)
                session.add(cart)
            session.commit()
        return True

    def get_user_cart(self, username):
        with Session(engine) as session:
            cart_products = session.scalars(select(Product).join(Cart, Cart.product_id == Product.product_id)
                                            .where(Cart.buyer_username == username))
            list_of_products = [x for x in cart_products]
        return list_of_products


    def get_user_cart_subtotal(self,username):
        return dummy_subtotal

    # TODO: Adjust ui.py to handle multiple addresses per user, add address if none are in system
    def get_user_address(self, username):
        with Session(engine) as session:
            addresses = session.scalars(select(Address).join(Buyer, Address.buyer_username == Buyer.username)
                                        .where(Buyer.username == username))
            addresses = [x for x in addresses]
        address = addresses[0]
        zip = ('0' * (5 - len(str(address.zip)))) + str(address.zip)
        address_string = address.street + ' ' + address.city + ', ' + address.state + ' ' + zip
        return address_string
        
    def get_user_addresses(self,username):
        return dummy_addresses
    
    def add_user_address(self,username, street, city, state, postal):
        respose = True
        return respose
    def buy_user_products(self, username,address_id, payment_id):
        response = True
        return response
    
    def get_product_reviews(self,product_id):
        return dummy_reviews
    def insert_product_rating(self,username, rating, review):
        pass
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
        response = True
        return response

    def get_user_payment_methods(self,username):
        payment_methods = dummy_payment_methods
        return payment_methods
    def get_user_payment(self, username):
        payment = dummy_payment
        return dummy_payment

    # TODO: Test, needs address_id field
    def update_address(self,address_id, username, street, city, state, postal):

        # with Session(engine) as session:
        #     address_id = session.execute(select(Address.address_id).where(Address.buyer_username == username))
        #     session.execute(text('CALL byte_bazaar.change_address(:address_id, :street, :city, :state, :postal);',
        #                          {'address_id': address_id,
        #                           'street': street,
        #                           'city': city,
        #                           'state': state,
        #                           'postal': postal}))
        #     session.commit()
        pass
    def update_payment(self, username, payment):
        pass

    def add_product(self, product_name, product_category, product_description, product_price):
        pass

    def get_seller_sales(self, username):
        sales = dummy_sales
        return sales
