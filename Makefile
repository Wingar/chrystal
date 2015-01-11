NAME=chrystal
VERSION=0.1.0
AUTHOR=wingar
#URL=https://github.com/$(AUTHOR)/$(NAME)

DIRS=etc lib bin sbin share
INSTALL_DIRS=`find $(DIRS) -type d 2>/dev/null`
INSTALL_FILES=`find $(DIRS) -type f 2>/dev/null`
DOC_FILES=*.md *.txt

PKG_DIR=pkg
PKG_NAME=$(NAME)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
SIG=$(PKG).asc

PREFIX?=/usr/local
DOC_DIR=$(PREFIX)/share/doc/$(PKG_NAME)

#download: pkg
#	wget -O $(PKG) $(URL)/archive/v$(VERSION).tar.gz


clean:
	rm -f $(PKG) $(SIG)

#all: $(PKG) $(SIG)

#test/opt/rubies:
#	./test/setup

#test: test/opt/rubies
#	SHELL=`command -v bash` ./test/runner
#	SHELL=`command -v zsh`  ./test/runner

#tag:
#	git push origin master
#	git tag -s -m "Releasing $(VERSION)" v$(VERSION)
#	git push origin master --tags

#release: tag download sign

install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(DESTDIR)$(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(DESTDIR)$(PREFIX)/$$file; done
	mkdir -p $(DESTDIR)$(DOC_DIR)
	cp -r $(DOC_FILES) $(DESTDIR)$(DOC_DIR)/

uninstall:
	for file in $(INSTALL_FILES); do rm -f $(DESTDIR)$(PREFIX)/$$file; done
	rm -rf $(DESTDIR)$(DOC_DIR)

.PHONY: clean install uninstall
