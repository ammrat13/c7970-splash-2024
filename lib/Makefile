# Defines the output library
LIBNAME := splash
LIBFILE := lib$(LIBNAME).a

# Defines the inputs to the library
SFILES := \
	exit.S \
	putchar.S putstr.S
OFILES := $(SFILES:.S=.o)

# Defines the toolchain
CC := gcc
AR := ar

.PHONY: all
all: $(LIBFILE)

.PHONY: clean
clean:
	rm -f $(OFILES) $(LIBFILE)

$(LIBFILE): $(OFILES)
	$(AR) rcs $@ $^

%.o: %.S
	$(CC) -c -o $@ $<
