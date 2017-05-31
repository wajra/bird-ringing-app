#This code will generate a .sql file that will insert the different ringing session conducted throughout the programs history
import csv

READ_FILE='D:/FOGSL Database Project/CSV_FILES/sessions.csv'
WRITE_FILE='D:/FOGSL Database Project/Database/MOCK_SQL_SCRIPTS/sql_sessions_insert.sql'

#The query that will continually inserted
session_insert_query="INSERT INTO ringing_session(session_name,start_date,end_date) VALUES (\'{0}\',\'{1}\',\'{2}\');\n"

with open(WRITE_FILE,'w') as write_file:
    write_file.write('USE fogsl_ringing_database;\n')
    with open(READ_FILE, 'r') as csv_file:
        csv_handler=csv.DictReader(csv_file)
        for line in csv_handler:
            write_file.write(session_insert_query.format(line['session_name'], line['start_date'], line['end_date']))

print ('All the tasks have been completed.')
