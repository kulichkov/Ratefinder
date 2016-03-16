#!/usr/bin/python3
#coding=utf-8

"""
    Запросы к базе данных
"""


# Подключаем модуль работы с *.ini фаилам
from parser_conf_ini import confgini
# ORM
import sqlalchemy
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine, text



dbconnect = create_engine('mysql+mysqlconnector://root:obKRBEa8h45X8sQhtALf@192.168.2.252/database', echo=False)

class Table():
    #print('testt')
    pass

# for x in dbconnect.execute('SELECT * FROM `Sites`'):
#     print(x)
#
meta = sqlalchemy.MetaData(bind=dbconnect, reflect=True)
# table = meta.tables['Sites']
# print(list(dbconnect.execute(table.select(table.c.ID == 2))))

sqlalchemy.orm.Mapper(Table, meta.tables['Sites'])