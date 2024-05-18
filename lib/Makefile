# Defines the output library
LIBNAME := splash
LIBFILE := lib$(LIBNAME).a

# Defines the inputs to the library
SFILES := \
	exit.S \
	getchar.S getline.S \
	putchar.S putstr.S putnum.S
OFILES := $(SFILES:.S=.o)

# Defines the toolchain and flags
CC := gcc
AR := ar
ASFLAGS := -g

.PHONY: all
all: $(LIBFILE)

.PHONY: clean
clean:
	rm -f $(OFILES) $(LIBFILE)

$(LIBFILE): $(OFILES)
	$(AR) rcs $@ $^

%.o: %.S
	$(CC) $(ASFLAGS) -c -o $@ $<
