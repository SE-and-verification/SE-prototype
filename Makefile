default: VSE.o #tag

tag: firrtl_transform
	../se-firrtl/utils/bin/firrtl -td generated-src -i generated-src/SE.fir --custom-transforms firrtl.transforms.Tagrize -o tag.v -X verilog

firrtl_transform: ../se-firrtl/src/main/scala/firrtl/transforms/Tagrize.scala
	cd ../se-firrtl && sbt assembly

base_dir   = $(abspath .)
src_dir    = $(base_dir)/src/main
gen_dir    = $(base_dir)/generated-src
out_dir    = $(base_dir)/outputs

SBT       = sbt
# SBT_FLAGS = -ivy $(HOME)/.ivy2 

VERILATOR_FLAGS =--debug -I./obj_dir -I/usr/share/verilator/include module.cpp /usr/share/verilator/include/verilated.cpp

VSE.o: verilator_generate
	cd obj_dir; make -f VSE.mk ; cd ..

verilator_generate: generate
	verilator -Wno-fatal -cc -CFLAGS $(VERILATOR_FLAGS) $(gen_dir)/SE.v

# generate:
# 	$(SBT) $(SBT_FLAGS) 'run -td $(gen_dir) -foaf se'

generate:
	$(SBT) $(SBT_FLAGS) 'run $(gen_dir)'

sbt:
	$(SBT) $(SBT_FLAGS)

compile: $(gen_dir)/Tile.v

$(gen_dir)/Tile.v: $(wildcard $(src_dir)/scala/*.scala)
	$(SBT) $(SBT_FLAGS) "run $(gen_dir)"

CXXFLAGS += -std=c++11 -Wall -Wno-unused-variable

# compile verilator
# VERILATOR = verilator --cc --exe
# VERILATOR_FLAGS = --assert -Wno-STMTDLY -O3 --trace \
# 	--top-module Tile -Mdir $(gen_dir)/VTile.csrc \
# 	-CFLAGS "$(CXXFLAGS) -include $(gen_dir)/VTile.csrc/VTile.h" 

# $(base_dir)/VTile: $(gen_dir)/Tile.v $(src_dir)/cc/top.cc $(src_dir)/cc/mm.cc $(src_dir)/cc/mm.h
# 	$(VERILATOR) $(VERILATOR_FLAGS) -o $@ $< $(word 2, $^) $(word 3, $^)
# 	$(MAKE) -C $(gen_dir)/VTile.csrc -f VTile.mk

# verilator: $(base_dir)/VTile

# # isa tests + benchmarks with verilator
# test_hex_files = $(wildcard $(base_dir)/src/test/resources/*.hex)
# test_out_files = $(foreach f,$(test_hex_files),$(patsubst %.hex,%.out,$(out_dir)/$(notdir $f)))

# $(test_out_files): $(out_dir)/%.out: $(base_dir)/VTile $(base_dir)/src/test/resources/%.hex
# 	mkdir -p $(out_dir)
# 	$^ $(patsubst %.out,%.vcd,$@) 2> $@

# run-tests: $(test_out_files)

# # run custom benchamrk
# custom_bmark_hex ?= $(base_dir)/custom-bmark/main.hex
# custom_bmark_out  = $(patsubst %.hex,%.out,$(out_dir)/$(notdir $(custom_bmark_hex)))
# $(custom_bmark_hex):
# 	$(MAKE) -C custom-bmark

# $(custom_bmark_out): $(base_dir)/VTile $(custom_bmark_hex)
# 	mkdir -p $(out_dir)
# 	$^ $(patsubst %.out,%.vcd,$@) 2> $@

# run-custom-bmark: $(custom_bmark_out) 
	
# unit tests + integration tests 
test:
	$(SBT) $(SBT_FLAGS) test

clean:
	rm -rf $(gen_dir) $(out_dir) test_run_dir obj_dir/*

cleanall: clean
	rm -rf target project/target 

.PHONY: sbt compile verilator run-tests run-custom-bmark test clean cleanall


compile: $(gen_dir)/Tile.v

$(gen_dir)/Tile.v: $(wildcard $(src_dir)/scala/*.scala)
	$(SBT) $(SBT_FLAGS) "run $(gen_dir)"

CXXFLAGS += -std=c++11 -Wall -Wno-unused-variable

# compile verilator
# VERILATOR = verilator --cc --exe
# VERILATOR_FLAGS = --assert -Wno-STMTDLY -O3 --trace \
# 	--top-module Tile -Mdir $(gen_dir)/VTile.csrc \
# 	-CFLAGS "$(CXXFLAGS) -include $(gen_dir)/VTile.csrc/VTile.h" 

# $(base_dir)/VTile: $(gen_dir)/Tile.v $(src_dir)/cc/top.cc $(src_dir)/cc/mm.cc $(src_dir)/cc/mm.h
# 	$(VERILATOR) $(VERILATOR_FLAGS) -o $@ $< $(word 2, $^) $(word 3, $^)
# 	$(MAKE) -C $(gen_dir)/VTile.csrc -f VTile.mk

# verilator: $(base_dir)/VTile

# # isa tests + benchmarks with verilator
# test_hex_files = $(wildcard $(base_dir)/src/test/resources/*.hex)
# test_out_files = $(foreach f,$(test_hex_files),$(patsubst %.hex,%.out,$(out_dir)/$(notdir $f)))

# $(test_out_files): $(out_dir)/%.out: $(base_dir)/VTile $(base_dir)/src/test/resources/%.hex
# 	mkdir -p $(out_dir)
# 	$^ $(patsubst %.out,%.vcd,$@) 2> $@

# run-tests: $(test_out_files)

# # run custom benchamrk
# custom_bmark_hex ?= $(base_dir)/custom-bmark/main.hex
# custom_bmark_out  = $(patsubst %.hex,%.out,$(out_dir)/$(notdir $(custom_bmark_hex)))
# $(custom_bmark_hex):
# 	$(MAKE) -C custom-bmark

# $(custom_bmark_out): $(base_dir)/VTile $(custom_bmark_hex)
# 	mkdir -p $(out_dir)
# 	$^ $(patsubst %.out,%.vcd,$@) 2> $@

# run-custom-bmark: $(custom_bmark_out) 
	
# unit tests + integration tests 
test:
	$(SBT) $(SBT_FLAGS) test

clean:
	rm -rf $(gen_dir) $(out_dir) test_run_dir obj_dir/*

cleanall: clean
	rm -rf target project/target 

.PHONY: sbt compile verilator run-tests run-custom-bmark test clean cleanall
