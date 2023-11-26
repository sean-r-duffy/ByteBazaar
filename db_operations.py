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

    # TODO: Test
    def get_products(self, category):
        with Session(engine) as session:
            products = session.scalars(select(Product)
                                       .join(Category, Product.category_id == Category.category_id)
                                       .where(Category.name == category))
        products = [x.__dict__ for x in products]
        # products = dummy_list_of_products
        return products

    def get_categories(self):
        categories = dummy_categories
        return categories

    def add_product_to_cart(self, username, product_id):
        response = True
        return response

    def get_user_cart(self, username):
        cart_products = dummy_cart_products
        return cart_products

    def get_user_address(self, username):
        address = dummy_address
        return address

    def buy_user_products(self, username):
        response = True
        return response

    def delete_cart_product(self, username, product_id):
        response = True
        return response

    def empty_cart(self, username):
        response = True
        return response

    def get_user_payment(self, username):
        payment = dummy_payment
        return dummy_payment

    # TODO: Update with correct stored procedure name
    def update_address(self, username, street, state, postal):
        """
        with engine.connect() as connection:
            connection.execute('CALL update_address(:username, :street, :state, :postal);',
                               {'username': username, 'street': street, 'state': state, 'postal': postal})
            connection.commit()
        """
        pass

    def update_payment(self, username, payment):
        pass

    def add_product(self, product_name, product_category, product_description, product_price):
        pass

    def get_seller_sales(self, username):
        sales = dummy_sales
        return sales
