#The use of tee is to see the stdout of the command and to write to a file

#input ls as output
> ls

test1.txt
test2.txt

> ls | tee newfile.txt

newfile.txt
test1.txt
test2.txt
