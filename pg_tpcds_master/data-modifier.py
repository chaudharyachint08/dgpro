import os,time
for i in sorted(os.listdir()):
    if i.endswith('dat'):
        print(i,end=' : ')
        f1=open(i)
        f2=open('TEMP','w')
        _=time.clock()
        while True:
            st=f1.readline()
            if st:
                f2.write('|'.join((x if x else 'NULL') for x in st.strip('\n')[:-1].split('|'))+'\n')
            else:
                break
        f1.close()
        f2.close()
        print(time.clock()-_)
        os.remove(i)
        os.rename('TEMP',i[:-3]+'csv')
