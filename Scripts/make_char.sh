#! /bin/bash

cd characters
test -f ./char_${1}.m4  ||  exit -1

m4 -I../rules -Dchar_filename=${1} < ./char_${1}.m4 1> ./char_${1}.tex 2> ./char_${1}.errlog  ||  exit 1
latex ./char_${1}.tex
latex ./char_${1}.tex
dvips -t a4 -o ./char_${1}.ps ./char_${1}.dvi
gzip --best -f ./char_${1}.ps
gv ./char_${1}.ps.gz
