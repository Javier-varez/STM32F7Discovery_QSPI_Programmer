## STM32F7Discovery QSPI Programmer

---

#### What is it?

It is an utility to write the Micron N25Q128A QSPI Flash memory on the STM32F7Discovery board.

On Linux based systems there is no method to write the contents of this memory, although ST provides ST-Link Utility for Windows operating systems. 

Using this app there is no need to switch to a windows machine or virtualize it.


#### This package contains:

  * The STM32F7 firmware required to program the QSPI memory through the incorporated UART interface on the ST-Link programmer
  * A python script ("programmer.py") that can be integrated with Eclipse to program the QSPI memory.

#### Installation

  * Install dependencies (see section dependencies).
  * Copy the ELF file containing the STM32F7 firmware to program the QSPI and the Python script to a location included in the PATH variable.

  * Set up constant definitions on the python script "programmer.py".
  
  ⋅⋅* Serial device to be used (doesn't need configuration if stlink driver is installed).
  ⋅⋅* Openocd location and configuration scripts to be used.
  ⋅⋅* Memory section associated to the QSPI Memory, as defined by the Linker script.
  ⋅⋅* Cross Compiler to be used. (this will call objcopy).
  ⋅⋅* QSPI_Programmer installation path.

#### Usage

qspi_programmer.py [-h] [-d] [-i <inputfile>] [-o <outputfile>] [--qspi-section <section>]

  * -h: Shows usage information.
  * -d: Dumps QSPI memory contents to file indicated by -o <outputfile>.
  * -i <inputfile>: ELF file containing QSPI memory section.
  * --qpsi-section: Memory section in which the QSPI memory is mapped (as defined by the linker scriot).

#### Dependencies
  * Openocd (Needs to be on your PATH).
  * ST Link 2.1 driver.
  * ARM GCC Toolchain (needs to be on your PATH variable).
  * Python.

