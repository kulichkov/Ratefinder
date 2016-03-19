#!/usr/bin/python3
#coding=utf-8

"""
    Парсер
"""

from requests_url import Downloader
from string import punctuation
import gzip
import xml.etree.ElementTree as ET
import os
from datetime import datetime


# Парсер файла robots.txt
class Robots():
    # Извлекаем ссылку, сайтМап
    def site_map(url):
        temp = Downloader.open(url)
        if temp:
            for line in temp.split('\n'):
                listLine = line.split(': ')
                if listLine[0] == 'Sitemap':
                    #print(listLine[1])
                    return [listLine[1],]
            else:
                urlSitemap = '/'.join((os.path.split(url)[0], 'sitemap.xml'))
                if Downloader.available(urlSitemap):
                    #print(urlSitemap)
                    return [urlSitemap,]


# Парсер файла *.xml
class Xml():
    # Извлекаем ссылки нужной даты
    def satemap(url, formatFile):
        # Удаление файлов после обработки
        def removeFiles(path):
            if os.path.isfile(path):
                print('Удаление файла из ../temp/' + os.path.split(path)[1])
                os.remove(path)
        # Для хранение результата
        listUrl = []
        # Получение путь до скачанного файла
        temp = Downloader.download(url)

        # Проверка формата файла
        if formatFile == '.gz':
            try:
                with gzip.open(temp) as file:
                    file = file.read()
                    element = 'url'
            except OSError:
                removeFiles(temp)
                return 0
        else:
            with open(temp) as file:
                file = file.read()
                element = 'sitemap'

        # Создаем объекст
        root = ET.fromstring(file)
        # Перебираем корневые элементы xml
        for x in root.findall('{http://www.sitemaps.org/schemas/sitemap/0.9}' + element):
            try:
                lastmod = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}lastmod').text.split('T')[0]
                # Если текущая дата берем ссылку
                if lastmod >= str(datetime.utcnow().date()):
                    urlLoc = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}loc').text
                    print('Новая ссылка ' + urlLoc + ' с датой ' + lastmod)
                    listUrl.append(urlLoc)
            except AttributeError:
                pass
            finally:
                removeFiles(temp)
        else:
            removeFiles(temp)
        return listUrl


# Парсер файла *.html
class Html():
    def __init__(self, url, keywords):
        self.url = url
        self.keywords = keywords
        self.dictResult = {}

    # Извлекаем словарь KeyWords: Количество упоминаний
    def parser(self):
        rawHtml = Downloader.open(self.url)
        if rawHtml:
            rawHtml = rawHtml[rawHtml.find('<p>') + 3:rawHtml.rfind('</p>')]
            for word in rawHtml.split():
                word = word.strip(punctuation)
                for keywords in self.keywords.items():
                    if word in keywords[1]:
                        self.dictResult[keywords[0]] = self.dictResult.get(keywords[0], 0) + 1
            return self.dictResult