#
# Makefile:
#	The gpio command:
#	  A swiss-army knige of GPIO shenanigans.
#	https://projects.drogon.net/wiring-pi
#
#	Copyright (c) 2012-2016 Gordon Henderson
#################################################################################
# This file is part of wiringPi:
#	A "wiring" library for the Raspberry Pi
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
DESTDIR?=/usr
PREFIX?=/local

ifneq ($V,1)
Q ?= @
endif

#DEBUG	= -g -O0
DEBUG	= -O2
CC	= gcc
INCLUDE+= -I.
INCLUDE+= -I./src
INCLUDE+= -I./include
INCLUDE+= -I./devLib
INCLUDE+= -I/usr/local/include
CFLAGS	= $(DEBUG) -Wall -Wextra $(INCLUDE) -Winline -pipe

LDFLAGS	= -L./wiringPi
LDFLAGS+= -L./devLib
LDFLAGS+= -L/usr/local/lib
# LDLIBS  = -lwiringPi -lpthread -lm -lcrypt

LIBS    = -lwiringPi -lwiringPiDev -lpthread -lrt -lm -lcrypt

# May not need to  alter anything below this line
###############################################################################

SRC_DIR = ./src

SRCS = $(wildcard $(SRC_DIR)/*.c)

OBJECTS+=$(patsubst %.c,%.o,$(SRCS))

BINS	=	gpio

all: $(BINS)

$(BINS):	$(OBJECTS)
	$Q $(MAKE) -C wiringPi
	$Q $(MAKE) -C devLib
	$Q echo [link]
	$Q $(CC) -o $@ $(OBJECTS) $(LDFLAGS) $(LIBS)

version.h:	../VERSION
	$Q echo Need to run newVersion above.

.c.o:
	$Q echo [Compile] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@

.PHONY:	clean
clean:
	$Q echo [Clean]
	$Q rm -f $(OBJECTS) $(BINS) *~ core tags *.bak
	$Q rm -f ./wiringPi/*.o
	$Q rm -f ./wiringPi/*.d
	$Q rm -f ./wiringPi/*.a
	$Q rm -f ./devLib/*.o
	$Q rm -f ./devLib/*.a
	$Q rm -f ./devLib/*.d

.PHONY:	install
install: gpio
	$Q echo "[Install gpio]"
	$Q cp gpio	$(DESTDIR)
	$Q chown root.root	$(DESTDIR)/gpio

.PHONY:	tags
tags:	$(SRC)
	$Q echo [ctags]
	$Q ctags $(SRC)

.PHONY:	depend
depend:
	makedepend -Y $(SRC)

# DO NOT DELETE

gpio.o: ../version.h
