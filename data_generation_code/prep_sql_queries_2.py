import csv

READ_FILE='D:/FOGSL Database Project/birds_of_sl.csv'
WRITE_FILE='D:/FOGSL Database Project/Database/DATABASE_INSERTION_SCRIPTS/sql_order_inserts.sql'

#family_index variable will be used to record the current index
order_index=1
#The following dict will be used to index the family keys
order_dict=dict()

#order_insert_query='INSERT INTO bird_orders(order_index,order_name) VALUES ({0},\'{1}\');\n'
order_insert_query='INSERT INTO bird_orders(order_name) VALUES (\'{0}\');\n'

with open(WRITE_FILE,'w') as write_file:
    write_file.write('USE fogsl_ringing_database;\n')
    with open(READ_FILE,'r') as csv_file:
        csv_handler=csv.DictReader(csv_file)
        for line in csv_handler:
            if line['order'].title() in order_dict.keys():
                pass
            else:
                order_name=line['order'].title()
                order_dict[order_name]=order_index
                #Write to .sql file
                #write_file.write(order_insert_query.format(order_index,order_name))
                write_file.write(order_insert_query.format(order_name))
                order_index += 1

for key in sorted(order_dict.keys()):
    print (key)

print ('The total number of families of birds in Sri Lanka: {0}'.format(len(list(order_dict.keys()))))
