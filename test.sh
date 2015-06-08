#if file exists
test -f file1

#add && to perform action if true
test -f file1 && echo "true"

#test 1 is greater than 2
test 1 -gt 2 && echo "true"

test 1 -gt 2 && echo "true" || echo "false"

[ 5 -eq 5 ]; echo $?
output = 0 if true
output = 1 if false

