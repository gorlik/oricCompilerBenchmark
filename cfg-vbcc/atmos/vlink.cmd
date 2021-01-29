HIMEM = 0x9800;
STACKSTART = 0x8000;
OSHWM = 0x0600;

MEMORY
{
 zero : org = 0 , len = 0x90
 ram : org = OSHWM, len = (STACKSTART-OSHWM)
}

SECTIONS
{
  text : {*(text)} >ram
  .dtors : { *(.dtors) } > ram
  .ctors : { *(.ctors) } > ram
  rodata : {*(rodata)} >ram
  data: {*(data)} >ram
  init : {*(init)} >ram
  zpage (NOLOAD) : {*(zpage) *(zp1) *(zp2)} >zero
  bss (NOLOAD): {*(bss)} >ram

  __BB = ADDR(bss);
  __BE = ADDR(bss)+SIZEOF(bss);
  ___heap = ADDR(bss)+SIZEOF(bss);
  ___heapend = STACKSTART-1;
}
