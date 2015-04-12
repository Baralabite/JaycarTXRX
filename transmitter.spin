CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

OBJ

  checksum: "checksum"

VAR

  word s
  byte counter  

PUB Main
            
  repeat
    transmitString(2, string("UUUUUUUUUU"))
    transmitByte(2, %01000001)  'A
    transmitByte(2, %01000010)  'B
    'transmitByte(2, %01000011)  'C
    counter++
    transmitByte(2, counter)
    transmitByte(2, (counter ^ %11111111))
    if counter > 254
      counter := 0
    OUTA[2]~

PUB transmitString(pin, stringPointer) | i, c

  i := stringPointer

  repeat
    c := byte[i]
    i++

    if c > 0
      transmitByte(pin, c)
    else
      quit

PUB transmitByte(pin, sig)

  DIRA[pin]~~
  s := sig  
  repeat 8
    OUTA[pin] := (s & %10000000) >> 7   
    s <<= 1
    waitcnt(clkfreq/1000+cnt)
  