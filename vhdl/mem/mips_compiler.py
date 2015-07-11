#!/usr/bin/python

import sys


class Compiler:
	
	def __init__(self):
		self.ins = { \
		'addu' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x21, 6)), \
		'addiu' : (self.code(0x9, 6), None, None), \
		'subu' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x23, 6)), \
		'multu' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x19, 6)), \
		'and' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x24, 6)), \
		'or' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x25, 6)), \
		'xor' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x26, 6)), \
		'sll' : (self.code(0x00, 6), None, self.code(0x00, 6)), \
		'srl' : (self.code(0x00, 6), None, self.code(0x02, 6)), \
		'sra' : (self.code(0x00, 6), None, self.code(0x03, 6)), \
		'slt' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x2A, 6)), \
		'sltu' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x2B, 6)), \
		'mfhi' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x10, 6)), \
		'mflo' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x12, 6)), \
		'lui' : (self.code(0x0F, 6), None, None), \
		'lw' : (self.code(0x23, 6), None, None), \
		'sw' : (self.code(0x2B, 6), None, None), \
		'j' : (self.code(0x02, 6), None, None), \
		'jal' : (self.code(0x03, 6), None, None), \
		'jr' : (self.code(0x00, 6), self.code(0x00, 5), self.code(0x08, 6)), \
		'beq' : (self.code(0x04, 6), None, None), \
		'bne' : (self.code(0x05, 6), None, None)}


	def bin2(self, num):
		b = ""
		num = int(num)
		while num > 0:
			b += str(num % 2)
			num = num / 2;
	
		return b[::-1]

	def bin(self, num):
		num = str(num)
		if num[0] == '-':
			num = int(num[1:])
			num = 2**32 - num # 2's complement
		
		return self.bin2(num)

	def code(self, num, size):
		return self.bin(num).zfill(size)#.split('b')[1]

	def compile(self, sourcefile):
		f = open(sourcefile, 'r')
		g = open('program.cde', 'w')

		line_num = 1
		for line in f.read().splitlines():
			self.instr = line.split(' ')
			op = self.instr[0]

			print op

			if (op[0] == '#' or self.instr == ''): # ignore comments
				continue

			asm = ""
			if op == 'nop':
				asm = str(0).zfill(32)
			elif op == 'addu':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'addiu':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 16)
			elif op == 'subu':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'multu':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(0x00, 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'and':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'or':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'xor':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'sll':
				asm += self.ins[op][0] + self.code(0x00, 5) + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][2]
			elif op == 'srl':
				asm += self.ins[op][0] + self.code(0x00, 5) + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][2]
			elif op == 'sra':
				asm += self.ins[op][0] + self.code(0x00, 5) + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][2]
			elif op == 'slt':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'sltu':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'mfhi':
				asm += self.ins[op][0] + self.code(0x00, 5) + self.code(0x00, 5) + self.code(self.instr[1], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'mflo':
				asm += self.ins[op][0] + self.code(0x00, 5) + self.code(0x00, 5) + self.code(self.instr[1], 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'lui':
				asm += self.ins[op][0] + self.code(0x00, 5) + self.code(self.instr[1], 5) + self.code(self.instr[2], 16)
			elif op == 'lw':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 16)
			elif op == 'sw':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 16)
			elif op == 'j':
				asm += self.ins[op][0] + self.code(self.instr[1], 26)
			elif op == 'jal':
				asm += self.ins[op][0] + self.code(self.instr[1], 26)
			elif op == 'jr':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(0x00, 5) + self.code(0x00, 5) + self.ins[op][1] + self.ins[op][2]
			elif op == 'beq':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 16)#[16:]
			elif op == 'bne':
				asm += self.ins[op][0] + self.code(self.instr[1], 5) + self.code(self.instr[2], 5) + self.code(self.instr[3], 16)
			else:
				print "Unknown op-self.code on line %s" % line_num
				sys.exit(1)

			g.write(asm + '\n')
			line_num += 1

		f.close()

		for i in range(line_num, 4096 + 1):
			g.write(str(0).zfill(32) + '\n')
		
		g.close()


if __name__ == '__main__':
	if len(sys.argv) != 2:
		print 'Usage: %s <sourcefile>' % sys.argv[0]
		sys.exit(1)
	
	Compiler().compile(sys.argv[1])
