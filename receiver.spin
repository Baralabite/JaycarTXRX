CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

  Serial_Enabled = TRUE

OBJ

  Serial: "FullDuplexSerial"

VAR

  long buf

  byte data
  byte checksum

  byte found
  byte oldDec

  word foundCount
  long stack[20]

PUB Main | in, cog, i

  waitcnt(clkfreq*3+cnt)
  
  if Serial_Enabled
    Serial.start(31, 30, 0, 115200)
    cog := cognew(output, @stack[0])
    
  DIRA[3]~
  DIRA[10]~~
  
  repeat
    in := INA[3]
    buf <<= 1
    buf |= in

    OUTA[10] := in
    
    if (buf & %11111111_11111111_00000000_00000000) == %01000001_01000010_00000000_00000000
      data := (buf & %11111111_00000000) >> 8
      checksum := (buf & %00000000_11111111)      
      if (data ^ %11111111) == checksum
        found := True       
        foundCount++   

    waitcnt(clkfreq/1000+cnt)

PUB output | b1, b2, b3

  repeat
    Serial.tx(16)
 
    Serial.Str(String("Buffer: "))
    Serial.bin(buf, 32)
    Serial.tx(13)

    Serial.str(String("Data: "))
    Serial.bin(data, 8)
    Serial.tx(13)

    Serial.str(String("Dec: "))
    if found      
      Serial.Dec(data)
      oldDec := data      
      found := FALSE
    else
      Serial.dec(oldDec)
    Serial.tx(13)

    Serial.str(String("Checksum: "))
    Serial.bin(checksum, 8)
    Serial.tx(13)    
    
    Serial.str(String("Found Count: "))
    Serial.dec(foundCount)
    Serial.tx(13)
    waitcnt(clkfreq/50+cnt)
    