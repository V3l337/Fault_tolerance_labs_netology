# Задание 1 

rsync -ac --progress --delete --exclude ".*" . /tmp/backup1



# Задание 2

- vim rsyncscripts.sh

```bash
#!bin/bash

sdir="/home/v3ll"
ddir="/tmp/backup"
log="var/log/backuphome.log"

rsync -ac --progress --delete "$sdir" "$ddir" &> "$log"

if [ $? -eq 0 ]; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Backup completed successfully" >> "$log"
else
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Backup failed" >> "$log"
fi
```

- chmod +x rsyncscripts.sh
- chown root:root rsyncscripts.sh
- sudo crontab -e

```
5 0 * * * /home/v3ll/rsyncscripts.sh
```





