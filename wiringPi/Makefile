#
# Makefile:
#	wiringPi - Wiring Compatable library for the Raspberry Pi
#
#	Copyright (c) 2012-2015 Gordon Henderson
#################################################################################
# This file is part of wiringPi:
#	https://projects.drogon.net/raspberry-pi/wiringpi/
#
#    wiringPi is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    wiringPi is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
#################################################################################

VERSION=$(shell cat ../VERSION)
DESTDIR?=/usr
PREFIX?=/local

LDCONFIG?=ldconfig

ifneq ($V,1)
Q ?= @
endif

STATIC=libwiringPi.a
# DYNAMIC=libwiringPi.so
DYNAMIC=$(STATIC)

#DEBUG	= -g -O0
DEBUG	= -O2
CC		= gcc
AR      = ar
INCLUDE+= -I.
INCLUDE+= -I../include
INCLUDE+= -I/usr/local/include
# DEFS	= -D_GNU_SOURCE
C_FLAGS += -std=gnu11
C_FLAGS += -c
C_FLAGS += -Wall
C_FLAGS += -Wextra
C_FLAGS += -Wno-unused-parameter
C_FLAGS += -Wno-missing-field-initializers
C_FLAGS += -fmessage-length=0
C_FLAGS += -fno-exceptions
C_FLAGS += -ffunction-sections
C_FLAGS += -fdata-sections
C_FLAGS += -funsigned-char
C_FLAGS += -MMD
C_FLAGS += -fno-delete-null-pointer-checks
C_FLAGS += -fomit-frame-pointer
C_FLAGS += -Os
C_FLAGS += -g1
C_FLAGS += -lm -fopenmp
# C_FLAGS += -mthumb

CFLAGS	= $(DEBUG) $(INCLUDE) $(C_FLAGS)

# CFLAGS	= $(DEBUG) $(DEFS) -Wformat=2 -Wall -Wextra -Winline $(INCLUDE) -pipe -fPIC
# CFLAGS	= $(DEBUG) $(DEFS) -Wformat=2 -Wall -Wextra -Wconversion -Winline $(INCLUDE) -pipe -fPIC

LDFLAGS	= -L/usr/local/lib
LIBS    = -lm -lpthread -lrt -lcrypt

###############################################################################

SRC	=	wiringPi.c						\
		wiringSerial.c wiringShift.c				\
		piHiPri.c piThread.c					\
		wiringPiSPI.c wiringPiI2C.c				\
		softPwm.c softTone.c					\
		mcp23008.c mcp23016.c mcp23017.c			\
		mcp23s08.c mcp23s17.c					\
		sr595.c							\
		pcf8574.c pcf8591.c					\
		mcp3002.c mcp3004.c mcp4802.c mcp3422.c			\
		max31855.c max5322.c ads1115.c				\
		sn3218.c						\
		bmp180.c htu21d.c ds18b20.c rht03.c			\
		drcSerial.c drcNet.c					\
		pseudoPins.c						\
		wpiExtensions.c

HEADERS =	$(shell ls *.h)

OBJ	=	$(SRC:.c=.o)

all:		$(DYNAMIC)

$(DYNAMIC):	$(OBJ)
	$Q echo "[Link (Dynamic)]"
	# $(CC) -o $@ $(OBJ) $(LDFLAGS) $(LIBS)
	$(AR) -rc $@ $?

.c.o:
	$Q echo [Compile] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@


.PHONY:	clean
clean:
	$Q echo "[Clean]"
	$Q rm -f $(OBJ) $(OBJ_I2C) *~ core tags Makefile.bak libwiringPi.*

.PHONY:	tags
tags:	$(SRC)
	$Q echo [ctags]
	$Q ctags $(SRC)

.PHONY:	depend
depend:
	makedepend -Y $(SRC) $(SRC_I2C)

# DO NOT DELETE

wiringPi.o: ../include/softPwm.h ../include/softTone.h ../include/wiringPi.h ../version.h
wiringSerial.o: ../include/wiringSerial.h
wiringShift.o: ../include/wiringPi.h ../include/wiringShift.h
piHiPri.o: ../include/wiringPi.h
piThread.o: ../include/wiringPi.h
wiringPiSPI.o: ../include/wiringPi.h ../include/wiringPiSPI.h
wiringPiI2C.o: ../include/wiringPi.h ../include/wiringPiI2C.h
softPwm.o: ../include/wiringPi.h ../include/softPwm.h
softTone.o: ../include/wiringPi.h ../include/softTone.h
mcp23008.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/mcp23x0817.h ../include/mcp23008.h
mcp23016.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/mcp23016.h ../include/mcp23016reg.h
mcp23017.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/mcp23x0817.h ../include/mcp23017.h
mcp23s08.o: ../include/wiringPi.h ../include/wiringPiSPI.h ../include/mcp23x0817.h ../include/mcp23s08.h
mcp23s17.o: ../include/wiringPi.h ../include/wiringPiSPI.h ../include/mcp23x0817.h ../include/mcp23s17.h
sr595.o: ../include/wiringPi.h ../include/sr595.h
pcf8574.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/pcf8574.h
pcf8591.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/pcf8591.h
mcp3002.o: ../include/wiringPi.h ../include/wiringPiSPI.h ../include/mcp3002.h
mcp3004.o: ../include/wiringPi.h ../include/wiringPiSPI.h ../include/mcp3004.h
mcp4802.o: ../include/wiringPi.h ../include/wiringPiSPI.h ../include/mcp4802.h
mcp3422.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/mcp3422.h
max31855.o: ../include/wiringPi.h ../include/wiringPiSPI.h ../include/max31855.h
max5322.o: ../include/wiringPi.h ../include/wiringPiSPI.h ../include/max5322.h
ads1115.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/ads1115.h
sn3218.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/sn3218.h
bmp180.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/bmp180.h
htu21d.o: ../include/wiringPi.h ../include/wiringPiI2C.h ../include/htu21d.h
ds18b20.o: ../include/wiringPi.h ../include/ds18b20.h
drcSerial.o: ../include/wiringPi.h ../include/wiringSerial.h ../include/drcSerial.h
pseudoPins.o: ../include/wiringPi.h ../include/pseudoPins.h
wpiExtensions.o: ../include/wiringPi.h ../include/mcp23008.h ../include/mcp23016.h ../include/mcp23017.h ../include/mcp23s08.h
wpiExtensions.o: ../include/mcp23s17.h ../include/sr595.h ../include/pcf8574.h ../include/pcf8591.h ../include/mcp3002.h ../include/mcp3004.h
wpiExtensions.o: ../include/mcp4802.h ../include/mcp3422.h ../include/max31855.h ../include/max5322.h ../include/ads1115.h ../include/sn3218.h
wpiExtensions.o: ../include/drcSerial.h ../include/pseudoPins.h ../include/bmp180.h ../include/htu21d.h ../include/ds18b20.h
wpiExtensions.o: ../include/wpiExtensions.h
