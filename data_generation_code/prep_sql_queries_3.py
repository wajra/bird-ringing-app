import csv

READ_FILE='D:/FOGSL Database Project/birds_of_sl.csv'
WRITE_FILE='D:/FOGSL Database Project/Database/DATABASE_INSERTION_SCRIPTS/sql_species_inserts.sql'

#family_index variable will be used to record the current index
species_index=1
#The following dict will be used to index the family keys

species_insert_query="INSERT INTO species(species.family_index,species.common_name,species.scientific_name,species.iucn_status) VALUES((SELECT family.family_index FROM family WHERE family.family_name=\'{0}\'),\"{1}\",\'{2}\',\'{3}\');\n"

with open(WRITE_FILE,'w') as write_file:
    write_file.write('USE fogsl_ringing_database;\n')
    with open(READ_FILE,'r') as csv_file:
        csv_handler=csv.DictReader(csv_file)
        for line in csv_handler:
            write_file.write(species_insert_query.format(line['family'],line['common_name'],line['scientific_name'],line['iucn_status']))
