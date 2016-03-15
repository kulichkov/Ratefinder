#!/usr/bin/python3
#coding=utf-8

"""
    Главный модуль, поиска и добовление ссылок.
    1. Найти новые сайты для обхода. Инициализировать начало обхода:
    Просмотреть таблицу Sites. Найти строки в таблице Sites, которым
    не соответствует НИ ОДНОЙ строки в таблице Pages.
    Для этого сайта добавить в таблицу Pages строку с URL равным
    http://<имя_сайта>/robots.txt и LastScanDate равным null.
"""

from requests_sql import Mysql
from requests_url import Url


__version__ = 'v1.0'


# Парсер файла robots.txt
class Robots_Parser():
    # Извлекаем ссылку, сайтМап
    def site_map(url):
        temp = Url.open(url)
        if temp:
            for line in temp.split('\n'):
                listLine = line.split(': ')
                if listLine[0] == 'Sitemap':
                    print(listLine[1])
                    return listLine[1]

    # Извлекае хост
    def host(url):
        pass


# Главная функция
def main():
    quest_1 = '''SELECT `ID`, `Name` FROM `Sites` WHERE `ID` not in (SELECT DISTINCT(`SiteID`) FROM `Pages`);'''
    quest_2 = '''INSERT INTO `Pages` (`Url`, `SiteID`) VALUES(%s, %s);'''

    #
    workMysql = Mysql()
    workMysql.connect()
    listSites = workMysql.execute_select(quest_1)

    # Добовляем новые ссылки на Robots.txt
    for site in listSites:
        print(site)
        urlRobotsTxt = 'http://' + site[1] + '/robots.txt'
        # Вносим данные
        workMysql.execute(quest_2, urlRobotsTxt, site[0])
    # Комитим
    workMysql.commit()

#
if __name__ == '__main__':
    main()