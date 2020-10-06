import struct

# 0 is /48
key = 'df7d09655894333fe'

with open('serial_key', 'wb') as f:
    f.write("0\n" + key + "\n5")
