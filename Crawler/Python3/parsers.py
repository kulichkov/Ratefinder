"""
    Парсенг
"""

from requests_url import Url
import xml.etree.ElementTree as etree


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


# Парсер файла sitemap.xml
class Sitemap_Parser():
    #
    def url(url):
        pass


# Парсер файл *.html
class Html_Parser():
    pass