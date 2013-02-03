#! /bin/bash

FILE="./backups/backup_dnd_m4_sheet_$(date +'%Y%m%d_%H%M').tgz"

tar czf $FILE ./characters/char_*.{m4,inc,anm} ./rules/*.m4 ./make_*.sh ./roll_*.rb
chmod 0400 $FILE
