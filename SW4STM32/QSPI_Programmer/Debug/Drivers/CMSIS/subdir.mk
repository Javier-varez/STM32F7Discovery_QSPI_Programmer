################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/system_stm32f7xx.c 

OBJS += \
./Drivers/CMSIS/system_stm32f7xx.o 

C_DEPS += \
./Drivers/CMSIS/system_stm32f7xx.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/CMSIS/system_stm32f7xx.o: /home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/system_stm32f7xx.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F746xx -I"/home/javier/workspace/QSPI_Programmer/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc/Legacy" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Include" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Include" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/STM32746G-Discovery" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/Common" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/n25q128a" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Application/User"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


