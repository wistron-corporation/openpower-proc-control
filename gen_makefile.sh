#!/bin/bash

files=()
dir=$1
args=("$@")

echo "openpower_procedures_cpp_files = \\"
for ((i=1; i<${#args[@]}; ++i));
do
    type=${args[$i]}
    type=${type// /} #remove spaces
    for file in $(ls $dir/procedures/$type/*.cpp);
    do
        files+=($file)
    done
done

for file in ${files[@]};
do
    echo "	$file \\"
done
echo

cat << MAKEFILE
openpower_procedures.cpp: \$(openpower_procedures_cpp_files)
	cat \$^ > \$@

MAKEFILE
