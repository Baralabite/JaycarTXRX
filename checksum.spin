VAR

  word a, b, c, d

PUB calculateChecksum(input) | b1, b2, chk
'input = 4 data bits, 4 other bits (not fussy)

  a := ((input & %1111000000000000) >> 12)+1
  b := ((input & %0000111100000000) >> 8)+1
  c := (a * b)//256
  return c

PUB calculateChecksum_(input) | b1, b2, chk
'input = 4 data bits, 4 other bits (not fussy)

  d := input
  d <<= 8  
  a := ((input & %1111000000000000) >> 12)+1
  b := ((input & %0000111100000000) >> 8)+1
  c := (a * b)//256
  return c  

PUB generatePacket(input)
'input = 4 data bits, 4x 0s: %11010000

  return input | calculateChecksum(input)        

PUB checkChecksum(input) | i
'input = Full binary packet (4bits + 4bit checksum)

  i := input >> 8
  i <<= 8
  return generatePacket(i) == input
