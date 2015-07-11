#!/usr/bin/python

f = open('ST_SPHDL_4096x32m8_L.cde', 'w')

def bin(num):
	b = ""
	num = int(num)
	while num > 0:
		b += str(num % 2)
		num = num / 2;
	
#	print "binary: %s" % b[::-1]
	return b[::-1]
		
for i in range(0, 2**12):
	f.write(str(bin(i)).zfill(32))
	f.write('\n')
	
f.close()
