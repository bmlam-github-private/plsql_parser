#!/bin/sh 

base_folder=lam

outfile=run-master.sql 

echo > $outfile
for script in ` find $base_folder -name "*.sql"  | grep -v "test-" | grep -v "run-" `; do 
	echo "rem source $script" >> $outfile
	cat   $script >> $outfile
	echo "\n----- end source $script ------------\n" >>$outfile 
done

echo "outfile: $outfile"
ls -l $outfile 