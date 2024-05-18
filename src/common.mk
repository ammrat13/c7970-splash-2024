# Common Makefile for all the programs. It expects the following variables to be
# defined:
#   - PROGNAME: the name of the program
#   - SFILES: the assembly source files

PROGFILE := $(PROGNAME).elf
OFILES := $(SFILES:.S=.o)

# Get the directory of this script
# See: https://stackoverflow.com/a/73509979
CUR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Defines the toolchain
CC := gcc
LDFLAGS := -nostdlib -L$(CUR)/../lib/
LFLAGS := -lsplash

.PHONY: all
all: $(PROGFILE)
	echo $(MAKEFILE_LIST)

.PHONY: clean
clean: lib-clean
	rm -f $(PROGFILE) $(OFILES)

$(PROGFILE): $(OFILES) lib-all
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(LFLAGS)

%.o: %.S
	$(CC) -c -o $@ $<

.PHONY: lib-all
lib-all:
	$(MAKE) -C $(CUR)/../lib/ all

.PHONY: lib-clean
lib-clean:
	$(MAKE) -C $(CUR)/../lib/ clean
