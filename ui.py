import os
from PyInquirer import prompt
import getpass
from db_operations import DataBase


# from constants import style, logo

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')


class User:
    def __init__(self, role):
        self.role = role
        self.username = None
        self.password = None
        self.db = DataBase()

    def login(self):
        clear_screen()
        print(f'{self.role} Login')
        print('-' * 20)
        self.username = input(f"Enter username: ")
        self.password = getpass.getpass(f"Enter password: ")
        response = self.db.authenticate_user(self.username, self.password)

        return response

    def register(self):
        clear_screen()
        questions = [
            {
                'type': 'list',
                'name': 'role',
                'message': 'Role',
                'choices': ['Customer', 'Seller'],
            }
        ]
        answers = prompt(questions)
        self.role = answers['role']
        self.username = input("Enter your username: ")
        self.password = getpass.getpass("Enter your password: ")
        registration_response = self.db.register_user(self.role, self.username, self.password)
        if registration_response:
            print("Registration successful!")
        return registration_response

    def get_product_categories(self):
        categories = self.db.get_categories()
        return categories

    def get_product_details(self, category):
        product_details, ratings = self.db.get_products(category)
        return product_details, ratings

    def add_to_cart(self, product_id):
        self.db.add_product_to_cart(self.username, product_id)

    def get_cart_products(self):
        return self.db.get_user_cart(self.username)

    def get_cart_subtotal(self):
        return self.db.get_cart_subtotal(self.username)

    def remove_cart_product(self, product_id):
        self.db.delete_cart_product(self.username, product_id)

    def buy_products(self):
        self.db.buy_user_products(self.username)
        self.db.empty_cart(self.username)

    def get_addresses(self):
        return self.db.get_user_addresses(self.username)

    def get_payment(self):
        return self.db.get_user_payment(self.username)

    def change_address(self, address_id, street, state, city, postal):
        return self.db.update_address(address_id, street, city, state, postal)

    def delete_address(self, address_id):
        return self.db.delete_address(address_id)

    def insert_address(self, street, city, state, postal):
        return self.db.insert_address(self.username, street, city, state, postal)

    def change_payment(self, payment):
        return self.db.update_payment(self.username, payment)

    def add_seller_product(self, product_name, product_category, product_description, product_price):
        return self.db.add_product(product_name, product_category, product_description, product_price)

    def get_sales(self):
        return self.db.get_seller_sales(self.username)


