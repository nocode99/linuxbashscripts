#substitute string1 to string2
sed 's/string1/string2/' filename

#substitute string1 to string2 and output to output.txt
sed 's/string1/string2/w output.txt' filename

#output lines with string to text file
sed '/string1/w newoutput.txt' filename

#search for 1st occurrence of string1 and replace only that one with string2
sed '0,/string1/s/string1/string2/' filename

#remove lines between angle brackets as long as there is text
# < = starts with '<'
# [^>] = ^ as long as the character after '<' is not '>'
# *> = ends with '>'
sed 's/<[^>]*>//' file
