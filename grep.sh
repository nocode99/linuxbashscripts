main.sh

#line starts with 
grep ^string filename

#line ends with
grep string$ filename

#multiple letters
grep [axy] filename

#range of numbers
grep [1-9] filename

#range of letters
grep [a-h] filename

#search for expression that contains 'hello' OR 'world' but not 'jeff'
egrep 'hello|world' filename | grep -v jeff

#search for literal expression
#will literally search for 'hello$'
fgrep hello$ filename