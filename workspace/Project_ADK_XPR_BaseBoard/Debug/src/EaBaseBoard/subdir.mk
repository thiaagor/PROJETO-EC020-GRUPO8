################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/EaBaseBoard/acc.c \
../src/EaBaseBoard/joystick.c \
../src/EaBaseBoard/light.c \
../src/EaBaseBoard/rgb.c \
../src/EaBaseBoard/temp.c 

OBJS += \
./src/EaBaseBoard/acc.o \
./src/EaBaseBoard/joystick.o \
./src/EaBaseBoard/light.o \
./src/EaBaseBoard/rgb.o \
./src/EaBaseBoard/temp.o 

C_DEPS += \
./src/EaBaseBoard/acc.d \
./src/EaBaseBoard/joystick.d \
./src/EaBaseBoard/light.d \
./src/EaBaseBoard/rgb.d \
./src/EaBaseBoard/temp.d 


# Each subdirectory must supply rules for building sources it contributes
src/EaBaseBoard/%.o: ../src/EaBaseBoard/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -DARCH=ARCH_LPC -D__LPC17XX__ -DUSB_HOST_ONLY -D__REDLIB__ -DDEBUG -D__CODE_RED -D__USE_CMSIS=CMSISv2p00_LPC17xx -I"C:\Users\Thiago Rocha\Documents\LPCXpresso_6.1.4_194\workspace\Project_ADK_XPR_BaseBoard" -I"C:\Users\Thiago Rocha\Documents\LPCXpresso_6.1.4_194\workspace\Project_ADK_XPR_BaseBoard\src\EaBaseBoard" -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections  -std=gnu99 -mcpu=cortex-m3 -mthumb -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


