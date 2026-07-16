#!/bin/sh 
# create a SQL script from the object scripts so that it can be run 
# on another database/schema to create the database objects or bring
# them up-to-date, supposing that objects which are created without 
# the REPLACE option is amended incrementally
# E.g 
# version 1 CREATE TABLE emp ( emp_no, ename , job )
# version 2 ALTER TABLE emp ADD commission ... 

base_folder=lam

outfile=run-master.sql 

echo > $outfile
for script in ` find $base_folder -name "*.sql"  | grep -v "test-" | grep -v "run-" | grep -vE -- "-v[0-9]+" | grep -v generated_code `; do 
	echo "rem source $script" >> $outfile
	cat   $script >> $outfile
	echo "\n----- end source $script ------------\n" >>$outfile 
done

echo "\nEXEC dbms_utility.compile_schema( 'LAM', false)\n" >>$outfile 


echo "outfile: $outfile"
ls -l $outfile 