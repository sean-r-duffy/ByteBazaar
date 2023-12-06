import os
import time
from PyInquirer import prompt
import getpass
from db_operations import DataBase
from constants import logo

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import seaborn as sns

# from constants import style, logo

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

def zip_to_str(int):
    zip_string = str(int)
    zip_string = '0' * (5 - len(zip_string)) + zip_string
    return zip_string


class User:
    def __init__(self, role):
        self.role = role
        self.username = None
        self.password = None
        self.db = DataBase()

    # TODO: add message and handling for when response == False
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

    def get_images(self, product_id):
        return self.db.get_images(product_id)

    def add_to_cart(self, product_id):
        self.db.add_product_to_cart(self.username, product_id)

    def get_cart_subtotal(self):
        return self.db.get_cart_subtotal(self.username)

    def get_cart_products(self):
        return self.db.get_user_cart(self.username)

    def remove_cart_product(self, product_id):
        self.db.delete_cart_product(self.username, product_id)

    def buy_products(self, address_id, card_number, promo_code=''):
        self.db.buy_user_products(self.username, address_id, card_number, promo_code)

    def get_reviews(self, product_id):
        return self.db.get_reviews(product_id)

    def enter_product_rating(self,product_id, rating, description):
        self.db.add_review(self.username, product_id, rating, description)

    def get_addresses(self):
        return self.db.get_user_addresses(self.username)
    
    def get_payment_methods(self):
        return self.db.get_user_payments(self.username)

    def get_payment(self):
        return self.db.get_user_payments(self.username)

    def change_address(self, address_id, street, state, city, postal):
        return self.db.update_address(address_id, street, city, state, postal)

    def delete_address(self, address_id):
        return self.db.delete_address(address_id)

    def insert_address(self, street, city, state, postal):
        return self.db.insert_address(self.username, street, city, state, postal)

    def change_payment(self,old_card_number, new_card_number):
        return self.db.update_payment(self.username, old_card_number, new_card_number)

    def delete_payment(self, old_card_number):
        return self.db.delete_payment(old_card_number)

    def add_new_payment(self,payment):
        return self.db.insert_payment(self.username, payment)

    def add_seller_product(self, product_name, product_category, product_description, product_price):
        return self.db.add_product(product_name, product_category, product_description, product_price)

    def get_sales(self):
        return self.db.get_seller_sales(self.username)

    def prod_name_from_id(self, product_id):
        return self.db.prod_name_from_id(product_id)

    def add_image(self, url, product_id):
        return self.db.add_image(url, product_id)

