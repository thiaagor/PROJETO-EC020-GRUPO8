################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../LPC17xxLib/src/lpc17xx_adc.c \
../LPC17xxLib/src/lpc17xx_can.c \
../LPC17xxLib/src/lpc17xx_clkpwr.c \
../LPC17xxLib/src/lpc17xx_dac.c \
../LPC17xxLib/src/lpc17xx_debug_frmwrk.c \
../LPC17xxLib/src/lpc17xx_emac.c \
../LPC17xxLib/src/lpc17xx_exti.c \
../LPC17xxLib/src/lpc17xx_gpdma.c \
../LPC17xxLib/src/lpc17xx_gpio.c \
../LPC17xxLib/src/lpc17xx_i2c.c \
../LPC17xxLib/src/lpc17xx_i2s.c \
../LPC17xxLib/src/lpc17xx_libcfg_default.c \
../LPC17xxLib/src/lpc17xx_mcpwm.c \
../LPC17xxLib/src/lpc17xx_nvic.c \
../LPC17xxLib/src/lpc17xx_pinsel.c \
../LPC17xxLib/src/lpc17xx_pwm.c \
../LPC17xxLib/src/lpc17xx_qei.c \
../LPC17xxLib/src/lpc17xx_rit.c \
../LPC17xxLib/src/lpc17xx_rtc.c \
../LPC17xxLib/src/lpc17xx_spi.c \
../LPC17xxLib/src/lpc17xx_ssp.c \
../LPC17xxLib/src/lpc17xx_systick.c \
../LPC17xxLib/src/lpc17xx_timer.c \
../LPC17xxLib/src/lpc17xx_uart.c \
../LPC17xxLib/src/lpc17xx_wdt.c 

OBJS += \
./LPC17xxLib/src/lpc17xx_adc.o \
./LPC17xxLib/src/lpc17xx_can.o \
./LPC17xxLib/src/lpc17xx_clkpwr.o \
./LPC17xxLib/src/lpc17xx_dac.o \
./LPC17xxLib/src/lpc17xx_debug_frmwrk.o \
./LPC17xxLib/src/lpc17xx_emac.o \
./LPC17xxLib/src/lpc17xx_exti.o \
./LPC17xxLib/src/lpc17xx_gpdma.o \
./LPC17xxLib/src/lpc17xx_gpio.o \
./LPC17xxLib/src/lpc17xx_i2c.o \
./LPC17xxLib/src/lpc17xx_i2s.o \
./LPC17xxLib/src/lpc17xx_libcfg_default.o \
./LPC17xxLib/src/lpc17xx_mcpwm.o \
./LPC17xxLib/src/lpc17xx_nvic.o \
./LPC17xxLib/src/lpc17xx_pinsel.o \
./LPC17xxLib/src/lpc17xx_pwm.o \
./LPC17xxLib/src/lpc17xx_qei.o \
./LPC17xxLib/src/lpc17xx_rit.o \
./LPC17xxLib/src/lpc17xx_rtc.o \
./LPC17xxLib/src/lpc17xx_spi.o \
./LPC17xxLib/src/lpc17xx_ssp.o \
./LPC17xxLib/src/lpc17xx_systick.o \
./LPC17xxLib/src/lpc17xx_timer.o \
./LPC17xxLib/src/lpc17xx_uart.o \
./LPC17xxLib/src/lpc17xx_wdt.o 

C_DEPS += \
./LPC17xxLib/src/lpc17xx_adc.d \
./LPC17xxLib/src/lpc17xx_can.d \
./LPC17xxLib/src/lpc17xx_clkpwr.d \
./LPC17xxLib/src/lpc17xx_dac.d \
./LPC17xxLib/src/lpc17xx_debug_frmwrk.d \
./LPC17xxLib/src/lpc17xx_emac.d \
./LPC17xxLib/src/lpc17xx_exti.d \
./LPC17xxLib/src/lpc17xx_gpdma.d \
./LPC17xxLib/src/lpc17xx_gpio.d \
./LPC17xxLib/src/lpc17xx_i2c.d \
./LPC17xxLib/src/lpc17xx_i2s.d \
./LPC17xxLib/src/lpc17xx_libcfg_default.d \
./LPC17xxLib/src/lpc17xx_mcpwm.d \
./LPC17xxLib/src/lpc17xx_nvic.d \
./LPC17xxLib/src/lpc17xx_pinsel.d \
./LPC17xxLib/src/lpc17xx_pwm.d \
./LPC17xxLib/src/lpc17xx_qei.d \
./LPC17xxLib/src/lpc17xx_rit.d \
./LPC17xxLib/src/lpc17xx_rtc.d \
./LPC17xxLib/src/lpc17xx_spi.d \
./LPC17xxLib/src/lpc17xx_ssp.d \
./LPC17xxLib/src/lpc17xx_systick.d \
./LPC17xxLib/src/lpc17xx_timer.d \
./LPC17xxLib/src/lpc17xx_uart.d \
./LPC17xxLib/src/lpc17xx_wdt.d 


# Each subdirectory must supply rules for building sources it contributes
LPC17xxLib/src/%.o: ../LPC17xxLib/src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__LPC17XX__ -D__REDLIB__ -D__CODE_RED -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\CMSISv2p00_LPC17xx\inc" -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\CMSISv2p00_LPC17xx\lpcinc" -I"C:\Users\aluno.SERVIDORES\Documents\LPCXpresso_6.1.4_194\workspace\CDL\LPC17xxLib\inc" -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m3 -mthumb -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


