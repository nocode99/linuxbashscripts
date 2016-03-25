#NOTE: uptick not single quote

#name = variable
#backtick allows to run a command within the ticks
#for variable pass in parameter (items in backtick)
> for name in `ls`; do echo $name; done;

#read the line of each file
> for line in `cat file`; do echo $line; done;

#create a new file for each line
> for line in 'cat file'; do touch $line; done;