class ECommerceApp:
    def __init__(self):
        self.user = None

    def start(self):
        clear_screen()
        logo()
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
            else:
                print(f'Incorrect Username/ Password')
                time.sleep(2)
                self.start()

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
            images = self.user.get_images(product_id)
            for x in images:
                print(x)
            print('Product Name: ', product.name)
            print('Description: ', product.description)
            print('Price: ', product.price)
            print('-' * 20)
            options = ['Reviews','Add to cart', 'Previous', 'Next', 'Back']
            questions = [{
                'type': 'list',
                'name': 'product_option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['product_option']
            if selection=='Reviews':
                self.reviews_selection(product.name, product_id)
            elif selection == 'Add to cart':
                self.user.add_to_cart(product_id)
                view_each_product(page_number)
            elif selection == 'Previous':
                if page_number == 0:
                    view_each_product(page_number)
                else:
                    page_number -= 1
                    view_each_product(page_number)
            elif selection == 'Next':
                if page_number == number_of_pages - 1:
                    view_each_product(page_number)
                else:
                    page_number += 1
                    view_each_product(page_number)
            else:
                if self.user.role == 'Customer':
                    self.customer_main_menu()
                else:
                    self.seller_main_menu()

        view_each_product(page_number)

    def reviews_selection(self, product_name, product_id):
        clear_screen()
        print(f'Reviews: {product_name}')
        print('-' * 20)
        options = ['View Reviews','Write Review', 'Back']
        reviews_options = [{
            'type': 'list',
            'name': 'reviews_option',
            'message': '',
            'choices': options
        }]
        reviews_answer = prompt(reviews_options)
        selection = reviews_answer['reviews_option']
        if selection == 'View Reviews':
            reviews = self.user.get_reviews(product_id) # Reviews list
            self.view_reviews(reviews,product_name)
        elif selection =='Write Review':
            self.write_review(product_name, product_id)

    def write_review(self, product_name, product_id):
        clear_screen()
        print(f'Write Review: {product_name}')
        print('-' * 20)
        options = ['1','2','3','4','5']
        rating_questions = [{
            'type': 'list',
            'name': 'rating_option',
            'message': 'Please provide a rating',
            'choices': options
        }]
        rating_answers = prompt(rating_questions)
        rating = rating_answers['rating_option']
        write_review_quesstion = [
                        {
                            'type': 'editor',
                            'name': 'bio',
                            'message': 'Please Write the review (Esc+Enter to exit): ',
                        }
                    ]
        bio_answers = prompt(write_review_quesstion)
        review = bio_answers['bio']
        self.user.enter_product_rating(product_id, int(rating), review)
        self.customer_main_menu()

    # TODO: Errors out when reviews is empty
    def view_reviews(self, reviews, product_name):
        page_number = 0
        if not reviews:
            reviews = ['']
        number_of_pages = len(reviews)
        def view_each_review(page_number):
            clear_screen()
            print(f'Reviews: {product_name}')
            print('-' * 20)
            review = reviews[page_number].text
            print(review)
            # print('Poduct Name: ', product.name)
            # # Displaying rating will require a new rating field and a trigger that updates it when a new review is made
            # # print('Rating: ', product['rating'])
            # print('Description: ', product.description)
            # print('Price: ', product.price)
            print('-' * 20)
            options = ['Previous', 'Next', 'Back']
            questions = [{
                'type': 'list',
                'name': 'review_option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['review_option']
            if selection == 'Previous':
                if page_number == 0:
                    view_each_review(page_number)
                else:
                    page_number -= 1
                    view_each_review(page_number)
            elif selection == 'Next':
                if page_number == number_of_pages - 1:
                    view_each_review(page_number)
                else:
                    page_number += 1
                    view_each_review(page_number)
            else:
                if self.user.role == 'Customer':
                    self.customer_main_menu()
                else:
                    self.seller_main_menu()
                    self.seller_main_menu()

        view_each_review(page_number)

    # TODO: Add quantity to items_view, may need a view in SQL of product + cart
    def cart(self):
        clear_screen()
        print('Cart (Select the product you want to remove from cart)')
        print('-' * 20)
        list_of_products = self.user.get_cart_products()
        cart_subtotal = self.user.get_cart_subtotal()
        items_view_list = []
        product_id_mapping = {}
        len_of_products = len(list_of_products)
        if len_of_products==0:
            print(f'Please add products to cart')
            time.sleep(2)
            self.customer_main_menu()
        for current_product, item in enumerate(list_of_products):
            product = item[0]
            qty = item[1]
            product_name = product.name
            product_id = product.product_id
            product_price = str(product.price)
            # TODO: Product quantity
            items_view = 'Product Name: ' + product_name + ' | Price: ' + product_price + ' | Quantity: ' + str(qty)
            items_view_list.append(items_view)
            if current_product==len_of_products-1:
                items_view_list.append('-'*20)
                items_view_list.append(f'Total: ${cart_subtotal}')
                items_view_list.append('-'*20)
            product_id_mapping[items_view] = product_id
        questions = [
            {
                'type': 'list',
                'name': 'choice',
                'message': '',
                'choices': items_view_list + ['Buy', 'Back']
            }
        ]
        answers = prompt(questions)
        selection = answers['choice']
        if '-'*20 == selection:
            self.cart()
        elif 'Total: $.' in selection:
            self.cart()
        elif selection == 'Back':
            if self.user.role == 'Customer':
                self.customer_main_menu()
            else:
                self.seller_main_menu()
        elif selection == 'Buy':
            clear_screen()
            print('Buy')
            print('-' * 20)
            addresses = self.user.get_addresses() # Need key value pairs with address id: address
            if not addresses:
                print(f'No Address found. Please add new address')
                options = ['Add New Address', 'Back']
                questions = [{
                    'type': 'list',
                    'name': 'option',
                    'message': '',
                    'choices': options
                }]
                answers = prompt(questions)
                selection = answers['option']
                if selection == 'Back':
                    self.profile()
                else:
                    self.add_new_address_window()
            address_prompt = [
                {
                    'type': 'list',
                    'name': 'choice',
                    'message': 'Select the address: ',
                    'choices': [{'name': (', ').join([addr.street, addr.city, addr.state, zip_to_str(addr.zip)]),
                                 'value': addr.address_id} for addr in addresses]
                }
            ]

            address_selection = prompt(address_prompt)
            address_id = address_selection['choice']
            payment_methods = self.user.get_payment_methods()
            if not payment_methods:
                options = ['Add New Payment Method', 'Back']
                questions = [{
                    'type': 'list',
                    'name': 'option',
                    'message': '',
                    'choices': options
                }]
                answers = prompt(questions)
                selection = answers['option']
                if selection == 'Back':
                    self.profile()
                else:
                    self.add_new_payment_method_window()

            payment_prompt = [
                {
                    'type': 'list',
                    'name': 'choice',
                    'message': 'Select the payment method: ',
                    'choices': [str(pymt.card_number) for pymt in payment_methods]
                }
            ]
            payment_selection = prompt(payment_prompt)
            payment_id = payment_selection['choice']
            self.user.buy_products(address_id, int(payment_id))
            self.cart()
        else:
            self.user.remove_cart_product(product_id_mapping[selection])
            self.cart()


    def profile(self):
        clear_screen()
        print('Profile')
        print('-' * 20)
        print(f'Username: {self.user.username}')
        # TODO: Handle error
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
        options = ['View Addresses','Add New Address', 'Update Existing Address','Back']
        questions = [{
            'type': 'list',
            'name': 'choice',
            'message': '',
            'choices': options
        }]
        answer = prompt(questions)
        selection = answer['choice']
        if selection == 'View Addresses':
            self.view_addresses()
        elif selection =='Add New Address':
            self.add_new_address_window()
        elif selection =='Update Existing Address':
            self.update_address()
        else:
            self.profile()

    def view_addresses(self):
        addresses = self.user.get_addresses()
        clear_screen()
        print(f'Address')
        print('-'*20)
        if not addresses:
            options = ['Add New Address','Back']
            questions = [{
                'type': 'list',
                'name': 'option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['option']
            if selection=='Back':
                self.profile()
            else:
                self.add_new_address_window()
        else:
            for addr in addresses:
                print((', ').join([addr.street, addr.city, addr.state, zip_to_str(addr.zip)]))
            options = ['Back']
            questions = [{
                'type': 'list',
                'name': 'review_option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['review_option']
            self.profile()

    def add_new_address_window(self):
        clear_screen()
        print(f'Add New Address')
        print('-'*20)
        bio_question = [
            {
                'type': 'editor',
                'name': 'bio',
                'message': 'Please type in the following format -> Street, City, State, Postal (Esc+Enter to exit): ',
            }
        ]
        bio_answers = prompt(bio_question)
        try:
            address = bio_answers['bio'].split(', ')
            if len(address) == 4:
                street = address[0]
                state = address[1]
                city = address[2]
                postal = address[3]
                self.user.insert_address(street, city, state, postal)
            else:
                print(f'Address not entered')
                time.sleep(2)
        except:
            print("Address wasn't changed!")
            time.sleep(2)
        clear_screen()
        self.profile()


    def update_address(self):
        clear_screen()
        print(f'Update Existing Address')
        print('-'*20)
        addresses = self.user.get_addresses()
        if not addresses:
            options = ['Add New Address','Back']
            questions = [{
                'type': 'list',
                'name': 'review_option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['review_option']
            if selection=='Back':
                self.profile()
            else:
                self.add_new_address_window()
        address_prompt = [
            {
                'type': 'list',
                'name': 'choice',
                'message': 'Select the Address',
                'choices': [{'name': (', ').join([addr.street, addr.city, addr.state, zip_to_str(addr.zip)]), 'value': addr.address_id} for addr in addresses]
            }
        ]
        address_selection = prompt(address_prompt)
        address_id = address_selection['choice']
        address_objs = next(addr for addr in addresses if addr.address_id== address_id)
        selected_address = ', '.join([address_objs.street, address_objs.city, address_objs.state,zip_to_str(address_objs.zip)])
        clear_screen()
        print(f'Update Existing Address: {selected_address}')
        print('-'*20)
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
                    'message': 'Leave blank to delete or type new address in the format -> Street, State, City, Postal '
                               '(Esc+Enter to exit): ',
                }
            ]
            bio_answers = prompt(bio_question)
            try:
                print(bio_answers['bio'])
                address = bio_answers['bio'].split(', ')
                if len(address) == 4:
                    street = address[0]
                    state = address[1]
                    city = address[2]
                    postal = address[3]
                    self.user.change_address(address_id, street, state, city, postal)
                if bio_answers['bio']=='':
                    self.user.delete_address(address_id)
            except Exception as e:
                # print(e)
                print("Address wasn't changed!")
                time.sleep(2)
            clear_screen()
            self.profile()

    # TODO: Adjust to handle multiple payments, adding, editing, deleting, payments
    # TODO: Display cvv and exp date
    def _display_change_payment(self):
        clear_screen()
        print(f'Payment')
        print('-'*20)
        options = ['View Payment Methods','Add New Payment Method', 'Update Existing Payment Method','Back']
        questions = [{
            'type': 'list',
            'name': 'choice',
            'message': '',
            'choices': options
        }]
        answer = prompt(questions)
        selection = answer['choice']
        if selection == 'View Payment Methods':
            self.view_payment_methods()
        elif selection =='Add New Payment Method':
            self.add_new_payment_method_window()
        elif selection =='Update Existing Payment Method':
            self.update_existing_payment_methods()
        else:
            self.profile()

    def view_payment_methods(self):
        payments = self.user.get_payment_methods()
        clear_screen()
        print(f'Payment Methods')
        print('-'*20)
        if not payments:
            options = ['Add New Payment Method','Back']
            questions = [{
                'type': 'list',
                'name': 'option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['option']
            if selection=='Back':
                self.profile()
            else:
                self.add_new_payment_method_window()
        else:
            for payment in payments:
                print(payment.card_number)
            options = ['Back']
            questions = [{
                'type': 'list',
                'name': 'review_option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['review_option']
            self.profile()

    def add_new_payment_method_window(self):
        clear_screen()
        print(f'Add New Payment Method')
        print('-'*20)
        bio_question = [
            {
                'type': 'editor',
                'name': 'bio',
                'message': 'Please your card details (Esc+Enter to exit): ',
            }
        ]
        bio_answers = prompt(bio_question)
        payment = bio_answers['bio']
        self.user.add_new_payment(payment)
        clear_screen()
        self.profile()


    def update_existing_payment_methods(self):
        clear_screen()
        print(f'Update Existing Payment Method')
        print('-'*20)
        payment_methods = self.user.get_payment_methods()
        if not payment_methods:
            options = ['Add New Payment Method','Back']
            questions = [{
                'type': 'list',
                'name': 'review_option',
                'message': '',
                'choices': options
            }]
            answers = prompt(questions)
            selection = answers['review_option']
            if selection=='Back':
                self.profile()
            else:
                self.add_new_payment_method_window()
        payment_prompt = [
            {
                'type': 'list',
                'name': 'choice',
                'message': 'Select the Address',
                'choices': [str(pymt.card_number) for pymt in payment_methods]
            }
        ]
        payment_selection = prompt(payment_prompt)
        card_number = payment_selection['choice']
        clear_screen()
        print(f'Update Existing Payment Method: {card_number}')
        print('-'*20)
        options = ['Change Payment Method', 'Back']
        questions = [{
            'type': 'list',
            'name': 'option',
            'message': '',
            'choices': options
        }]
        answers = prompt(questions)
        if answers['option'] == 'Back':
            self.customer_main_menu()
        elif answers['option'] == 'Change Payment Method':
            bio_question = [
                {
                    'type': 'editor',
                    'name': 'bio',
                    'message': 'Please your card details or leave blank to delete this payment (Esc+Enter to exit): ',
                }
            ]
            bio_answers = prompt(bio_question)
            payment = bio_answers['bio']
            if payment == '':
                self.user.delete_payment(card_number)
            else:
                self.user.change_payment(card_number, payment)
            clear_screen()
            self.profile()

    def view_sales(self):
        clear_screen()
        print(f'Sales')
        print('-' * 20)
        sales = self.user.get_sales()
        for sale_objs in sales:
            print(f'Name: {self.user.prod_name_from_id(sale_objs.product_id)} | Sales: {sale_objs.quantity}')
        questions = [
            {
                'type': 'list',
                'name': 'choice',
                'message': '',
                'choices': ['Visualize Sales', 'Visualize Sales By Month','Back']
            }
        ]
        answers = prompt(questions)
        if answers['choice']=='Visualize Sales':
            self._barplot(sales)

        elif answers['choice']=='Visualize Sales By Month':
            self._lineplot(sales)
        else:
            self.seller_main_menu()



    def _barplot(self,sales):
        df = pd.DataFrame([(self.user.prod_name_from_id(sale_objs.product_id),
                            sale_objs.quantity) for sale_objs in sales], columns=['product', 'sales'])
        df = df.groupby('product').sum('sales').sort_values('sales')
        sns.set(style="whitegrid")
        plt.figure(figsize=(10, 6))
        sns.barplot(x='product', y='sales', data=df, palette="viridis")
        plt.title('Sales by Product')
        plt.xlabel('Product')
        plt.ylabel('Sales')
        plt.xticks(rotation=45)
        plt.show(block=True)
        self.view_sales()


    def _lineplot(self,sales):
        df = pd.DataFrame([(self.user.prod_name_from_id(sale_objs.product_id), sale_objs.quantity,
                            sale_objs.datetime) for sale_objs in sales], columns=['product', 'sales','date'])
        df['date'] = pd.to_datetime(df['date'])
        df = df.groupby([pd.Grouper(key='date', freq='M'), 'product'])['sales'].sum().reset_index()
        
        sns.set(style="whitegrid")
        plt.figure(figsize=(10, 6))
        sns.lineplot(x='date', y='sales', data=df, hue='product',marker='o')
        # sns.lineplot(x='date', y='sales', data=df,marker='o')
        plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%B'))
        plt.gca().xaxis.set_major_locator(mdates.MonthLocator())
        plt.xticks(rotation=45)
        plt.title('Sales by Product Per Month')
        plt.xlabel('Product')
        plt.ylabel('Sales')
        plt.show(block=True)
        self.view_sales()
        
    def add_products(self):
        clear_screen()
        print(f'Add Product')
        print('-' * 20)
        product_name = input('Name: ')
        options = self.user.get_product_categories()
        questions = [
            {
                'type': 'list',
                'name': 'choice',
                'message': 'Category: ',
                'choices': options
            }
        ]
        answers = prompt(questions)
        product_category = answers['choice']
        product_description = input('Description: ')
        product_price = input('Price: ')
        product_images = input('Image URLs (separate with ", "): ')
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
            product_id = self.user.add_seller_product(product_name, product_category, product_description, product_price)
            print(product_id)
            if product_images != '':
                urls = product_images.split(', ')
                for url in urls:
                    self.user.add_image(url, product_id)

        self.seller_main_menu()

    def logout(self):
        exit()


if __name__ == '__main__':
    # logo()
    app = ECommerceApp()
    app.start()
