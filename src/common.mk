# Common Makefile for all the programs. It expects the following variables to be
# defined:
#   - PROGNAME: the name of the program
#   - SFILES: the assembly source files

# Derive the set of object files from the source files
OFILES := $(SFILES:.S=.o)

# Get the directory of this script
# See: https://stackoverflow.com/a/73509979
CUR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Defines the toolchain
CC := gcc
LDFLAGS := -nostdlib -L$(CUR)/../lib/
LFLAGS := -lsplash

.PHONY: all
all: $(PROGNAME)
	echo $(MAKEFILE_LIST)

.PHONY: clean
clean: lib-clean
	rm -f $(PROGNAME) $(OFILES)

$(PROGNAME): $(OFILES) lib-all
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(LFLAGS)

%.o: %.S
	$(CC) -c -o $@ $<

.PHONY: lib-all
lib-all:
	$(MAKE) -C $(CUR)/../lib/ all

.PHONY: lib-clean
lib-clean:
	$(MAKE) -C $(CUR)/../lib/ clean