class ECommerceApp:
    def __init__(self):
        self.user = None

    def start(self):
        clear_screen()
        print('ByteBazaar')
        print('-' * 11)
        questions = [
            {
                'type': 'list',
                'name': 'role',
                'message': 'Are you a customer, seller, or registering?',
                'choices': ['Customer', 'Seller', 'Register'],
            }
        ]
        answers = prompt(questions)

        if answers['role'] == 'Register':
            self.user = User(None)
            registration_response = self.user.register()
            if registration_response:
                if self.user.role == 'Customer':
                    self.customer_main_menu()
                else:
                    self.seller_main_menu()
        else:
            self.user = User(answers['role'])
            if self.user.login():
                if answers['role'] == 'Customer':
                    self.customer_main_menu()
                else:
                    self.seller_main_menu()

    def customer_main_menu(self):
        clear_screen()
        print('Main Menu')
        print('-' * 20)
        options = ['View Products', 'Cart', 'Profile', 'Logout']
        questions = [

            {
                'type': 'list',
                'name': 'main_menu',
                'message': '',
                'choices': options
            }
        ]
        answers = prompt(questions)
        if answers['main_menu'] == 'Logout':
            self.logout()
        elif answers['main_menu'] == 'View Products':
            self.select_category()
        elif answers['main_menu'] == 'Cart':
            self.cart()
        elif answers['main_menu'] == 'Profile':
            self.profile()

    def seller_main_menu(self):
        clear_screen()
        print('Main Menu')
        print('-' * 20)
        options = ['Add Product', 'View Sales', 'Logout']
        questions = [
            {
                'type': 'list',
                'name': 'main_menu',
                'message': '',
                'choices': options
            }
        ]
        answers = prompt(questions)
        if answers['main_menu'] == 'Logout':
            self.logout()
        elif answers['main_menu'] == 'Add Product':
            self.add_products()
        elif answers['main_menu'] == 'View Sales':
            self.view_sales()

    def select_category(self):
        clear_screen()
        print('Catgories')
        print('-' * 20)
        options = self.user.get_product_categories()
        questions = [
            {
                'type': 'list',
                'name': 'choice',
                'message': '',
                'choices': options
            }
        ]
        answers = prompt(questions)
        if answers['choice']:
            self.view_products(answers['choice'])

    def view_products(self, category):
        list_of_products, ratings = self.user.get_product_details(category)
        page_number = 0
        number_of_pages = len(list_of_products)

        def view_each_product(page_number):
            clear_screen()
            print('Products')
            print('-' * 20)
            product = list_of_products[page_number]
            product_id = product.product_id
            rating = ratings[page_number]
            print('Product Name: ', product.name)
            # Displaying rating will require a new rating field and a trigger that updates it when a new review is made
            # print('Rating: ', product['rating'])
            print('Description: ', product.description)
            print('Price: ', product.price)
            print('Average rating: ' + str(rating))
            print('-' * 20)
            options = ['Add to cart', 'Previous', 'Next', 'Back']
            questions = [{
                'type': 'list',
                'name': 'product_option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['product_option']
            if selection == 'Add to cart':
                self.user.add_to_cart(product_id)
                view_each_product(page_number)
            if selection == 'Previous':
                if page_number == 0:
                    view_each_product(page_number)
                else:
                    page_number -= 1
                    view_each_product(page_number)

            if selection == 'Next':
                if page_number == number_of_pages - 1:
                    view_each_product(page_number)
                else:
                    page_number += 1
                    view_each_product(page_number)
            if selection == 'Back':
                if self.user.role == 'Customer':
                    self.customer_main_menu()
                else:
                    self.seller_main_menu()
                    self.seller_main_menu()

        view_each_product(page_number)

    def cart(self):
        clear_screen()
        subtotal = self.user.get_cart_subtotal()
        print('Cart')
        print('Total: $' + str(subtotal))
        print('-' * 20)
        list_of_products = self.user.get_cart_products()
        items_view_list = []
        product_id_mapping = {}
        for x in list_of_products:
            product = x[0]
            qty = x[1]
            product_name = product.name
            product_id = product.product_id
            product_price = str(product.price)
            items_view = 'Product Name: ' + product_name + ' | Price: ' + product_price + ' | Qty: ' + str(qty)
            items_view_list.append(items_view)
            product_id_mapping[items_view] = product_id
        questions = [
            {
                'type': 'list',
                'name': 'choice',
                'message': 'Select the product you want to remove from cart',
                'choices': items_view_list + ['Buy', 'Back']
            }
        ]
        answers = prompt(questions)
        selection = answers['choice']

        if selection == 'Back':
            if self.user.role == 'Customer':
                self.customer_main_menu()
            else:
                self.seller_main_menu()
        elif selection == 'Buy':
            self.user.buy_products()
            self.cart()
        else:
            self.user.remove_cart_product(product_id_mapping[selection])
            self.cart()

    def profile(self):
        print('Profile')
        print('-' * 20)
        print(f'Username: {self.user.username}')
        options = ['Address', 'Payment', 'Back']
        questions = [{
            'type': 'list',
            'name': 'option',
            'message': '',
            'choices': options
        }]
        answers = prompt(questions)
        selection = answers['option']
        if selection == 'Back':
            if self.user.role == 'Customer':
                self.customer_main_menu()
            else:
                self.seller_main_menu()
        elif selection == 'Address':
            self._display_change_address()
        elif selection == 'Payment':
            self._display_change_payment()

    def _display_change_address(self):
        clear_screen()
        print('Address')
        print('-' * 20)
        addresses = self.user.get_addresses()
        if len(addresses) == 0:
            print('No addresses saved')
        else:
            print('Select address to edit')
        options = [f'{x.street}, {x.state}, {x.city} {x.zip}' for x in addresses]
        options.append('Add Address')
        options.append('Back')
        questions = [{
            'type': 'list',
            'name': 'option',
            'message': '',
            'choices': options
        }]
        answers = prompt(questions)
        if answers['option'] == 'Back':
            self.customer_main_menu()
        elif answers['option'] == 'Add Address':
            # TODO: add address
            # self.user.insert_address(street, city, state, postal)
            pass
        else:
            address = addresses[options.index(answers['option'])]
            address_id = address.address_id
            bio_question = [
                {
                    'type': 'editor',
                    'name': 'bio',
                    'message': 'Leave blank to delete or type new address in the format -> Street, State, City, Postal '
                               '(Esc+Enter to exit): ',
                }
            ]
            bio_answers = prompt(bio_question)
            if bio_answers['bio'] == '':
                self.user.delete_address(address_id)
            else:
                try:
                    address_list = bio_answers['bio'].split(' ,')
                    if len(address_list) == 3:
                        street = address_list[0]
                        state = address_list[1]
                        city = address_list[2]
                        postal = address_list[3]
                        self.user.change_address(address_id, street, state, city, postal)
                except:
                    print("Address wasn't changed!")
            clear_screen()
            self.profile()

    # TODO: Adjust to handle multiple payments
    def _display_change_payment(self):
        clear_screen()
        address = self.user.get_payment()
        print(f'Current Payment: {address}')
        options = ['Change Payment', 'Back']
        questions = [{
            'type': 'list',
            'name': 'option',
            'message': '',
            'choices': options
        }]
        answers = prompt(questions)
        if answers['option'] == 'Back':
            self.customer_main_menu()
        elif answers['option'] == 'Change Payment':
            bio_question = [
                {
                    'type': 'editor',
                    'name': 'bio',
                    'message': 'Please your card details (Esc+Enter to exit): ',
                }
            ]
            bio_answers = prompt(bio_question)
            payment = bio_answers['bio']
            self.user.change_payment(payment)
            clear_screen()
            self.profile()

    def view_sales(self):
        clear_screen()
        print(f'Sales')
        print('-' * 20)
        sales = self.user.get_sales()
        for product_name, sale in sales.items():
            print(f'Name: {product_name} | Sales: {sale}')
        questions = [
            {
                'type': 'list',
                'name': 'choice',
                'message': '',
                'choices': ['Back']
            }
        ]
        answers = prompt(questions)
        self.seller_main_menu()

    def add_products(self):
        clear_screen()
        print(f'Add Product')
        print('-' * 20)
        product_name = input('Name: ')
        product_category = input('Category: ')
        product_description = input('Description: ')
        product_price = input('Price: ')
        questions = [
            {
                'type': 'confirm',
                'message': 'Do you want to continue?',
                'name': 'continue',
                'default': True,
            }
        ]
        answer = prompt(questions)
        if answer['continue']:
            self.user.add_seller_product(product_name, product_category, product_description, product_price)

        self.seller_main_menu()

    def logout(self):
        exit()


if __name__ == '__main__':
    # logo()
    app = ECommerceApp()
    app.start()
