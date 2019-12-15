PREFIX ?= /usr
MANDIR ?= $(PREFIX)/share/man
DOCDIR ?= $(PREFIX)/share/doc/dmenufm

all:
	@echo Run \'make install\' to install fff.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(MANDIR)/man1
	@mkdir -p $(DESTDIR)$(DOCDIR)
	@cp -p dmenufm $(DESTDIR)$(PREFIX)/bin/dmenufm
	@cp -p README.md $(DESTDIR)$(DOCDIR)
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenufm

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/dmenufm
	@rm -rf $(DESTDIR)$(DOCDIR)
