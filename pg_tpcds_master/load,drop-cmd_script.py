import os
#cmd = '''drop table * ;'''
cmd = '''COPY * FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\data\\*.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';'''
for i in sorted(os.listdir(input('Enter Directory Containing CSVs\n'))):
    if i.endswith('csv'):
        print(repr(cmd.replace('*',i[:-4])).strip('\"'))
