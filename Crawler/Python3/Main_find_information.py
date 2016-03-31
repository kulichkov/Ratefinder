#!/usr/bin/python3
#coding=utf-8

"""
    Главный модуль работы Краулера
    2. Обход ссылок, которых по которым раньше не производился обход
    Найти в таблице Pages ссылку, у которой LastScanDate равен null.
    Скачать HTML по данной ссылке
    В зависимости от того, что это была за ссылка,
    выполняем следующие действия:
    i. Если ссылка ведет на robots.txt, находим в HTML-е ссылку на
    sitemap, и добавляем ее в таблицу Pages
    ii. Если ссылка ведет на sitemap, находим в HTML-е все ссылки с сайта,
    добавляем их в Pages.
    iii. Если ссылка ведет на страницу сайта, найти количество вхождений
    ключевых слов для каждой личности, и сохранить результаты
    в таблице PersonPageRank.
"""


from requests_sql import Mysql
from datetime import datetime
from parser_files import Xml, Html, Robots
import os.path
from log import logging, benchmark


__version__ = 'v1.0'
__author__ = 'Developer'

# Главная функция
@benchmark
def main_find_info():
    # Нужна для проверки изменение в таблице keywords, только один раз.
    oneStart = True
    #
    dayAll = 0
    # Словарь для хранения ключевых слов
    dictKeywords = {}
    # Пути до временных файлов
    fileTempToDay = os.path.split(__file__)[0] + '/temp.ini'
    fileTempCountKeyWords = os.path.split(__file__)[0] + \
                            '/temp_countKeywords.ini'
    # Текущая дата в формате ХХХХ-ХХ-ХХ
    toDay = str(datetime.today().date())

    # Запросы
    quest_3 = 'SELECT `PersonID`, `Name` FROM `Keywords`;'
    quest_3_0 = 'SELECT COUNT(`ID`) FROM `Keywords`;'
    quest_4 = 'SELECT `SiteID`, `Url`, `ID` FROM `Pages`' \
                'WHERE `LastScanDate` is Null;'
    quest_4_0 = 'SELECT `SiteID`, `Url`, `ID` FROM `Pages` ' \
                'WHERE ((`Url` LIKE "%/%.xml") ' \
                'OR (`Url` LIKE "%/%.xml.gz")) ' \
                'ORDER BY `LastScanDate` LIMIT 10;'
    quest_4_1 = 'INSERT INTO `Pages` (`Url`, `SiteID`) VALUES(%s, %s)'
    quest_4_2 = 'UPDATE `Pages` SET `LastScanDate` = %s WHERE `ID` = %s;'
    quest_6 = 'INSERT INTO `PersonPageRank` (`PersonID`,`PageID`, `Rank`)' \
                'VALUES(%s, %s, %s)'
    quest_6_0 = 'DELETE FROM `PersonPageRank`;'

    # Создаем для работы с Mysql
    workMysql = Mysql()
    workMysql.connect()

    # Обновляем столбец "LastScanDate" в таблице "Pages"
    def lastScanDate(PageID):
        timeStamp = datetime.strftime(datetime.now(), "%Y.%m.%d %H:%M:%S")
        workMysql.execute(quest_4_2, timeStamp, PageID)

    # Внесение данных в таблицу "Pages"
    def pages(listTemp, SiteID, PageID):
        for x in listTemp:
            workMysql.execute(quest_4_1, x, int(SiteID))

    # Внесение данных в таблицу "PersonPageRank"
    def write_page_rank(dictTemp, PageID):
        for x in dictTemp.items():
            print(x[0], x[1])
            workMysql.execute(quest_6, int(x[0]), int(PageID), int(x[1]))

    # Распределение ссылок по парсерам
    def route_parser(link):
        #global oneStart
        nonlocal dayAll
        nonlocal oneStart
        print(link)
        #  Узнаем имя файла
        namePage = link[1][link[1].rfind('/'):]
        # Узнаем расширение файла
        pageFormat = namePage[namePage.rfind('.'):]

        # Определение какое рассширение
        if pageFormat == '.xml':        # Если *.xml
            xmlUrl = Xml(link[1])
            pages(xmlUrl.sitemap(), link[0], link[2])
        elif pageFormat == '.gz':       # Если *.gz
            # Выполняем один раз
            if oneStart:
                oneStart = False
                # Выборка количество строк в таблице keywords
                newKeywords = workMysql.execute(quest_3_0)[0]
                # Были ли изменение в таблице keywords
                dayAll = read_temp_ini(fileTempCountKeyWords, newKeywords[0])
                #
                if dayAll:
                    print('Delete all string')
                    workMysql.execute(quest_6_0)
                    workMysql.commit()

            xmlGzUrl = Xml(link[1], dayAll)
            for x in xmlGzUrl.gz():
                pages(x, link[0], link[2])
        elif pageFormat == '.txt':      # Если *.txt
            parserUrlRobots = Robots(link[1])
            robotsUrl = parserUrlRobots.site_map()
            if robotsUrl:
                pages(robotsUrl, link[0], link[2])
        else:                           # Все остальное обыскиваем=)
            parserHtml = Html(link[1], dictKeywords)
            dictIdRank = parserHtml.parser()
            if dictIdRank:
                write_page_rank(dictIdRank, link[2])

        # Вносим датту сканирование
        lastScanDate(link[2])
        # Комитим изменения
        workMysql.commit()

    # Запись в файл текущей даты в формтае xxxx-xx-xx
    def rewrite_temp_ini(pathFile, tempInfo):
        with open(pathFile, 'w') as file:
            file.write(str(tempInfo))

    # Читаем временные файлы
    def read_temp_ini(fileTemp, tempInfo):
        # Если файл существует
        if os.path.isfile(fileTemp):
            with open(fileTemp, 'r') as file:
                info = file.read()
                # Если не пустой
                if info:
                    # Если не равно дате из файла
                    if info < str(tempInfo):
                        rewrite_temp_ini(fileTemp, tempInfo)
                        return 1
                else:
                    rewrite_temp_ini(fileTemp, tempInfo)
                    return 1
        else:
            rewrite_temp_ini(fileTemp, tempInfo)
            return 1
        return 0

    # Делаем список Ключ: Имена
    for x in workMysql.execute(quest_3):
        if dictKeywords.get(x[0]):
            dictKeywords[x[0]].append(x[1])
        else:
            dictKeywords[x[0]] = [x[1],]

    # Выборка новых ссылоко
    urlNullLast = workMysql.execute(quest_4)

    # Если результат пустой выполняем проход по старым ссылкам.
    if urlNullLast:
        # Перебераем ссылки у которых "lastScanDate" = "Null"
        for link in urlNullLast:
            route_parser(link)
    else:
        # Надо ли производить повторное сканирование
        toDayTrue = read_temp_ini(fileTempToDay, toDay)

        # Если сегодня не было повторного прохода по ссылкам
        if toDayTrue:
            logging('Second pass', 'Second passage links *.xml.')
            print('Second passage links')
            # Выборка старых ссылоко
            oldUrlXmllast = workMysql.execute(quest_4_0)
            if oldUrlXmllast:
                # Перебираем последних 10 старые ссылок
                for link in oldUrlXmllast:
                    route_parser(link)

    # Закрываем соединение
    workMysql.connect_close()

# Проверка
if __name__ == '__main__':
    main_find_info()