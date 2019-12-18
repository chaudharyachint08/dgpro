import os

import psycopg2
#No idea why below import exists
from psycopg2 import Error

connection,cursor=None,None
def setup():
    global connection,cursor
    try:
        connection = psycopg2.connect(user = "malhar",
                                          password = "database",
                                          host = "127.0.0.1",
                                          port = "5432",
                                          database = "TPC-DS")
        cursor = connection.cursor()
    except (Exception, psycopg2.DatabaseError) as error :
        print(error)

setup()



#cmd = '''drop table * ;'''
success_ls = []
error_ls = []

csv_dir = '/home/malhar/CSVs/tpcds1'
cmd = '''COPY * FROM '{}/*.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';'''.format(csv_dir)
for i in sorted(os.listdir(csv_dir)):
    if i.endswith('csv'):
        # tmp = repr(cmd.replace('*',i[:-4])).strip('\"')
        tmp = cmd.replace('*',i[:-4])
        print(tmp)
        # try:
        #     cursor.execute(tmp)
        #     # pass
        # except (Exception, psycopg2.DatabaseError) as error :
        #     error_ls.append((tmp,error))
        #     print ('ERROR :( \n',tmp,'\n', error)
        #     cursor.close()
        #     connection.close()
        #     setup()
        # else:
        #     print('SUCCESS!!\n',tmp)
        #     success_ls.append(tmp)

if(connection):
    cursor.close()
    connection.close()
    print("PostgreSQL connection is closed")