#!/usr/bin/python3
#coding=utf-8

__author__ = 'user'

from configparser import ConfigParser
from os.path import split

# Полный путь до файла конфигураций
fullPath = split(__file__)[0] + '/configdb.ini'

# Считываем информащию из конфигурационного файла
def confgini (filename=fullPath, section='mysql'):
    # Создаем объект
    parser = ConfigParser()
    parser.read(filename)

    db = {}
    if parser.has_section(section):
        items = parser.items(section)
        for item in items:
            db[item[0]] = item[1]
    else:
        raise Exception('{0} not found in the {1} file'.format(section, filename))

    return db

