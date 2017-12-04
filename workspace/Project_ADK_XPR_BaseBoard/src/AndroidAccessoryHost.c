/*
             LUFA Library
     Copyright (C) Dean Camera, 2011.

  dean [at] fourwalledcubicle [dot] com
           www.lufa-lib.org
*/

/*
  Copyright 2011  Dean Camera (dean [at] fourwalledcubicle [dot] com)

  Permission to use, copy, modify, distribute, and sell this
  software and its documentation for any purpose is hereby granted
  without fee, provided that the above copyright notice appear in
  all copies and that both that the copyright notice and this
  permission notice and warranty disclaimer appear in supporting
  documentation, and that the name of the author not be used in
  advertising or publicity pertaining to distribution of the
  software without specific, written prior permission.

  The author disclaim all warranties with regard to this
  software, including all implied warranties of merchantability
  and fitness.  In no event shall the author be liable for any
  special, indirect or consequential damages or any damages
  whatsoever resulting from loss of use, data or profits, whether
  in an action of contract, negligence or other tortious action,
  arising out of or in connection with the use or performance of
  this software.
*/

/*
 * Embedded Artists AB.
 *
 * This file has been modified by Embedded Artists AB for the AOA Demo
 */

/** \file
 *
 *  Main source file for the AndroidAccessoryHost demo. This file contains the main tasks
 *  of the demo and is responsible for the initial application hardware configuration.
 */

#include "AndroidAccessoryHost.h"

#include "lpc_types.h"
#include "lpc17xx_uart.h"
#include "lpc17xx_pinsel.h"
#include "lpc17xx_timer.h"
#include "lpc17xx_gpio.h"
#include "lpc17xx_adc.h"

#include "rgb.h"
#include "temp.h"
#include "joystick.h"
#include "acc.h"
#include "light.h"

/******************************************************************************
 * Defines and typedefs
 *****************************************************************************/

typedef struct tag_AccPositoion
{
	int8_t	cX;
	int8_t	cY;
	int8_t	cZ;
}ttag_AccPositoion;

#define puts_P(x)		puts(x)
#define PSTR(x)			x
#define printf_P		printf

/*
 * Message indexes for messages sent to the device
 */
#define CMD_TEMPERATURE 	(0)
#define CMD_JOYSTICK    	(1)
#define CMD_ACCELEROMETER   (2)
#define CMD_ANALOGINPUT		(3)
#define CMD_LIGHTSENSOR		(4)

/*
 * Message indexes for messages sent from the device
 */
#define CMD_RGB_LED     (10)
#define CMD_CONNECT     (98)
#define CMD_DISCONNECT  (99)
#define CMD_POLL        (100)

uint32_t getMsTicks(void);;

/******************************************************************************
 * Local variables
 *****************************************************************************/

static uint32_t lastTempCheck = 0;
#ifndef USE_INTERNAL_SERIAL
static uint32_t lastPosCheck = 0;
#else
static uint32_t lastLightCheck = 0;
#endif
static uint32_t lastAnalogCheck = 0;
static int32_t lastTemp = 0;
static uint8_t lastJoyState = 0;
static uint8_t connected = 0;
static uint8_t doDisconnect = 0;
static ttag_AccPositoion ptagLastPosition;


static int rgbRed = 0;
static int rgbGreen = 0;
static int rgbBlue = 0;

/******************************************************************************
 * Local functions
 *****************************************************************************/

static void sendCommand(uint8_t cmd, uint8_t* data, uint8_t len)
{
	if (USB_HostState != HOST_STATE_Configured)
	  return;

	/* Select the data OUT pipe */
	Pipe_SelectPipe(ANDROID_DATA_OUT_PIPE);
	Pipe_Unfreeze();

	if (Pipe_IsReadWriteAllowed()) {
		Pipe_Write_8(cmd);
		Pipe_Write_Stream_LE(data, len, NULL);
		Pipe_ClearOUT();
	}

	Pipe_Freeze();

}

static void processCommand(uint8_t cmd, uint8_t hi, uint8_t lo)
{

	switch (cmd)
	{
	case CMD_RGB_LED:

		switch (hi) {
		case 0x01: // RED
			rgbRed = (lo != 0);
			break;
		case 0x02: // GREEN
			rgbGreen = (lo != 0);
			break;
		case 0x04: // BLUE
			rgbBlue = (lo != 0);
			break;
		}

		rgb_setLeds(
				(rgbRed ? RGB_RED : 0) |
				(rgbGreen ? RGB_GREEN : 0) |
				(rgbBlue ? RGB_BLUE : 0)
		);

		break;
	case CMD_CONNECT:
		connected = 1;
		break;
	case CMD_DISCONNECT:
		doDisconnect = 1;
		break;
	}


}

