#!/usr/bin/python3
#coding=utf-8

"""
    Запросы к базе данных
"""

from parser_conf_ini import confgini
import mysql
from mysql.connector import Error
from log import logging


# Работа с Mysql
class Mysql():
    # Иницилизация
    def __init__(self):
        configniMysql = confgini()
        self.ipaddr = configniMysql.get('host', '127.0.0.1')
        self.port = configniMysql.get('port', '3306')
        self.db = configniMysql.get('database')
        self.userName = configniMysql.get('user', 'root')
        self.password = configniMysql.get('password')

    # Подключаемся
    def connect(self):
        try:
            self.dbconnect = mysql.connector.connect(host=self.ipaddr, port=self.port,
                    database=self.db,user=self.userName,password=self.password)
            # Проверяем есть ли конект к базе данных
            if self.dbconnect.is_connected():
                print('Сonnection OK.')
            else:
                logging('Mysql', 'Сonnection failed.')
                print('Сonnection failed.')
                exit()
        except Error as error:
            print(error)
            exit()

    # Выборка
    def execute_select(self, request, *args):
        self.cursor = self.dbconnect.cursor()
        self.cursor.execute(request, args)
        return self.cursor.fetchall()

     # Внесение данных
    def execute(self, request, *args):
        self.cursor = self.dbconnect.cursor()
        self.cursor.execute(request, args)

    # Комитим
    def commit(self):
        self.dbconnect.commit()

    # Закрываем
    def connect_close(self):
        self.dbconnect.close()
        print('Сonnection Close.')