import sqlite3
from bottle import route, run, debug, template, request
import requests
import json
from bs4 import BeautifulSoup
from prepare_of_link import link_for_insert

conn = sqlite3.connect('lab1.db')
cursor = conn.cursor()


@route('/select')
def select():
    cursor.execute("SELECT * FROM tab")
    result = cursor.fetchall()
    output = template('select_all', result=result)
    print(result)

    return output


@route('/insert', method='GET')
def insert():
    if request.GET.save:
        link = link_for_insert(request.GET.link.strip())
        title = link['title']
        subscribe = link['subscribe']
        href = link['href']
        cursor.execute("INSERT INTO tab VALUES(?,?,?)",
                       (title, subscribe, href))
        cursor.execute("SELECT * FROM tab")
        result = cursor.fetchall()
        conn.commit()

        return template('select_all', result=result)
    else:
        # return template('insert_data.tpl')
        result = cursor.fetchall()
        cursor.execute("SELECT * FROM tab")
        return template('select_all', result=result)


# @route('/edit', method="GET")
# def edit_item():
#     if request.GET.save:
#         title = request.GET.title.strip()
#         cursor.execute(
#             "UPDATE tab SET title = ? WHERE href LIKE ?", (title, href))
#         conn.commit()
#         result = cursor.fetchall()
#         cursor.execute("SELECT * FROM tab")

#         return template('select_all', result=result)
#     else:
#         cursor.execute("SELECT title FROM tab WHERE href like ?", (str(href)))
#         cur_data = cursor.fetchone()

#         return template('edit_task', old=cur_data, href=href)

run(host='localhost', port=8080, debug=True)
