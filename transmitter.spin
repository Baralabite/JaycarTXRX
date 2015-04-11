CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

OBJ

  checksum: "checksum"

VAR

  word s
  byte counter  

PUB Main

  DIRA[2]~~
  OUTA[2]~~
  waitcnt(clkfreq*2+cnt)
            
  repeat
    counter := counter + 1
    if counter > 254
      counter := 0
    repeat 6
      transmitByte(2, checksum.generatePacket(counter<<8))

PUB transmitByte(pin, sig)

  DIRA[pin]~~
  s := sig  
  repeat 16
    OUTA[pin] := s & %0000000000000001   
    s >>= 1
    waitcnt(clkfreq/500+cnt)
  