PREFIX ?= /usr/local
CONFIG ?= /etc

all:
	@echo Run \'make install\' to install dmenufm.
	@echo You can find config file at ~/.config/dmenufm

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(CONFIG)
	@mkdir -p $(DESTDIR)$(PREFIX)/share/applications
	@cp -p dmenufm $(DESTDIR)$(PREFIX)/bin/dmenufm
	@cp -p dmenufm-open $(DESTDIR)$(PREFIX)/bin/dmenufm-open
	@cp -p dmenufm-menu $(DESTDIR)$(PREFIX)/bin/dmenufm-menu
	@cp -p dmenufm-action $(DESTDIR)$(PREFIX)/bin/dmenufm-action
	@cp -p dmenufm.conf $(DESTDIR)$(CONFIG)/dmenufm.conf
	@cp -p dmenufm.desktop $(DESTDIR)$(PREFIX)/share/applications
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenufm
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenufm-*

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/dmenufm*
	@rm -rf $(DESTDIR)$(PREFIX)/share/applications/dmenufm.desktop
	@rm -rf $(DESTDIR)$(CONFIG)/dmenufm.conf
