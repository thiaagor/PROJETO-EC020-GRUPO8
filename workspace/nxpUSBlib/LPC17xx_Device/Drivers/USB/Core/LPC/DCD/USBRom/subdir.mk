################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/USB/Core/LPC/DCD/USBRom/usbd_cdc.c \
../Drivers/USB/Core/LPC/DCD/USBRom/usbd_hid.c \
../Drivers/USB/Core/LPC/DCD/USBRom/usbd_msc.c \
../Drivers/USB/Core/LPC/DCD/USBRom/usbd_rom.c 

OBJS += \
./Drivers/USB/Core/LPC/DCD/USBRom/usbd_cdc.o \
./Drivers/USB/Core/LPC/DCD/USBRom/usbd_hid.o \
./Drivers/USB/Core/LPC/DCD/USBRom/usbd_msc.o \
./Drivers/USB/Core/LPC/DCD/USBRom/usbd_rom.o 

C_DEPS += \
./Drivers/USB/Core/LPC/DCD/USBRom/usbd_cdc.d \
./Drivers/USB/Core/LPC/DCD/USBRom/usbd_hid.d \
./Drivers/USB/Core/LPC/DCD/USBRom/usbd_msc.d \
./Drivers/USB/Core/LPC/DCD/USBRom/usbd_rom.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/USB/Core/LPC/DCD/USBRom/%.o: ../Drivers/USB/Core/LPC/DCD/USBRom/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__LPC17XX__ -DUSB_DEVICE_ONLY -D__CODE_RED -D__REDLIB__ -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\CMSISv2p00_LPC17xx\inc" -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\CMSISv2p00_LPC17xx\lpcinc" -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\LPC17xxLib\inc" -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -std=gnu99 -mcpu=cortex-m3 -mthumb -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


