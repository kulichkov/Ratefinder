#!/usr/bin/python3
#coding=utf-8

"""
    Запросы к сайтам
"""

import requests
from  requests.exceptions import HTTPError
from os.path import split
from os import chdir


class Downloader():
    # Читаем страницу
    def open(url):
        try:
            temp = requests.get(url)
            if temp.status_code == 200:
                return temp.text
            raise HTTPError
        except HTTPError:
            return 0

    # Скачиваем
    def download(url, directory=split(__file__)[0] + '/temp'):
        # Переход в рабочию деректорию
        chdir(directory)
        # Получение имени файла из URL
        destination = url.rsplit('/',1)[1]
        # Скачиваем файл
        temp = requests.get(url, stream = True).text
        with open(destination, "w") as file:
            file.write(temp)

    # Проверка существование страницы
    def available(url):
        try:
            if requests.get(url).status_code != 200:
                raise HTTPError
            return 1
        except HTTPError:
            return 0

print(Downloader.download('http://lenta.ru/sitemap.xml'))