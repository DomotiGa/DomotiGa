#
# Makefile for OpenzWave Linux applications
# GNU make only
#

.SUFFIXES:	.cpp .o .a .s

CC     := gcc
CXX    := g++
LD     := g++

DEBUG_CFLAGS    := -Wall -Wno-format -Wno-unknown-pragmas -ggdb -g -DDEBUG -fPIC $(CPPFLAGS)
RELEASE_CFLAGS  := -Wall -Wno-format -Wno-unknown-pragmas -O3 -fPIC $(CPPFLAGS)
DEBUG_LDFLAGS	:= -g

# Change for DEBUG or RELEASE
CFLAGS	:= -c $(DEBUG_CFLAGS)
LDFLAGS	:= $(DEBUG_LDFLAGS)

INCLUDES := -I open-zwave/cpp/src
LIBVERS  := $(wildcard open-zwave/cpp/src/vers.cpp)
LIBZWAVE := $(wildcard open-zwave/*.a)
LIBOTHER := -ljson -lcurl -pthread -shared -ludev
LIBS := $(LIBZWAVE) $(LIBOTHER)

%.o : %.cpp
	$(CXX) $(CFLAGS) $(INCLUDES) -o $@ $<

all: defs libdomozwave.so

defs:
ifeq ($(LIBVERS),)
	@echo open-zwave version file cannot be found at \"open-zwave/cpp/src/vers.cpp\", did you compile it?
	@exit 1
endif

ifeq ($(LIBZWAVE),)
	@echo open-zwave library cannot be found at \"open-zwave/*.a\", did you compile it?
	@exit 1
endif

libdomozwave.so:	DomoZWave.o
	$(LD) -o $@ $(LDFLAGS) $< $(LIBS)

clean:
	rm -f libdomozwave.so DomoZWave.o

install:
	cp libdomozwave.so /usr/local/lib
	ldconfig

