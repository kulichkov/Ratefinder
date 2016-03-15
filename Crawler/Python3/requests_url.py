#!/usr/bin/python3
#coding=utf-8

"""
    Запросы к сайтам
"""

import urllib.request
from urllib.error import URLError
from os.path import split
from os import chdir
import http.cookiejar, urllib.request, urllib.parse


# Работа с URL
class Url():
    # Читаем страницу
    def open(url):
        try:
            temp = urllib.request.urlopen(url).read()
            return temp.decode('utf-8')
        except URLError:
            return 0

    # Скачиваем
    def downloader(url, directory=split(__file__)[0]):
        # Рабочия деректория
        chdir(directory + '/temp')
        # Извлекаем из URL имя файла
        destination = url.rsplit('/',1)[1]
        # Скачиваем файл
        urllib.request.urlretrieve(url, destination)

    # Проверка существование страницы
    def available(url):
        try:
            # обработка cookies
            cookie = http.cookiejar.CookieJar()
            opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cookie))
            # прикидываемся браузером, не обязательно
            opener.addheaders = [('User-agent', 'Opera/9.80 (Windows NT 6.1; WOW64; U; ru) Presto/2.10.229 Version/11.62')]
            # коннект
            urllib.request.install_opener(opener)

            # авторизация и подсовывание cookies
            opener.open(url)
            #urllib.request.urlopen(url).read()
            return 1
        except URLError:
            return 0

print(Url.available('http://lenta.ru/sitemap.xml'))