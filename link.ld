OUTPUT_FORMAT("elf32-i386")
ENTRY(start)
SECTIONS
{
  /* Kernel soll ab Adresse 0x1000 geladen werden */
  . = 0x1000;
  .text : {
    *(.text*)
  }
  .data : {
    *(.data*)
  }
  .bss : {
    *(.bss*)
  }
}
