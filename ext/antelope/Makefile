CC           = gcc
CFLAGS       = -std=c99 -W -Wall

BIN_DIR      = bin
BIN_FILE     = $(BIN_DIR)/antelope
SOURCE_FILES = antelope.c

SPEC_BIN     = $(BIN_DIR)/spec
SPECC_FILE   = antelope_spec.c

all: compile spec

compile: mkbin
	$(CC) $(SOURCE_FILES) -c

spec: compile_spec
	./$(SPEC_BIN)

clean:
	rm -rf $(BIN_DIR)
	rm -rf $(SPECC_FILE)

mkbin:
	mkdir -p $(BIN_DIR)

compile_cspec:
	cspec < antelope.spec > $(SPECC_FILE)

compile_spec: mkbin compile compile_cspec
	$(CC) $(SPECC_FILE) antelope.o -lcspec -o $(SPEC_BIN) $(CFLAGS)
