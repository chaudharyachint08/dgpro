import psycopg2
#No idea why below import exists
from psycopg2 import Error

f=open('tpcds-create.sql')
mp={}
var=None
while True:
    st=f.readline();
    if st:
        if st.startswith('--'):
            pass
        elif st.startswith('create table '):
            var=st[len('create table '):].strip()
            mp[var]=[]
        elif not (st.startswith('(') or st.startswith(')')):
            try:
                tmp = st.strip().split()[0]
                if tmp!='primary':
                    mp[var].append(tmp)
            except:
                pass
    else:
        break
f.close()

cmd = 'CREATE INDEX {0} ON {1} ({2});'
success_ls = []
error_ls = []
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

for table in sorted(mp):
    for attr in sorted(mp[table]):
        try:
            tmp = cmd.format('_'.join(['INDX',table,attr]),table,attr)
            cursor.execute(tmp)

        except (Exception, psycopg2.DatabaseError) as error :
            error_ls.append((tmp,error))
            print ('ERROR :( \n',tmp,'\n', error)
            cursor.close()
            connection.close()
            setup()
        else:
            print('SUCCESS!!\n',tmp)
            success_ls.append(tmp)

if(connection):
    cursor.close()
    connection.close()
    print("PostgreSQL connection is closed")
