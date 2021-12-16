import requests
from bs4 import BeautifulSoup


def link_for_insert(url):
    r = requests.get(url)
    article = dict()
    article['soup'] = BeautifulSoup(r.content, 'html.parser')
    article['title'] = article['soup'].title
    title = article['title']
    article['subscribe'] = False
    article['href'] = url
    if title:
        article['title'] = article['soup'].title.text
    else:
        article['title'] = None

    del article['soup']

    return article
