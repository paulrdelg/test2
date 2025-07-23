
.PHONY: create_lib compile run

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
test1 := $(dir $(mkfile_path))
test2 = $(patsubst %/,%,$(test1))
cur_dir := $(dir $(test2))

fp_transcript = $(cur_dir)transcript
fp_modelsimini = $(cur_dir)modelsim.ini

slash_to_backslash = $(subst /,\\,$(1))

define CLEAN_MODELSIMINI
	@echo "cleaning $(1)..."
	@del /f $(subst /,\\,$(1))
endef


ifeq ($(wildcard $(fp_modelsimini)),$(fp_modelsimini))
print:
	$(info "got it")
else
print:
	$(info "doesn't exists")
	$(info $(fp_modelsimini))
endif

clean:
#	#rm -f .\transcript
	$(call CLEAN_MODELSIMINI,$(fp_modelsimini))
	rm -rf testlib

create_lib:
	vlib testlib
	vmap testlib ./testlib

compile:
	vlog -sv -modelsimini cfg/modelsim.ini source/and_gate.sv
	vlog -sv -modelsimini cfg/modelsim.ini source/tb.sv

run:
	echo "test3"
	vsim
