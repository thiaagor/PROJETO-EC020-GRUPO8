################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/Lib/subdir.mk
-include src/EaBaseBoard/subdir.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: Project_ADK_XPR_BaseBoard.axf

# Tool invocations
Project_ADK_XPR_BaseBoard.axf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MCU Linker'
	arm-none-eabi-gcc -nostdlib -Xlinker -Map=Project_ADK_XPR_BaseBoard.map -Xlinker --gc-sections -mcpu=cortex-m3 -mthumb -T "Project_ADK_XPR_BaseBoard_Debug.ld" -o "Project_ADK_XPR_BaseBoard.axf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	$(MAKE) --no-print-directory post-build

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(EXECUTABLES) Project_ADK_XPR_BaseBoard.axf
	-@echo ' '

post-build:
	-@echo 'Performing post-build steps'
	-arm-none-eabi-size Project_ADK_XPR_BaseBoard.axf; # arm-none-eabi-objcopy -O binary Project_ADK_XPR_BaseBoard.axf Project_ADK_XPR_BaseBoard.bin ; checksum -p LPC1769 -d Project_ADK_XPR_BaseBoard.bin;
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY: post-build

-include ../makefile.targets
