STRICTA ?= ../stricta/stricta
STRLIB  ?= ../strlib

.PHONY: build test clean

build:
	$(STRICTA) -I . -I $(STRLIB) main.str -o strictql

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
