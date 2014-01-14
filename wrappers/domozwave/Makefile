#
# Makefile for OpenzWave Linux applications
# Greg Satz

# GNU make only

.SUFFIXES:	.cpp .o .a .s

CC     := gcc
CXX    := g++
LD     := g++
AR     := ar rc
RANLIB := ranlib

DEBUG_CFLAGS    := -Wall -Wno-format -g -DDEBUG -fPIC
RELEASE_CFLAGS  := -Wall -Wno-unknown-pragmas -Wno-format -O3

DEBUG_LDFLAGS	:= -g

# Change for DEBUG or RELEASE
CFLAGS	:= -c $(DEBUG_CFLAGS)
LDFLAGS	:= $(DEBUG_LDFLAGS)

INCLUDES	:= -I open-zwave/cpp/src -I open-zwave/cpp/src/command_classes/ -I open-zwave/cpp/src/value_classes/ \
	-I open-zwave/cpp/src/platform/ -I open-zwave/cpp/tinyxml/ -I open-zwave/cpp/build/linux/ -I default/
LIBS := $(wildcard open-zwave/cpp/lib/linux/*.a) $(wildcard open-zwave/cpp/lib/*.a) -ljson -lcurl

%.o : %.cpp
	$(CXX) $(CFLAGS) $(INCLUDES) -o $@ $<

all: libdomozwave.so

libdomozwave.so:	DomoZWave.o
	$(LD) -o $@ $(LDFLAGS) $< $(LIBS) -pthread -shared -ludev

clean:
	rm -f libdomozwave.so DomoZWave.o
install:
	cp libdomozwave.so /usr/local/lib
	ldconfig
