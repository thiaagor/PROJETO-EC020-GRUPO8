################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/USB/Class/Common/HIDParser.c 

OBJS += \
./Drivers/USB/Class/Common/HIDParser.o 

C_DEPS += \
./Drivers/USB/Class/Common/HIDParser.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/USB/Class/Common/%.o: ../Drivers/USB/Class/Common/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__LPC17XX__ -DUSB_DEVICE_ONLY -D__CODE_RED -D__REDLIB__ -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\CMSISv2p00_LPC17xx\inc" -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\CMSISv2p00_LPC17xx\lpcinc" -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\LPC17xxLib\inc" -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -std=gnu99 -mcpu=cortex-m3 -mthumb -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