void AndroidHost_Task(void)
{
	if (USB_HostState != HOST_STATE_Configured)
	  return;	

	/* Select the data IN pipe */
	Pipe_SelectPipe(ANDROID_DATA_IN_PIPE);
	Pipe_Unfreeze();

	/* Check to see if a packet has been received */
	if (Pipe_IsINReceived())
	{
		/* Re-freeze IN pipe after the packet has been received */
		Pipe_Freeze();


		/* Check if data is in the pipe */
		if (Pipe_IsReadWriteAllowed())
		{
			uint8_t numBytes = Pipe_BytesInPipe();

			if (numBytes == 3) {

				uint8_t c = Pipe_Read_8();
				uint8_t t = Pipe_Read_8();
				uint8_t d = Pipe_Read_8();
				processCommand(c, t, d);
			}

		}

		/* Clear the pipe after all data in the packet has been read, ready for the next packet */
		Pipe_ClearIN();
	}

	/* Re-freeze IN pipe after use */
	Pipe_Freeze();
}

void Monitor_Task(void)
{
	if(!connected)	return;

	uint8_t 	data[3];
	uint8_t 	joy = 0;
	uint16_t	uiVal;
	ttag_AccPositoion ptagPos;

	if (doDisconnect)
	{
		doDisconnect = 0;
		sendCommand(CMD_DISCONNECT, 0, 0);
		connected = 0;
	}
	else
	{
		if (getMsTicks() > lastTempCheck + 2000)
		{
			int32_t t = temp_read();

			if (t != lastTemp)
			{
				lastTemp = t;

				data[0] = (t >> 8);
				data[1] = (t & 0xff);

				sendCommand(CMD_TEMPERATURE, data, 2);
			}

			lastTempCheck = getMsTicks();
		}

		joy = joystick_read();
		if (joy != lastJoyState)
		{
			uint8_t btn = 0;
			uint8_t on = 0;
			if (joy & JOYSTICK_DOWN)
			{
				btn = 0;
				on = 1;
			}
			else if (joy & JOYSTICK_UP)
			{
				btn = 1;
				on = 1;
			}
			else if (joy & JOYSTICK_RIGHT)
			{
				btn = 2;
				on = 1;
			}
			else if (joy & JOYSTICK_LEFT)
			{
				btn = 3;
				on = 1;
			}

			data[0] = btn;
			data[1] = on;

			sendCommand(CMD_JOYSTICK, data, 2);
			lastJoyState = joy;
		}

		if (getMsTicks() > lastPosCheck + 500)
		{
			acc_read(&ptagPos.cX,&ptagPos.cY,&ptagPos.cZ);
			if((ptagPos.cX != ptagLastPosition.cX) ||
			   (ptagPos.cY != ptagLastPosition.cY) ||
			   (ptagPos.cZ != ptagLastPosition.cZ))
			{
				data[0]= ptagPos.cX;
				data[1]= ptagPos.cY;
				data[2]= ptagPos.cZ;

				sendCommand(CMD_ACCELEROMETER,data,3);
				ptagLastPosition.cX = ptagPos.cX;
				ptagLastPosition.cY = ptagPos.cY;
				ptagLastPosition.cZ = ptagPos.cZ;
			}
			lastPosCheck = getMsTicks();
		}
#ifndef USE_INTERNAL_SERIAL
		if (getMsTicks() > lastAnalogCheck + 500)
		{
			//Wait conversion complete
			if(ADC_ChannelGetStatus(LPC_ADC,ADC_CHANNEL_5,ADC_DATA_DONE))
			{
				uiVal = ADC_ChannelGetData(LPC_ADC,ADC_CHANNEL_5);
				data[0]= uiVal;
				sendCommand(CMD_ANALOGINPUT,data,1);
			}
			lastAnalogCheck = getMsTicks();
		}
#else
		if (getMsTicks() > lastLightCheck + 500)
		{
			data[0] = light_read();
			sendCommand(CMD_ACCELEROMETER,data,1);
			lastLightCheck = getMsTicks();
		}
#endif
	}


}

/** Event handler for the USB_DeviceAttached event. This indicates that a device has been attached to the host, and
 *  starts the library USB task to begin the enumeration and USB management process.
 */
void EVENT_USB_Host_DeviceAttached(void)
{
	puts_P(PSTR(ESC_FG_GREEN "Device Attached.\r\n" ESC_FG_WHITE));
}

/** Event handler for the USB_DeviceUnattached event. This indicates that a device has been removed from the host, and
 *  stops the library USB task management process.
 */
void EVENT_USB_Host_DeviceUnattached(void)
{
	puts_P(PSTR(ESC_FG_GREEN "\r\nDevice Unattached.\r\n" ESC_FG_WHITE));
}

/** Event handler for the USB_DeviceEnumerationComplete event. This indicates that a device has been successfully
 *  enumerated by the host and is now ready to be used by the application.
 */
