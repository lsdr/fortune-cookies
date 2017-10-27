root := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
dirs := $(shell cat source_dirs)
files = $(foreach dir, $(dirs), $(wildcard $(dir)/*))

.PHONY: clean build $(files)

clean :
	@rm -fr $(root)/build/

build : $(files)

$(files) :
	@mkdir -p $(addprefix $(root)/build/, $(dir $@))
	@strfile -s $@ $(addprefix $(root)/build/, $(addsuffix .dat, $@))
