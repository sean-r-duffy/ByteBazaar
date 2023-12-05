from tables import initialize_db
from ui import ECommerceApp

# To remove SQL statements from terminal output, set constants.ECHO = False
if __name__ == '__main__':
    initialize_db()
    app = ECommerceApp()
    app.start()
