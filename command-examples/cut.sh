#parse username out of /etc/passwd
# -f1 is the first field, -d: delimiter by :. 
#text will grab before the first delimiter
cut -f1 -d: /etc/passwd

#grab text before 2nd delimiter
cut -f2 -d: /etc/passwd