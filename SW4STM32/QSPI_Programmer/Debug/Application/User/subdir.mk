################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Application/User/Circ_Buff.c \
/home/javier/workspace/QSPI_Programmer/Src/gpio.c \
/home/javier/workspace/QSPI_Programmer/Src/main.c \
/home/javier/workspace/QSPI_Programmer/Src/stm32f7xx_hal_msp.c \
/home/javier/workspace/QSPI_Programmer/Src/stm32f7xx_it.c \
/home/javier/workspace/QSPI_Programmer/Src/usart.c 

OBJS += \
./Application/User/Circ_Buff.o \
./Application/User/gpio.o \
./Application/User/main.o \
./Application/User/stm32f7xx_hal_msp.o \
./Application/User/stm32f7xx_it.o \
./Application/User/usart.o 

C_DEPS += \
./Application/User/Circ_Buff.d \
./Application/User/gpio.d \
./Application/User/main.d \
./Application/User/stm32f7xx_hal_msp.d \
./Application/User/stm32f7xx_it.d \
./Application/User/usart.d 


# Each subdirectory must supply rules for building sources it contributes
Application/User/%.o: ../Application/User/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F746xx -I"/home/javier/workspace/QSPI_Programmer/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc/Legacy" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Include" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Include" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/STM32746G-Discovery" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/Common" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/n25q128a" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Application/User"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/gpio.o: /home/javier/workspace/QSPI_Programmer/Src/gpio.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F746xx -I"/home/javier/workspace/QSPI_Programmer/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc/Legacy" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Include" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Include" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/STM32746G-Discovery" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/Common" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/n25q128a" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Application/User"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/main.o: /home/javier/workspace/QSPI_Programmer/Src/main.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F746xx -I"/home/javier/workspace/QSPI_Programmer/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc/Legacy" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Include" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Include" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/STM32746G-Discovery" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/Common" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/n25q128a" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Application/User"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/stm32f7xx_hal_msp.o: /home/javier/workspace/QSPI_Programmer/Src/stm32f7xx_hal_msp.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F746xx -I"/home/javier/workspace/QSPI_Programmer/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc/Legacy" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Include" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Include" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/STM32746G-Discovery" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/Common" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/n25q128a" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Application/User"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/stm32f7xx_it.o: /home/javier/workspace/QSPI_Programmer/Src/stm32f7xx_it.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F746xx -I"/home/javier/workspace/QSPI_Programmer/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc/Legacy" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Include" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Include" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/STM32746G-Discovery" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/Common" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/n25q128a" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Application/User"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Application/User/usart.o: /home/javier/workspace/QSPI_Programmer/Src/usart.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))" -DUSE_HAL_DRIVER -DSTM32F746xx -I"/home/javier/workspace/QSPI_Programmer/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc" -I"/home/javier/workspace/QSPI_Programmer/Drivers/STM32F7xx_HAL_Driver/Inc/Legacy" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Include" -I"/home/javier/workspace/QSPI_Programmer/Drivers/CMSIS/Device/ST/STM32F7xx/Include" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/STM32746G-Discovery" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/Common" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Drivers/BSP/Components/n25q128a" -I"/home/javier/workspace/QSPI_Programmer/SW4STM32/QSPI_Programmer/Application/User"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


