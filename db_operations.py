from dummy_values import *


class DataBase():
    def __init__(self):
        pass

    def register_user(self, role,username,password):
        response = True
        return response

    def authenticate_user(self, username, password):
        response= True
        return response
    
    def get_products(self):
        products = dummy_list_of_products
        return products

    def add_product_to_cart(self, username, product_id):
        response =True
        return response
    
    def get_user_cart(self,username):
        cart_products = dummy_cart_products
        return cart_products
    
    def get_user_address(self,username):
        address = dummy_address
        return address
    
    def buy_user_products(self,username):
        response = True
        return response

    def delete_cart_product(self,username, product_id):
        response = True
        return response
    
    def empty_cart(self,username):
        response = True
        return response

    def get_user_payment(self, username):
        payment = dummy_payment
        return dummy_payment

    def update_address(self, username, street, state, postal):
        pass

    def update_payment(self, username, payment):
        pass
