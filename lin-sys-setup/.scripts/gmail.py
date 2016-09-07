import os
import string

#Enter your username and password below within double quotes
# eg. username="username" and password="password"
username="mcmhav"
password="----"

com="wget -O - https://"+username+":"+password+"@mail.google.com/mail/feed/atom --no-check-certificate"

temp=os.popen(com)
msg=temp.read()
index=string.find(msg,"<fullcount>")
index2=string.find(msg,"</fullcount>")
fc=int(msg[index+11:index2])

if fc==1:
   print "1"
elif fc>=2:
   print str(fc)
else:
   print "no"
