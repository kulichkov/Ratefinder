#!/usr/bin/python3
#coding=utf-8

"""
    Запросы к сайтам
"""

import urllib.request
from urllib.error import URLError


# Работа с URL
class Url():
    # Читаем страницу
    def open(url):
        try:
            temp = urllib.request.urlopen(url).read()
            temp = temp.decode('utf-8')
            return temp
        except URLError:
            return 0

    # Проверка существование страницы
    def available(url):
        try:
            urllib.request.urlopen(url).read()
            return 1
        except URLError:
            return 0