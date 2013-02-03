#! /bin/bash

FILE="./exports/export_dnd_m4_sheet_$(date +'%Y%m%d_%H%M').tgz"

tar czf $FILE ./rules/*.m4 ./make_*.sh ./roll_*.rb
chmod 0400 $FILE
