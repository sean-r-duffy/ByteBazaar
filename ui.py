import os
from PyInquirer import prompt
import getpass
from db_operations import DataBase


# from styling import style, logo

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
        product_details = self.db.get_products(category)
        return product_details

    def add_to_cart(self, product_id):
        self.db.add_product_to_cart(self.username, product_id)

    def get_cart_products(self):
        return self.db.get_user_cart(self.username)

    def remove_cart_product(self, product_id):
        self.db.delete_cart_product(self.username, product_id)

    def buy_products(self):
        self.db.buy_user_products(self.username)
        self.db.empty_cart(self.username)

    # TODO: Test, needs to return address_id field
    def get_address(self):
        return self.db.get_user_address(self.username)

    def get_payment(self):
        return self.db.get_user_payment(self.username)

    # TODO: Test, needs address_id field
    def change_address(self, street, state, city, postal):
        return self.db.update_address(self.username, street, city, state, postal)

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
        list_of_products = self.user.get_product_details(category)
        page_number = 0
        number_of_pages = len(list_of_products)

        def view_each_product(page_number):
            clear_screen()
            print('Products')
            print('-' * 20)
            product = list_of_products[page_number]
            product_id = product.product_id
            print('Poduct Name: ', product.name)
            # Displaying rating will require a new rating field and a trigger that updates it when a new review is made
            # print('Rating: ', product['rating'])
            print('Description: ', product.description)
            print('Price: ', product.price)
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

        view_each_product(page_number)

    # TODO: Add quantity to items_view, may need a view in SQL of product + cart
    def cart(self):
        clear_screen()
        print('Cart')
        print('-' * 20)
        list_of_products = self.user.get_cart_products()
        items_view_list = []
        product_id_mapping = {}
        for each_product in list_of_products:
            product_name = each_product.name
            product_id = each_product.product_id
            product_price = str(each_product.price)
            items_view = 'Product Name: ' + product_name + ' | Price: ' + product_price
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
        address = self.user.get_address()
        print(f'Current Address: {address}')
        options = ['Change Address', 'Back']
        questions = [{
            'type': 'list',
            'name': 'option',
            'message': '',
            'choices': options
        }]
        answers = prompt(questions)
        if answers['option'] == 'Back':
            self.customer_main_menu()
        elif answers['option'] == 'Change Address':
            bio_question = [
                {
                    'type': 'editor',
                    'name': 'bio',
                    'message': 'Please type in the following format -> Street, State, City, Postal (Esc+Enter to exit): ',
                }
            ]
            bio_answers = prompt(bio_question)
            try:
                address = bio_answers['bio'].split(' ,')
                if len(address) == 3:
                    street = address[0]
                    state = address[1]
                    city = address[2]
                    postal = address[3]
                    self.user.change_address(street, state, city, postal)
            except:
                print("Address wasn't changed!")
            clear_screen()
            self.profile()

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
