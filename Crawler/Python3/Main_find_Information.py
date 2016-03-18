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
from datetime import datetime
from Crawler.Python3.parser_files import *


# Словарь для хранения ключевых слов
dictKeywords = {}

# Запросы
quest_3 = 'SELECT `PersonID`, `Name` FROM `Keywords`;'
quest_4 = 'SELECT `SiteID`, `Url`, `ID` FROM `Pages` WHERE `LastScanDate` is Null;'
quest_5 = 'INSERT INTO `Pages` (`Url`, `SiteID`) VALUES(%s, %s)'
quest_5_0 = 'UPDATE `Pages` SET `LastScanDate` = %s WHERE `ID` = %s;'
quest_6 = 'INSERT INTO `PersonPageRank` (`PersonID`,`PageID`, `Rank`) VALUES(%s, %s, %s)'

# Создаем для работы с Mysql
workMysql = Mysql()
workMysql.connect()

# Обновляем столбец "LastScanDate" в таблице "Pages"
def lastScanDate(PageID):
    timeStamp = datetime.strftime(datetime.now(), "%Y.%m.%d %H:%M:%S")
    workMysql.execute(quest_5_0, timeStamp, PageID)

# Внесение данных в таблицу "Pages"
def pages(listTemp, SiteID, PageID):
    for x in listTemp:
        lastScanDate(PageID)
        workMysql.execute(quest_5, x, int(SiteID))
    workMysql.commit()

# Внесение данных в таблицу "PersonPageRank"
def personPageRank(dictTemp, PageID):
    lastScanDate(PageID)
    for x in dictTemp.items():
        print(x[0], x[1])
        workMysql.execute(quest_6, int(x[0]), int(PageID), int(x[1]))
    workMysql.commit()

# Делаем список Ключ: Имена
for x in workMysql.execute_select(quest_3):
    if dictKeywords.get(x[0]):
        dictKeywords[x[0]].append(x[1])
    else:
        dictKeywords[x[0]] = [x[1],]

# Перебераем ссылки у которых "lastScanDate" = "Null"
for link in workMysql.execute_select(quest_4):
    print(link)
    #  Узнаем имя файла
    namePage = link[1][link[1].rfind('/'):]
    # Узнаем расширение файла
    pageFormat = namePage[namePage.rfind('.'):]

    # Определение какое рассширение
    if pageFormat == '.xml':
        pages(Xml.satemap(link[1], pageFormat), link[0], link[2])
        pass
    elif pageFormat == '.gz':
        xmlUrl = Xml.satemap(link[1], pageFormat)
        if xmlUrl:
            pages(xmlUrl, link[0], link[2])
        pass
    elif pageFormat == '.txt':
        robotsUrl = Robots.site_map(link[1])
        if robotsUrl:
            pages(robotsUrl, link[0], link[2])
    else:
        parserHtml = Html(link[1], dictKeywords)
        personPageRank(parserHtml.parser(), link[2])
