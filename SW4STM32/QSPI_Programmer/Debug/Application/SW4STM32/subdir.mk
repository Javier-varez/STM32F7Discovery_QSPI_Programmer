################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/gcc/startup_stm32f746xx.s 

OBJS += \
./Application/SW4STM32/startup_stm32f746xx.o 


# Each subdirectory must supply rules for building sources it contributes
Application/SW4STM32/startup_stm32f746xx.o: /home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/gcc/startup_stm32f746xx.s
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Assembler'
	@echo $(PWD)
	arm-none-eabi-as -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/STM32746G-Discovery" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/Common" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/n25q128a" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Application/User" -g -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


