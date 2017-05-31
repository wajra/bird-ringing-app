#This code will generate a .sql file that will insert the habitats in which birds are caught
import csv

READ_FILE='D:/FOGSL Database Project/CSV_FILES/habitats.csv'
WRITE_FILE='D:/FOGSL Database Project/Database/MOCK_SQL_SCRIPTS/sql_habitats_insert.sql'

#The query that will continually inserted
#location_insert_query="INSERT INTO location(location_name,district) VALUES (\'{0}\',\'{1}\');\n"
habitat_insert_query="INSERT INTO habitat(habitat_name) VALUES (\'{0}\');\n"

with open(WRITE_FILE,'w') as write_file:
    write_file.write('USE fogsl_ringing_database;\n')
    with open(READ_FILE, 'r') as csv_file:
        csv_handler=csv.DictReader(csv_file)
        for line in csv_handler:
            write_file.write(habitat_insert_query.format(line['habitat_name']))
