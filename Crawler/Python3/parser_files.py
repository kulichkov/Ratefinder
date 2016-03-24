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
import re


# Парсер файла robots.txt
class Robots():
    def __init__(self, url):
        self.url = url
        self.robotsText = Downloader.open(self.url)

    # Извлекаем ссылку, сайтМап
    def site_map(self):
        if self.robotsText:
            for line in self.robotsText.split('\n'):
                listLine = line.split(': ')
                if listLine[0] == 'Sitemap':
                    print(listLine[1])
                    return [listLine[1],]
            else:
                urlSitemap = '/'.join((os.path.split(self.url)[0], 'sitemap.xml'))
                if Downloader.available(urlSitemap):
                    return [urlSitemap,]


# Удаление временных файлов
class Remove_Files():
    # Удаление файлов после обработки
    def remove_files(self):
        if os.path.isfile(self.pathToFile):
            print('Удаление файла из ../temp/' + os.path.split(self.pathToFile)[1])
            os.remove(self.pathToFile)


# Парсер *.gz
class Gz(Remove_Files):
    def gz(self):
        try:
            with gzip.open(self.pathToFile) as file:
                file = file.read()
                element = 'url'
        except OSError:
            pass
            self.remove_files()
            return 0

        # Создаем объекст
        root = ET.fromstring(file)
        # Перебираем корневые элементы xml
        for x in root.findall('{http://www.sitemaps.org/schemas/sitemap/0.9}' + element):
            try:
                lastmod = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}lastmod').text.split('T')[0]
                # Если текущая дата берем ссылку
                if self.lastAll or lastmod >= str(datetime.utcnow().date()):
                    urlLoc = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}loc').text
                    print('Новая ссылка ' + urlLoc + ' с датой ' + lastmod)
                    yield (urlLoc,)
                    #self.listUrl.append(urlLoc)
            except AttributeError:
                pass
            finally:
                pass
                self.remove_files()
        else:
            pass
            self.remove_files()


# Парсер файла *.xml
class Xml(Gz):
    def __init__(self, url, lastAll=0):
        self.url = url
        self.listUrl = []
        self.pathToFile = Downloader.download(self.url)
        self.lastAll = lastAll

    # Извлекаем ссылки нужной даты
    def sitemap(self):
        #print(self.pathToFile)
        with open(self.pathToFile) as file:
            file = file.read()
            element = 'sitemap'

        # Создаем объекст
        root = ET.fromstring(file)
        # Перебираем корневые элементы xml
        for x in root.findall('{http://www.sitemaps.org/schemas/sitemap/0.9}' + element):
            try:
                # Рубим строку с датой по букве (T)
                lastmod = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}lastmod').text.split('T')[0]
                #
                urlLoc = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}loc').text
                #print(re.search(u'(news)', urlLoc))
                # Если текущая дата берем ссылку
                if lastmod >= str(datetime.utcnow().date()) and (re.search(u'(news)', urlLoc)):
                    # urlLoc = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}loc').text
                    print('Новая ссылка ' + urlLoc + ' с датой ' + lastmod)
                    self.listUrl.append(urlLoc)
            except AttributeError:
                pass
            finally:
                self.remove_files()
        else:
            self.remove_files()
        return self.listUrl


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