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
        self.username = input(f"Enter {self.role} username: ")
        self.password = getpass.getpass(f"Enter {self.role} password: ")
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
    
    def get_product_details(self):
        product_details = self.db.get_products()
        return product_details
    
    def add_to_cart(self, product_id):
        self.db.add_product_to_cart(self.username,product_id)

    def get_address(self):
        return self.db.get_user_address(self.username)

    def get_payment(self):
        return self.db.get_user_payment(self.username)
    
    def change_address(self, street, state, postal):
        return self.db.update_address(self.username, street, state, postal)
    
    def change_payment(self, payment):
        return self.db.update_payment(self.username, payment)
    
class ECommerceApp:
    def __init__(self):
        self.user = None

    def start(self):
        clear_screen()
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
                if self.user.role=='Customer':
                    self.customer_main_menu()
                else:
                    self.seller_main_menu()
        else:
            self.user = User(answers['role'])
            if self.user.login():
                if answers['role']=='Customer':
                    self.customer_main_menu()
                else:
                    self.seller_main_menu()

    def customer_main_menu(self):
        clear_screen()
        options = ['View Products', 'Cart', 'Profile','Logout']
        questions = [
            {
                'type': 'list',
                'name': 'main_menu',
                'message': 'What would you like to do?',
                'choices': options
            }
        ]
        answers = prompt(questions)
        if answers['main_menu']=='Logout':
            self.logout()
        elif answers['main_menu']=='View Products':
            self.view_products()
        elif answers['main_menu']=='Cart':
            print('Cart')
        elif answers['main_menu']=='Profile':
            self.profile()
    def seller_main_menu(self):
        clear_screen()
        options = ['Add Product', 'View Sales','Logout']
        questions = [
            {
                'type': 'list',
                'name': 'main_menu',
                'message': 'What would you like to do?',
                'choices': options
            }
        ]
        answers = prompt(questions)
        if answers['main_menu']=='Logout':
            self.logout()
        elif answers['main_menu']=='Add Product':
            print('Add Products')
        elif answers['main_menu']=='View Sales':
            print('View Sales')

    def view_products(self):
        list_of_products = self.user.get_product_details()
        page_number = 0
        number_of_pages = len(list_of_products)
        def view_each_product(page_number):
            clear_screen()
            print('Products:')
            print('-'*20)
            product = list_of_products[page_number]
            product_id = product['product_id']
            print('Poduct Name: ',product['product_name'])
            print('Rating: ', product['rating'] )
            print('Description: ',product['description'])
            print('Price: ',product['price'])
            print('-'*20)
            options = ['Add to cart', 'Previous','Next','Back']
            questions = [{
                            'type':'list',
                            'name': 'product_option',
                            'message':'',
                            'choices':options
                        }]
            answers = prompt(questions)
            selection = answers['product_option']
            if selection =='Add to cart':
                self.user.add_to_cart(product_id)
            if selection =='Previous':
                if page_number==0:
                    view_each_product(page_number)
                else:
                    page_number-=1
                    view_each_product(page_number)

            if selection =='Next':
                if page_number==number_of_pages-1:
                    view_each_product(page_number)
                else:
                    page_number+=1
                    view_each_product(page_number)
            if selection=='Back':
                if self.user.role =='Customer':
                    self.customer_main_menu()
                else:
                    self.seller_main_menu()
                
        view_each_product(page_number)


    def cart(self):
        pass

    def profile(self):
        print('Profile')
        print('-'*20)
        print(f'Username: {self.user.username}')
        options = ['Address','Payment', 'Back']
        questions = [{
                        'type':'list',
                        'name': 'option',
                        'message':'',
                        'choices':options
                    }]
        answers = prompt(questions)
        selection = answers['option']
        if selection=='Back':
            if self.user.role =='Customer':
                self.customer_main_menu()
            else:
                self.seller_main_menu()
        elif selection=='Address':
            self._display_change_address()
        elif selection=='Payment':
            self._display_change_payment()

    def _display_change_address(self):
        clear_screen()
        print('Address')
        print('-'*20)
        address = self.user.get_address()
        print(f'Current Address: {address}')
        options = ['Change Address']
        questions = [{
                        'type':'list',
                        'name': 'option',
                        'message':'',
                        'choices':options
                    }]
        answers = prompt(questions)
        if answers['option']=='Change Address':
            bio_question = [
                {
                    'type': 'editor',
                    'name': 'bio',
                    'message': 'Please type in the following format -> Street, State, Postal (Esc+Enter to exit): ',
                }
            ]
            bio_answers = prompt(bio_question)
            try:
                address = bio_answers['bio'].split(' ,')
                if len(address)==3:
                    street = address['street']
                    state = address['state']
                    postal = address['postal']
                    self.user.change_address(street, state, postal)
            except:
                    print("Address wasn't changed!")
            clear_screen()
            self.profile()

            
    def _display_change_payment(self):
        clear_screen()
        address = self.user.get_payment()
        print(f'Current Payment: {address}')
        options = ['Change Payment']
        questions = [{
                        'type':'list',
                        'name': 'option',
                        'message':'',
                        'choices':options
                    }]
        answers = prompt(questions)
        if answers['option']=='Change Payment':
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
        pass

    def add_product(self):
        pass
    
        
    def logout(self):
        exit()

if __name__ == '__main__':
    # logo()
    app = ECommerceApp()
    app.start()