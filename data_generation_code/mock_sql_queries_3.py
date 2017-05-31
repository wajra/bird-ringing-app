#This code will generate a .sql file that will insert the ringing locations
#It will contain the general locations such as Bundala and Wilpaththu
import csv

READ_FILE='D:/FOGSL Database Project/CSV_FILES/locations.csv'
WRITE_FILE='D:/FOGSL Database Project/Database/MOCK_SQL_SCRIPTS/sql_locations_insert.sql'

#The query that will continually inserted
location_insert_query="INSERT INTO location(location_name,district) VALUES (\'{0}\',\'{1}\');\n"

with open(WRITE_FILE,'w') as write_file:
    write_file.write('USE fogsl_ringing_database;\n')
    with open(READ_FILE, 'r') as csv_file:
        csv_handler=csv.DictReader(csv_file)
        for line in csv_handler:
            write_file.write(location_insert_query.format(line['location'], line['district']))
