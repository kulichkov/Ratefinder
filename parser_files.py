#!/usr/bin/python3
#coding=utf-8

"""
    Парсер
"""


from requests_url import Downloader
from string import punctuation


# Парсер файла robots.txt
class Robots():
    # Извлекаем ссылку, сайтМап
    def site_map(url):
        temp = Downloader.open(url)
        if temp:
            for line in temp.split('\n'):
                listLine = line.split(': ')
                if listLine[0] == 'Sitemap':
                    print(listLine[1])
                    return listLine[1]

    # Извлекае хост
    def host(url):
        pass

# Парсер файла *.xml
class Xml():
    pass


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