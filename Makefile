include build/main.mk

.PHONY: all clean

TARGET = libstm32f401re.a

SRCS = \
	$(shell find ./source -name "*.d") \
	$(shell find ./cortexm/source -name "*.d") \
	$(shell find ./semihosting/source -name "*.d")
OBJDIR = out
EXDIR = examples

LDCFLAGS = -mtriple=thumbv7em-none-linux-gnueabihf -betterC -defaultlib= -relocation-model=static -Os -release -g -lib -od=$(OBJDIR) -of$(TARGET)

LINKFLAGS = \
	-I./source \
	-I./cortexm/source

all: $(TARGET)

$(TARGET): $(SRCS)
	$(LDC) $(LDCFLAGS) -op ${LINKFLGAS} $^

clean:
	$(RM) -r $(OBJDIR)/* $(TARGET)
	$(MAKE) -C $(EXDIR)/led clean
	$(MAKE) -C $(EXDIR)/semihosting clean

examples: $(TARGET)
	$(MAKE) -C $(EXDIR)/led
	$(MAKE) -C $(EXDIR)/semihosting

led-run: $(TARGET)
	$(MAKE) -C $(EXDIR)/led run

semihosting-run: $(TARGET)
	$(MAKE) -C $(EXDIR)/semihosting run
