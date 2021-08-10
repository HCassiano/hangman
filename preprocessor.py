import sys

f = open("processed.txt","w").close()
f = open("processed.txt","a")
with open (sys.argv[1]) as data:
	for line in data:
		if (line.strip() != '111'):
			f.write(line)
f.close()	
