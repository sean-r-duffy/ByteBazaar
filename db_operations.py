from dummy_values import *


class DataBase():
    def __init__(self):
        pass

    def register_user(self, role, username, password):
        response = True
        return response

    def authenticate_user(self, username, password):
        response = True
        return response

    def get_products(self, category):
        products = dummy_list_of_products
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

    def update_address(self, username, street, state, postal):
        pass

    def update_payment(self, username, payment):
        pass

    def add_product(self, product_name, product_category, product_description, product_price):
        pass

    def get_seller_sales(self, username):
        sales = dummy_sales
        return sales