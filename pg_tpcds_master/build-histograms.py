import psycopg2,os,shutil,time
import TABLE2ATTR as TA

#No idea why below import exists
from psycopg2 import Error

fldr = 'histograms'
if fldr in os.listdir():
    shutil.rmtree(fldr)
os.mkdir(fldr)


query = '''select {1},
       count(*)
from {0}
group by 1
order by 1 asc;
'''

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

mp=TA.T2A
init = time.clock()
count=0
for table in sorted(mp):
    print('RELATION',table)
    for attr in sorted(mp[table]):
        print('ATTRIBUTE',attr,end=' : ')
        _=time.clock()
        try:
            tmp = query.format(table,attr)
            cursor.execute(tmp)

        except (Exception, psycopg2.DatabaseError) as error :
            error_ls.append((tmp,error))
            #print ('ERROR :( \n',cmd,'\n', error)
            cursor.close()
            connection.close()
            setup()
            flg=False
        else:
            #print('SUCCESS!!\n',cmd)
            success_ls.append(tmp)
            # f1=open('\\'.join((fldr,'BUFFER'))+'.csv','w',encoding='windows-1251')
            f1=open(os.path.join(fldr,'BUFFER')+'.csv','w',encoding='windows-1251')
            f1.write('|'.join((attr,'freq','c_freq'))+'\n')
            c_freq=0
            min_val,max_val,has_null = False,False,False
            while True:
                record = cursor.fetchone()
                if record:
                    if record[0]==None:
                        has_null = True
                    else:
                        max_val = record[0]
                    if min_val==False:
                        min_val = record[0]
                    c_freq+=record[1]
                    f1.write('|'.join(map(str,(record[0],record[1],c_freq)))+'\n')
                else:
                    break
                max_freq = c_freq
            f1.close()
            
            # f1=open('\\'.join((fldr,'BUFFER'))+'.csv','r',encoding='windows-1251')
            f1=open(os.path.join(fldr,'BUFFER')+'.csv','r',encoding='windows-1251')
            f1.readline()
            # f2=open('\\'.join((fldr,(','.join(('HIST',table,attr)))))+'.csv','w',encoding='windows-1251')
            f2=open(os.path.join(fldr,(','.join(('HIST',table,attr))))+'.csv','w',encoding='windows-1251')
            f2.write('|'.join((attr,'freq','c_freq','c_selectivity'))+'\n')
            f2.write('|'.join((str(has_null).upper(),str(min_val),str(max_val)))+'\n')
            c_freq=0
            while True:
                st=f1.readline().strip('\n')
                if st:
                    st=st.split('|')
                    c_freq+=int(st[1])
                    f2.write('|'.join(map(str,(st[0] if st[0]!='None' else 'NULL',st[1],c_freq,c_freq/max_freq)))+'\n')
                else:
                    break
            f1.close()
            f2.close()
            # os.remove('\\'.join((fldr,'BUFFER'))+'.csv')
            os.remove(os.path.join(fldr,'BUFFER')+'.csv')
            flg=True
        print(count+1,'SUCCESS' if flg else 'ERROR ',time.clock()-_,time.clock()-init)
        count+=1

print('\n\nTOTAL TIME = ',time.clock()-init)

if(connection):
    cursor.close()
    connection.close()
    print("PostgreSQL connection is closed")
