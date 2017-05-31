import csv

READ_FILE='D:/FOGSL Database Project/birds_of_sl.csv'
WRITE_FILE='D:/FOGSL Database Project/Database/DATABASE_INSERTION_SCRIPTS/sql_family_inserts.sql'

#family_index variable will be used to record the current index
family_index=1
#The following dict will be used to index the family keys
family_dict=dict()

#family_insert_query="INSERT INTO family(family.family_index,family.order_index,family.family_name,family.family_desc)" \
#                    " VALUES({0},(SELECT bird_orders.order_index FROM bird_orders " \
#                    "WHERE bird_orders.order_name=\'{1}\'),\'{2}\',\'{3}\');\n"
family_insert_query="INSERT INTO family(family.order_index,family.family_name,family.family_desc)" \
                    " VALUES((SELECT bird_orders.order_index FROM bird_orders " \
                    "WHERE bird_orders.order_name=\'{0}\'),\'{1}\',\'{2}\');\n"

with open(WRITE_FILE,'w') as write_file:
    write_file.write('USE fogsl_ringing_database;\n')
    with open(READ_FILE,'r') as csv_file:
        csv_handler=csv.DictReader(csv_file)
        for line in csv_handler:
            if line['family'] in family_dict.keys():
                pass
            else:
                family_dict[line['family']]=family_index
                #write_file.write(family_insert_query.format(family_index,line['order'].title(),line['family'],line['family_described']))
                write_file.write(family_insert_query.format(line['order'].title(), line['family'],
                                                            line['family_described']))
                family_index += 1