void EVENT_USB_Host_DeviceEnumerationComplete(void)
{
	puts_P(PSTR("Getting Device Data.\r\n"));

	/* Get and process the configuration descriptor data */
	uint8_t ErrorCode = ProcessDeviceDescriptor();
	
	bool RequiresModeSwitch = (ErrorCode == NonAccessoryModeAndroidDevice);

	/* Error out if the device is not an Android device or an error occurred */
	if ((ErrorCode != AccessoryModeAndroidDevice) && (ErrorCode != NonAccessoryModeAndroidDevice))
	{
		if (ErrorCode == ControlError)
		  puts_P(PSTR(ESC_FG_RED "Control Error (Get Device).\r\n"));
		else
		  puts_P(PSTR(ESC_FG_RED "Invalid Device.\r\n"));

		printf_P(PSTR(" -- Error Code: %d\r\n" ESC_FG_WHITE), ErrorCode);
		return;
	}

	printf_P(PSTR("Android Device Detected - %sAccessory mode.\r\n"), (RequiresModeSwitch ? "Non-" : ""));
	
	/* Check if a valid Android device was attached, but it is not current in Accessory mode */
	if (RequiresModeSwitch)
	{
		uint16_t AndroidProtocol;
	
		/* Fetch the version of the Android Accessory Protocol supported by the device */
		if ((ErrorCode = Android_GetAccessoryProtocol(&AndroidProtocol)) != HOST_SENDCONTROL_Successful)
		{
			printf_P(PSTR(ESC_FG_RED "Control Error (Get Protocol).\r\n"
			                         " -- Error Code: %d\r\n" ESC_FG_WHITE), ErrorCode);
			return;
		}
		
		/* Validate the returned protocol version */
		if (AndroidProtocol != ANDROID_PROTOCOL_Accessory)
		{
			puts_P(PSTR(ESC_FG_RED "Accessory Mode Not Supported."));
			return;
		}
	
		/* Send the device strings and start the Android Accessory Mode */

		// Bug: The first call to _SendString seem to generate
		//      bad data. At least it isn't received correctly
		//      on the Android device.
		//
		// Workaround: calling twice for Manufacturer
		Android_SendString(ANDROID_STRING_Manufacturer, "Embedded Artists AB");

		Android_SendString(ANDROID_STRING_Manufacturer, "Embedded Artists AB");
		Android_SendString(ANDROID_STRING_Model,        "LPCXpresso Base Board");
		Android_SendString(ANDROID_STRING_Description,  "AOA Demo for LPCXpresso Base Board");
		Android_SendString(ANDROID_STRING_Version,      "Rev B");
		Android_SendString(ANDROID_STRING_URI,          "http://www.embeddedartists.com/_aoa/AOADemo_XPR.apk");
		Android_SendString(ANDROID_STRING_Serial,       "N/A");


		Android_StartAccessoryMode();	
		return;
	}

	puts_P(PSTR("Getting Config Data.\r\n"));

	/* Get and process the configuration descriptor data */
	if ((ErrorCode = ProcessConfigurationDescriptor()) != SuccessfulConfigRead)
	{
		if (ErrorCode == ControlError)
		  puts_P(PSTR(ESC_FG_RED "Control Error (Get Configuration).\r\n"));
		else
		  puts_P(PSTR(ESC_FG_RED "Invalid Device.\r\n"));

		printf_P(PSTR(" -- Error Code: %d\r\n" ESC_FG_WHITE), ErrorCode);

		return;
	}

	/* Set the device configuration to the first configuration (rarely do devices use multiple configurations) */
	if ((ErrorCode = USB_Host_SetDeviceConfiguration(1)) != HOST_SENDCONTROL_Successful)
	{
		printf_P(PSTR(ESC_FG_RED "Control Error (Set Configuration).\r\n"
		                         " -- Error Code: %d\r\n" ESC_FG_WHITE), ErrorCode);
		return;
	}

	puts_P(PSTR("Accessory Mode Android Enumerated.\r\n"));
}

/** Event handler for the USB_HostError event. This indicates that a hardware error occurred while in host mode. */
void EVENT_USB_Host_HostError(const uint8_t ErrorCode)
{
	USB_Disable();

	printf_P(PSTR(ESC_FG_RED "Host Mode Error\r\n"
	                         " -- Error Code %d\r\n" ESC_FG_WHITE), ErrorCode);

	for(;;);
}

/** Event handler for the USB_DeviceEnumerationFailed event. This indicates that a problem occurred while
 *  enumerating an attached USB device.
 */
void EVENT_USB_Host_DeviceEnumerationFailed(const uint8_t ErrorCode,
                                            const uint8_t SubErrorCode)
{
	printf_P(PSTR(ESC_FG_RED "Dev Enum Error\r\n"
	                         " -- Error Code %d\r\n"
	                         " -- Sub Error Code %d\r\n"
	                         " -- In State %d\r\n" ESC_FG_WHITE), ErrorCode, SubErrorCode, USB_HostState);

}

