################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../CMSISv2p00_LPC17xx/src/core_cm3.c \
../CMSISv2p00_LPC17xx/src/cr_startup_lpc176x.c \
../CMSISv2p00_LPC17xx/src/system_LPC17xx.c 

OBJS += \
./CMSISv2p00_LPC17xx/src/core_cm3.o \
./CMSISv2p00_LPC17xx/src/cr_startup_lpc176x.o \
./CMSISv2p00_LPC17xx/src/system_LPC17xx.o 

C_DEPS += \
./CMSISv2p00_LPC17xx/src/core_cm3.d \
./CMSISv2p00_LPC17xx/src/cr_startup_lpc176x.d \
./CMSISv2p00_LPC17xx/src/system_LPC17xx.d 


# Each subdirectory must supply rules for building sources it contributes
CMSISv2p00_LPC17xx/src/%.o: ../CMSISv2p00_LPC17xx/src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__LPC17XX__ -D__REDLIB__ -D__CODE_RED -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\CMSISv2p00_LPC17xx\inc" -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\CMSISv2p00_LPC17xx\lpcinc" -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\LPC17xxLib\inc" -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m3 -mthumb -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


