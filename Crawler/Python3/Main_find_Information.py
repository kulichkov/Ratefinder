#!/usr/bin/python3
#coding=utf-8

"""
    Главный модуль работы Краулера
    2. Обход ссылок, которых по которым раньше не производился обход
    Найти в таблице Pages ссылку, у которой LastScanDate равен null.
    Скачать HTML по данной ссылке
    В зависимости от того, что это была за ссылка, выполняем следующие действия:
    i. Если ссылка ведет на robots.txt, находим в HTML-е ссылку на
    sitemap, и добавляем ее в таблицу Pages
    ii. Если ссылка ведет на sitemap, находим в HTML-е все ссылки с сайта,
    добавляем их в Pages.
    iii. Если ссылка ведет на страницу сайта, найти количество вхождений
    ключевых слов для каждой личности, и сохранить результаты в таблице PersonPageRank.
"""

from requests_sql import Mysql

from Crawler.Python3.parser_files import *

dictKeywords = {}

quest_3 = 'SELECT `PersonID`, `Name` FROM `Keywords`;'
quest_4 = 'SELECT `ID`, `Url` FROM `Pages` WHERE `LastScanDate` is Null;'

workMysql = Mysql()
workMysql.connect()


def pages(dict):
    for x in dict.items():
        print(x)
        pass

def personPageRank():
    pass


# Делаем список Ключ: Имена
for x in workMysql.execute_select(quest_3):
    #print(x)
    if dictKeywords.get(x[0]):
        dictKeywords[x[0]].append(x[1])
    else:
        dictKeywords[x[0]] = [x[1],]


for link in workMysql.execute_select(quest_4):
    dictTemp = {}

    #
    namePage = link[1][link[1].rfind('/'):]
    pageFormat = namePage[namePage.rfind('.'):]

    # Определение какое рассширение
    if pageFormat == '.xml':
        dictTemp[link[0]] = Xml.satemap(link[1], pageFormat)
        pages(dictTemp)
    elif pageFormat == '.gz':
       #dictTemp[link[0]] = Xml.satemap(link[1], pageFormat)
       #pages(dictTemp)
        pass
    elif pageFormat == '.txt':
        Robots.site_map(link[1])
    else:
        parserHtml = Html(link[1], dictKeywords)
        print(parserHtml.parser())
