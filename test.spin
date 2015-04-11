CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

OBJ

  Serial: "FullDuplexSerial"

VAR

  long checksum
  long str

PUB Main

  waitcnt(clkfreq*2+cnt)
  Serial.start(31, 30, 0, 115200)
  Serial.tx(16)

  str := String("Hello")
  Serial.tx(createChecksum(str))

PUB createChecksum(checksumPointer) | p, c

  p := checksumPointer

  repeat
    c := byte[p]
    p++
    if c > 0
      checksum := checksum ^ c
    else
      return checksum    
    
