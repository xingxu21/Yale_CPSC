TESTS = cat blockcat randblockcat gather scatter reverse \
	reordercat stridecat ostridecat
STDIOTESTS = $(patsubst %,stdio-%,$(TESTS))
SLOWTESTS = $(patsubst %,slow-%,$(TESTS))
UBERPI = uber-pi 
# Default optimization level
O ?= -O2

all: tests stdio 
	@echo "*** Run 'make check' to check your work."

tests: $(TESTS)
stdio: $(STDIOTESTS)
slow: $(SLOWTESTS)

-include rules.mk

%.o: %.c io.h $(BUILDSTAMP)
	$(call run,$(CC) $(CPPFLAGS) $(CFLAGS) $(O) $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

$(TESTS): %: io.o profile.o %.o
	$(call run,$(CC) $(CFLAGS) $(O) -o $@ $^ $(LDFLAGS) $(LIBS),LINK $@)

$(SLOWTESTS): slow-%: slow-io.o profile.o %.o
	$(call run,$(CC) $(CFLAGS) $(O) -o $@ $^ $(LDFLAGS) $(LIBS),LINK $@)

$(STDIOTESTS): stdio-%: stdio-io.o profile.o %.o
	$(call run,$(CC) $(CFLAGS) $(O) -o $@ $^ $(LDFLAGS) $(LIBS),$(STDIO_LINK_LINE))
	@echo >$(DEPSDIR)/stdio.txt

$(UBERPI): %: %.c
	@echo COMPILE $@
	@$(CC) -std=gnu99 -m32 -g -W -Wall -Wshadow $(O) -o $@ $< -lpthread

clean: clean-main
clean-main:
	$(call run,rm -f $(TESTS) $(SLOWTESTS) $(STDIOTESTS) $(UBERPI) *.o core *.core,CLEAN)
	$(call run,rm -rf $(DEPSDIR) files *.dSYM)
distclean: clean

check:
	perl check.pl

check-%:
	perl check.pl $(subst check-,,$@)

check-uber: $(UBERPI)
	@echo CHECKING
	@python3 check.py


.PRECIOUS: %.o
.PHONY: all tests stdio slow \
	clean clean-main distclean check check-% prepare-check
