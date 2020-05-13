PREFIX ?= /usr
CONFIG ?= /etc

all:
	@echo Run \'make install\' to install fzffm.
	@echo You can find config file at ~/.config/fzffm

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(PREFIX)/share/applications
	@cp -p fzffm $(DESTDIR)$(PREFIX)/bin/fzffm
	@cp -p fzffm-open $(DESTDIR)$(PREFIX)/bin/fzffm-open
	@cp -p fzffm-menu $(DESTDIR)$(PREFIX)/bin/fzffm-menu
	@cp -p fzffm-action $(DESTDIR)$(PREFIX)/bin/fzffm-action
	@cp -p fzffm.conf $(DESTDIR)$(CONFIG)/fzffm.conf
	@cp -p fzffm.desktop $(DESTDIR)$(PREFIX)/share/applications
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/fzffm
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/fzffm-*

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/fzffm*
	@rm -rf $(DESTDIR)$(PREFIX)/share/applications/fzffm.desktop
	@rm -rf $(DESTDIR)$(CONFIG)/fzffm.conf
