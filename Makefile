root := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
dirs := $(shell cat source_dirs)
files = $(foreach dir, $(dirs), $(wildcard cookies/$(dir)/*))

.PHONY: clean build $(files) install

TARGET_DIR = /usr/local/share/games/fortunes

clean :
	@rm -fr $(root)/build
	@rm -fr $(root)/release

build : clean $(files)

$(files) :
	mkdir -p $(addprefix $(root)/build/, $(dir $@))
	strfile -s $@ $(addprefix $(root)/build/, $(addsuffix .dat, $@))

release : build
	mkdir -p $(root)/release
	cp -a $(wildcard $(root)/build/cookies/*/*.dat) $(root)/release
	cp -a $(wildcard $(root)/cookies/*/*) $(root)/release

install : release
	test -d $(TARGET_DIR)
	cp -a $(root)/release/* $(TARGET_DIR)
