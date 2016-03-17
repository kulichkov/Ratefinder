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


# Парсер файла *.xml
class Xml():
    def satemap(url, formatFile):
        listUrl = []
        temp = Downloader.download(url)
        # Проверяем формат файла
        if formatFile == '.gz':
            try:
                with gzip.open(temp) as file:
                    file = file.read()
                    element = 'url'
            except OSError:
                if os.path.isfile(temp):
                    print(temp)
                    os.remove(temp)
                return 0
        else:
            with open(temp) as file:
                file = file.read()
                element = 'sitemap'

        # Создаем объекст
        root = ET.fromstring(file)
        # Перебераем корневые элементы xml
        for x in root.findall('{http://www.sitemaps.org/schemas/sitemap/0.9}' + element):
            try:
                lastmod = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}lastmod').text.split('T')[0]
                if lastmod >= str(datetime.utcnow().date()):
                    listUrl.append(x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}loc').text)
            except AttributeError:
                pass
            else:
                if os.path.isfile(temp):
                    print(temp)
                    os.remove(temp)
        return listUrl


# Парсер файла *.html
class Html():
    #
    def __init__(self, url, keywords):
        self.url = url
        self.keywords = keywords
        self.dictResult = {}

    #
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