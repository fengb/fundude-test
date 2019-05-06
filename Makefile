BUILD_DIR := build
DST_DIR := dist

SRC_DIR := src
SRC_FILES := $(wildcard $(SRC_DIR)/*.asm)
DST_FILES := $(patsubst $(SRC_DIR)/%.asm,$(DST_DIR)/%.gb,$(SRC_FILES))

all: $(DST_FILES)

clean:
	rm -rf build/* dist/*

$(DST_DIR)/%.gb: $(SRC_DIR)/%.asm
	@mkdir -p $(BUILD_DIR) $(DST_DIR)
	rgbasm -o $(BUILD_DIR)/$*.o $<
	rgblink -o $@ $(BUILD_DIR)/$*.o
	rgbfix -v -p 0 $@

