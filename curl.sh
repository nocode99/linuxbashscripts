#search silently and search for expression "301 moved"
> curl -s google.com | egrep -ci "301 moved"

output: 2

#Silent curl. This will let us know if the file was moved and disregard the count 
#if we remove '> /dev/null' it will output the count and the text
> curl -s google.com | egrep -ci "301 moved" > /dev/null && echo "file has moved" || echo "false"
output: file has moved
