LinuxCommands.sh

#search recursively within the current directory
find . -name 'cron*'

#search for files only
find . -type f -name 'cron'

#search for directories only
find . -type d -name 'cron'

#search for files by permission
find . -perm 777

#change all files of certain permission type to another type
find . -perm 777 -exec chmod 555 {} \;

#find everything changed in 24 hours
find / -mtime +1

#find files by accessed time
find . -a +1

#find by group ownership
find . -group groupname

#find by file size (512 bytes)
find . -size 512c