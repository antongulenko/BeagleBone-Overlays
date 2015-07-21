
include variables
all_src := $(shell find . -mindepth 1 -maxdepth 1 -name '*.dts' -printf '%f ')

ifndef all_src
$(error No .dts files found in current directory)
endif

all_out := $(all_src:.dts=-$(VERSION).dtbo)
all_install := $(addprefix $(FIRMWARE)/, $(all_out))
all := $(all_src:.dts=)

build: $(all_out)
install: $(all_install)

%-$(VERSION).dtbo: %.dts
	dtc -O dtb -b 0 -o $@ -@ $<

$(FIRMWARE)/%: %
	cp $< $@

clean:
	rm -f $(all_out)
