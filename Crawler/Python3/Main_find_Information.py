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
from parser_files import *
from logging import *


# Главная функция
@benchmark
@log
def main():
    # Переменная если сканирование уже сегодня выполнялось
    toDay = 0
    # Словарь для хранения ключевых слов
    dictKeywords = {}

    # Запросы
    quest_3 = 'SELECT `PersonID`, `Name` FROM `Keywords`;'
    quest_4 = 'SELECT `SiteID`, `Url`, `ID` FROM `Pages` WHERE `LastScanDate` is Null;'
    quest_4_0 = 'SELECT `SiteID`, `Url`, `ID` FROM `Pages` ' \
                'WHERE ((`Url` LIKE "%/%.xml") OR (`Url` LIKE "%/%.xml.gz")) ' \
                'ORDER BY `LastScanDate` LIMIT 10;'
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
            #lastScanDate(PageID)
            workMysql.execute(quest_5, x, int(SiteID))
        else:
            lastScanDate(PageID)
            workMysql.commit()

    # Внесение данных в таблицу "PersonPageRank"
    def personPageRank(dictTemp, PageID):
        #lastScanDate(PageID)
        for x in dictTemp.items():
            print(x[0], x[1])
            workMysql.execute(quest_6, int(x[0]), int(PageID), int(x[1]))
        else:
            lastScanDate(PageID)
            workMysql.commit()

    # Распределение ссылок по парсерам
    def route_parser(link):
        print(link)
        #  Узнаем имя файла
        namePage = link[1][link[1].rfind('/'):]
        # Узнаем расширение файла
        pageFormat = namePage[namePage.rfind('.'):]

        # Определение какое рассширение
        if pageFormat == '.xml':        # Если *.xml
            pages(Xml.satemap(link[1], pageFormat), link[0], link[2])
        elif pageFormat == '.gz':       # Если *.gz
            xmlUrl = Xml.satemap(link[1], pageFormat)
            if xmlUrl:
                pages(xmlUrl, link[0], link[2])
            else:
                lastScanDate(link[2])
        elif pageFormat == '.txt':      # Если *.txt
            robotsUrl = Robots.site_map(link[1])
            if robotsUrl:
                pages(robotsUrl, link[0], link[2])
            else:
                lastScanDate(link[2])
        else:                           # Все остальное обыскиваем=)
            parserHtml = Html(link[1], dictKeywords)
            personPageRank(parserHtml.parser(), link[2])

    # Делаем список Ключ: Имена
    for x in workMysql.execute_select(quest_3):
        if dictKeywords.get(x[0]):
            dictKeywords[x[0]].append(x[1])
        else:
            dictKeywords[x[0]] = [x[1],]

    # Выборка новых ссылоко
    urlNullLast = workMysql.execute_select(quest_4)

    # Если результат пустой выполняем проход по старым ссылкам.
    if urlNullLast:
        # Перебераем ссылки у которых "lastScanDate" = "Null"
        for link in urlNullLast:
            route_parser(link)
        else:
            workMysql.connect_close()
    else:
        #
        #   Доделать
        #
        if toDay:
            # Выборка старых ссылоко
            urlOldlast = workMysql.execute_select(quest_4_0)
            if urlOldlast:
                # Перебираем последних 10 старые ссылок
                for link in urlOldlast:
                    route_parser(link)
                else:
                    workMysql.connect_close()

# Проверка
if __name__ == '__main__':
    main()