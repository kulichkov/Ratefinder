#!/usr/bin/python3
#coding=utf-8

"""
    Пишим лог
"""

import time
from datetime import datetime
import os.path


# Логирование в файл
def logging(event, message):
    dateTime = str(datetime.utcnow())
    workingDir = os.path.split(__file__)[0]
    #print(workingDir)
    nameFileLog = '/crawler.log'
    pathLog = workingDir + nameFileLog

    # Открываем на  до запись.
    with open(pathLog, 'a') as file:
        file.write('{}: {} >> {}\n'.format(dateTime, event, message))

# Подсчет производительности компонентов
def benchmark(func):
    """
    Декоратор, выводящий время, которое заняло
    выполнение декорируемой функции.
    """
    def wrapper(*args, **kwargs):
        t = time.clock()
        res = func(*args, **kwargs)
        #print(func.__name__, time.clock() - t)
        logging('Benchmark (' + func.__name__ + ')', time.clock() - t)
        return res
    return wrapper
