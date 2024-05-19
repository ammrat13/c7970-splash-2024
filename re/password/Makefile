PROGNAME := password
PROGFILE := $(PROGNAME).elf

# Specify which object files to keep and which ones can be deleted
OFILES_K := check.o
OFILES_D := main.o
OFILES := $(OFILES_K) $(OFILES_D)

# Defines the toolchain and flags
CC := gcc
CFLAGS := -O2 -Wall -Wextra -Werror

.PHONY: all
all: $(PROGFILE) $(OFILES_K)

.PHONY: problem
problem: $(OFILES_K)

.PHONY: clean
clean:
	rm -f $(PROGFILE) $(OFILES)

$(PROGFILE): $(OFILES)
	$(CC) -o $@ $(OFILES)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<
