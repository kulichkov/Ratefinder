#!/usr/bin/python3
#coding=utf-8

"""
    Пишим лог
"""

import time
import os.path


def log(func):
    def wrapper(*args, **kwargs):
        workingDir = os.path.split(__file__)[0]
        print(workingDir)
        nameFileLog = 'crawler.log'
        pathLog = workingDir + nameFileLog

        #
        with open(pathLog, 'a') as file:
            #file.write('testttttttt')
            print(func.__name__, args, kwargs)
            pass

    return wrapper

def benchmark(func):
    """
    Декоратор, выводящий время, которое заняло
    выполнение декорируемой функции.
    """

    def wrapper(*args, **kwargs):
        t = time.clock()
        res = func(*args, **kwargs)
        print(func.__name__, time.clock() - t)
        return res
    return wrapper