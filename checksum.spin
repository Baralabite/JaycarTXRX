PUB createChecksum(stringPointer) | p, c, checksum
  {
   Creates a checksum by xor'ing all the characters
   together.

   p is the incrementing checksum pointer.
   c is the character from RAM
  }

  p := stringPointer

  repeat
    c := byte[p]
    p++
    if c > 0
      checksum := checksum ^ c
    else
      return checksum

PUB checkChecksum(data, checksum) | d
  {
  Returns boolean whether the transmitted checksum
  matches the data.

  Creates a checksum using the checksumming algorithm
  from the data parameter, and stores it in the "d"
  variable. Then compares "d" with the provided checksum
  parameter.
  }

  d := createChecksum(data)
  if d == checksum
    return True
  else
    return False
  