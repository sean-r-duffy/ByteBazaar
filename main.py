from sqlalchemy import select
from sqlalchemy.orm import Session
from tables import create_schema
from ui import ECommerceApp

# To remove SQL statements from terminal output, set constants.ECHO = False
if __name__ == '__main__':
    create_schema()
    app = ECommerceApp()
    app.start()
