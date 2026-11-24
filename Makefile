STRICTA ?= ../stricta/stricta
STRLIB  ?= ../strlib
PREFIX  ?= $(HOME)/.local
BINDIR  ?= $(PREFIX)/bin

.PHONY: build install uninstall test clean

build:
	$(STRICTA) -I . -I $(STRLIB) main.str -o strictql

install: build
	install -d "$(DESTDIR)$(BINDIR)"
	install -m 755 strictql "$(DESTDIR)$(BINDIR)/strictql"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/strictql"

test:
	@set -e; \
	for f in tests/test_*.str; do \
		name=$$(basename "$$f" .str); \
		$(STRICTA) -I . -I $(STRLIB) "$$f" -o "/tmp/strictql_$$name"; \
		"/tmp/strictql_$$name"; \
		rm -f "/tmp/strictql_$$name"; \
	done; \
	echo "ALL STRICTQL TESTS PASSED"

clean:
	rm -f strictql *.ll *.o
