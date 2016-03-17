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
        tesss = 1
        temp = Downloader.download(url)
        #
        if formatFile == '.gz':
            try:
                with gzip.open(temp) as file:
                    file = file.read()
                    element = 'url'
                    #print(file)
            except OSError:
                return 0
            # finally:
            #     rmdir(temp)
        else:
            #try:
            with open(temp) as file:
                #print(type(f))
                file = file.read()
                element = 'sitemap'
            # finally:
            #     rmdir(temp)
        #
        root = ET.fromstring(file)
        #
        for x in root.findall('{http://www.sitemaps.org/schemas/sitemap/0.9}' + element):
            try:
                #tesss +=1
                #print(tesss)
                lastmod = x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}lastmod').text.split('T')[0]
                #print(lastmod)
                if lastmod >= '2016-03-17':
                    print(lastmod)
                    #return listUrl
                    listUrl.append(x.find('{http://www.sitemaps.org/schemas/sitemap/0.9}loc').text)
                #print(listUrl)
                #return listUrl
            except AttributeError:
                pass
            else:
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
        #print(self.url)
        rawHtml = Downloader.open(self.url)
        if rawHtml:
            rawHtml = rawHtml[rawHtml.find('<p>') + 3:rawHtml.rfind('</p>')]
            #print(rawHtml)
            #print(self.keywords)
            for word in rawHtml.split():
                word = word.strip(punctuation)
                #print(word)
                for keywords in self.keywords.items():
                    #print(keywords)
                    #print(type(keywords))
                    #print(keywords.values())
                    if word in keywords[1]:
                        #print(word)
                        #print(keywords)
                        self.dictResult[keywords[0]] = self.dictResult.get(keywords[0], 0) + 1

                    # pass
            return self.dictResult