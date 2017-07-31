CROSS_COMPILE ?=

CC	:= $(CROSS_COMPILE)gcc
CFLAGS	?= -O2 -W -Wall -Iinclude
LDFLAGS	?=
LIBS	:=

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<

all: edid

edid: edid.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

clean:
	-rm -f *.o
	-rm -f edid

