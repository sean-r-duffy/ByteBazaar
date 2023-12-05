from sqlalchemy import create_engine, Integer, String, Float, ForeignKey, DateTime, CheckConstraint, text
from sqlalchemy.orm import mapped_column, DeclarativeBase, Session
from sqlalchemy_utils.functions import database_exists, create_database
import glob
# import mysql
# import mysqlclient
import constants

engine = create_engine(constants.DATABASE_URI, echo=constants.ECHO)


class Base(DeclarativeBase):

    def insert(self):
        with Session(engine) as session:
            session.add(self)
            session.commit()

    def delete(self):
        with Session(engine) as session:
            session.delete(self)
            session.commit()


class Product(Base):
    __tablename__ = 'product'

    product_id = mapped_column(Integer, primary_key=True)
    name = mapped_column(String(50))
    description = mapped_column(String(200))
    category_id = mapped_column(Integer, ForeignKey('category.category_id'))
    price = mapped_column(Float)
    inventory = mapped_column(Integer)


class Category(Base):
    __tablename__ = 'category'

    category_id = mapped_column(Integer, primary_key=True)
    name = mapped_column(String(50))
    description = mapped_column(String(200))


class Image(Base):
    __tablename__ = 'image'

    url = mapped_column(String(100), primary_key=True)
    product_id = mapped_column(Integer, ForeignKey('product.product_id'))


class Seller(Base):
    __tablename__ = 'seller'

    seller_id = mapped_column(Integer, primary_key=True)
    name = mapped_column(String(50))
    username = mapped_column(String(40))
    password = mapped_column(String(40))


class Sells(Base):
    __tablename__ = 'sells'

    seller_id = mapped_column(Integer, ForeignKey('seller.seller_id'), primary_key=True)
    product_id = mapped_column(Integer, ForeignKey('product.product_id'), primary_key=True)


class Campaign(Base):
    __tablename__ = 'campaign'

    campaign_id = mapped_column(String(20), primary_key=True)
    product_id = mapped_column(Integer, ForeignKey('product.product_id'))
    influencer_id = mapped_column(Integer, ForeignKey('influencer.influencer_id'))
    url = mapped_column(String(100))
    platform_name = mapped_column(String(50), ForeignKey('platform.name'))
    units_sold = mapped_column(Integer)


class Influencer(Base):
    __tablename__ = 'influencer'

    influencer_id = mapped_column(Integer, primary_key=True)
    name = mapped_column(String(50), nullable=False)
    username = mapped_column(String(40))
    password = mapped_column(String(40))


class Platform(Base):
    __tablename__ = 'platform'

    name = mapped_column(String(50), primary_key=True)


class Cart(Base):
    __tablename__ = 'cart'

    buyer_username = mapped_column(String(40), ForeignKey('buyer.username'), primary_key=True)
    product_id = mapped_column(Integer, ForeignKey('product.product_id'), primary_key=True)
    quantity = mapped_column(Integer)


class Review(Base):
    __tablename__ = 'review'

    buyer_username = mapped_column(String(40), ForeignKey('buyer.username'), primary_key=True)
    product_id = mapped_column(Integer, ForeignKey('product.product_id'), primary_key=True)
    rating = mapped_column(Integer)
    text = mapped_column(String(1000))
    CheckConstraint('rating <= 10 AND rating >= 0')


class Sale(Base):
    __tablename__ = 'sale'

    sale_id = mapped_column(Integer, primary_key=True)
    shipment_id = mapped_column(Integer, ForeignKey('shipment.shipment_id'))
    product_id = mapped_column(Integer, ForeignKey('product.product_id'))
    quantity = mapped_column(Integer)
    datetime = mapped_column(DateTime)
    promo_code = mapped_column(String(20), ForeignKey('campaign.campaign_id'))


class Buyer(Base):
    __tablename__ = 'buyer'

    username = mapped_column(String(40), primary_key=True)
    name = mapped_column(String(50))
    password = mapped_column(String(40))


class Payment(Base):
    __tablename__ = 'payment'

    card_number = mapped_column(Integer, primary_key=True)
    buyer_username = mapped_column(String(40), ForeignKey('buyer.username'))


class Address(Base):
    __tablename__ = 'address'

    address_id = mapped_column(Integer, primary_key=True)
    buyer_username = mapped_column(String(40), ForeignKey('buyer.username'))
    street = mapped_column(String(50))
    city = mapped_column(String(50))
    state = mapped_column(String(50))
    zip = mapped_column(Integer)


class Shipment(Base):
    __tablename__ = 'shipment'

    shipment_id = mapped_column(Integer, primary_key=True)
    address_id = mapped_column(Integer, ForeignKey('address.address_id'))
    buyer_username = mapped_column(String(40), ForeignKey('buyer.username'))


def create_schema():
    if not database_exists(constants.DATABASE_URI):
        create_database(constants.DATABASE_URI)
        Base.metadata.create_all(engine)

        stored_procs = glob.glob('SQL/Stored Procedures/*.sql')
        functions = glob.glob('SQL/Functions/*.sql')
        views = 'SQL/views.sql'
        data = 'SQL/data.sql'

        with Session(engine) as session:
            for x in stored_procs:
                with open(x) as file:
                    session.execute(text(file.read()))
            for x in functions:
                with open(x) as file:
                    session.execute(text(file.read()))
            with open(views) as file:
                session.execute(text(file.read()))
            with open(data) as file:
                session.execute(text(file.read()))

            session.commit()
