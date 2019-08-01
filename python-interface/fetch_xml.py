import psycopg2

try:
    connection = psycopg2.connect(user = "postgres",
                                  password = "Iwilldoit#1",
                                  host = "127.0.0.1",
                                  port = "5432",
                                  database = "TPC-DS")
    #cursor = connection.cursor(cursor_factory=RealDictCursor)
    cursor = connection.cursor()
    #Query to be executed with format & other specifiers
    query = '''explain (ANALYZE true, COSTS true, FORMAT XML) select
	l_returnflag,
	l_linestatus,
	sum(l_quantity) as sum_qty,
	sum(l_extendedprice) as sum_base_price,
	sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
	sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
	avg(l_quantity) as avg_qty,
	avg(l_extendedprice) as avg_price,
	avg(l_discount) as avg_disc,
	count(*) as count_order
    from
    	lineitem
    where
    	l_shipdate between date '1992-01-02' and date '1996-01-08' --SEL_1
    	--l_shipdate <= date '1998-12-01' - interval '82' day
    group by
    	l_returnflag,
    	l_linestatus
    order by
    	l_returnflag,
    	l_linestatus
    '''
    cursor.execute(query)
    f = open('output.xml','w')
    f.write(cursor.fetchone()[0])
    f.close()

except (Exception, psycopg2.DatabaseError) as error :
    print ("Error while connecting to PostgreSQL", error)
finally:
    #closing database connection.
    if(connection):
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")
