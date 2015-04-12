CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

OBJ

  Serial: "FullDuplexSerial"
  checksum: "checksum"

VAR

 word buf
 long counter

 word start

 word a, b, c, d, e, f, g, h

 word packet

PUB Main | in

  Serial.start(31, 30, 0, 115200)
  Serial.str(String("Starting receiving...", 13))  
  waitcnt(clkfreq*3+cnt)
  Serial.tx(16)
  DIRA[3]~

  start := %1010101100000000
  Serial.str(String("Start : "))
  Serial.bin(start, 16)                                                   
  Serial.str(String(13, "Chcksm: "))
  Serial.bin(checksum.calculateChecksum(start), 16)
  Serial.str(String(13, "Packet: "))
  Serial.bin(checksum.generatePacket(start), 16)     

  {Serial.str(String(13, "First: "))
  a := ((start & %1111000000000000) >> 12)+1
  Serial.bin(a, 16)

  Serial.str(String(13, "Second: "))
  b := ((start & %0000111100000000) >> 8)+1
  Serial.bin(b, 16)

  Serial.str(String(13, "Mod: "))
  c := (a * b)//256  
  Serial.bin(c, 16)  

  Serial.str(String(13, "Gen: "))
  d := (start | c)   
  Serial.bin(d, 16)}

  packet := %1100001100110100'checksum.generatePacket(start)
  
  Serial.str(String(13, "Stp   : "))
  e := packet
  e >>= 8
  e <<= 8  
  Serial.bin(e, 16)

  Serial.str(String(13, "Chk   : "))
  f := checksum.generatePacket(e)
  Serial.bin(f, 16)

  Serial.str(String(13, "Match : "))
  if f == packet
    Serial.str(String("True", 13))
  else
    Serial.str(String("False", 13))

  g := checksum.checkChecksum(packet)  
  Serial.str(String("Match : "))
  if f == packet
    Serial.str(String("True", 13))
  else
    Serial.str(String("False", 13))  

  'Serial.str(String(13, "Gen: "))
  'f :=   
  'Serial.bin(e, 16)

PUB genCheck(input)
  a := ((input & %1111000000000000) >> 12)+1
  b := ((input & %0000111100000000) >> 8)+1
  c := (a * b)//256
  return c