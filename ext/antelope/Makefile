CC           = gcc
CFLAGS       = -std=c99 -W -Wall
BIN_DIR      = bin
BIN_FILE     = $(BIN_DIR)/antelope
SOURCE_FILES = antelope.c
SPEC_BIN     = $(BIN_DIR)/spec
SPECC_FILE   = antelope_spec.c
CSPEC_DIR    = dependencies/cspec

all: compile spec

compile: mkbin
	$(CC) -c $(SOURCE_FILES)

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
	$(CC) $(SPECC_FILE) antelope.o cspec.o -o $(SPEC_BIN) $(CFLAGS)

install_cspec:
	cd $(CSPEC_DIR); make
	cp $(CSPEC_DIR)/src/cspec.h .
	sudo cp $(CSPEC_DIR)/build/cspec.o .

clean_cspec:
	cd dependencies/cspec; make clean
