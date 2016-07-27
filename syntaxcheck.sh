#!/bin/bash

echo "this is a file used to check the syntax of perl"

files=`find . -type f | grep -v git | grep -v xCAT-rmc`

for file in $files;
do
        shebang=`awk 'NR==1' $file | grep -E '#!.*perl'`
        if [ -n "$shebang" ]; then
                ret=`perl -I ./perl-xCAT -I ./xCAT-server/lib/perl -I ./xCAT-OpenStack/lib/perl -I ./xCAT-vlan -I ./xCAT-server/lib/xcat -c $file 2>&1`
                if [[ "$ret" =~ "syntax OK" ]]; then
                        echo "Syntax check passed: $file"
		else
			echo "Failed to check the perl syntax for file: $file"
                        exit 1
                fi      
#		perltidy -w -syn -g -opt -i=4 -nt -io -nbbc -kbl=2 -pscf=-c -aws -pt=2 -bbc -nolc $file
#		diff=`diff $file $file".tdy"`
#		if [ -n "$diff" ]; then
#			echo "Failed to check the Tidy for file: $file"
#			exit 1
#		fi
        fi      
done
exit 0

