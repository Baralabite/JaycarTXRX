CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

OBJ

  serial: "FullDuplexSerial"
  checksum: "checksum"

VAR

  long genChecksum

PUB Main | data, matches

  waitcnt(clkfreq*2+cnt) 'Gives time for me to open serial terminal
  Serial.start(31, 30, 0, 115200)
  Serial.str(String(16, "Checksum Test", 13))
  Serial.str(String("==========================", 13, 13))
  

  data := String("Hello World!")                        'Defines data to send                       
  genChecksum := checksum.createChecksum(@data)          'Creates checksum from data

  Serial.str(String("Checksum: "))
  Serial.dec(genChecksum)
  Serial.tx(13)

  Serial.str(String("Checksum: "))
  Serial.dec(checksum.createChecksum(String("Hello World!")))
  Serial.tx(13)

  matches := checksum.checkChecksum(data, genChecksum)  'Checks to see whether checksum matches data

  if matches
    Serial.str(String("Checksum matches!"))
  else
    Serial.str(String("Checksum does not match!"))      

  