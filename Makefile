BIN ?= defaultbrowser
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
BUILD ?= ./build
BINBUILD ?= ./$(BUILD)/$(BIN)

.PHONY: all install uninstall clean

all:
	mkdir -p $(BUILD)
	swiftc -framework Foundation -framework ApplicationServices ./src/*.swift -o ${BINBUILD}

install: all
	install -d $(BINDIR)
	install -m 755 $(BINBUILD) $(BINDIR)

uninstall:
	rm -f $(BINDIR)/$(BIN)

clean:
	rm -rf $(BUILD)