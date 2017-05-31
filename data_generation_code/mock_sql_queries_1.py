#This code will generate a .sql file that will insert the relevant observer to the database
#The users and the observers that enter the data will belong to one of those institutions
import csv

READ_FILE='D:/FOGSL Database Project/CSV_FILES/institutions.csv'
WRITE_FILE='D:/FOGSL Database Project/Database/MOCK_SQL_SCRIPTS/sql_institutions_insertion.sql'

institution_insert_query="INSERT INTO institution(institution.institution_name) VALUES (\'{0}\');\n"

with open(WRITE_FILE,'w') as write_file:
    write_file.write('USE fogsl_ringing_database;\n')
    with open(READ_FILE,'r') as csv_file:
        csv_handler=csv.DictReader(csv_file)
        for line in csv_handler:
            write_file.write(institution_insert_query.format(line['institution_name']))
