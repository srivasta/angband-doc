############################ -*- Mode: Makefile -*- ###########################
## Makefile --- 
## Author           : Manoj Srivastava ( srivasta@glaurung.internal.golden-gryphon.com ) 
## Created On       : Thu Feb 19 11:47:01 2004
## Created On Node  : glaurung.internal.golden-gryphon.com
## Last Modified By : Manoj Srivastava
## Last Modified On : Thu Feb 19 12:27:03 2004
## Last Machine Used: glaurung.internal.golden-gryphon.com
## Update Count     : 6
## Status           : Unknown, Use with caution!
## HISTORY          : 
## Description      : 
## 
###############################################################################

prefix=
package = angband-doc

LIBLOC     = $(prefix)/var/games/angband/info
DOCDIR     = $(prefix)/usr/share/doc/$(package)

# install commands
install_file   = install -p    -o root -g root -m 644
install_program= install -p    -o root -g root -m 755
make_directory = install -p -d -o root -g root -m 755

all build: 
	@echo nothing to do for build

install:
	test -d $(DOCDIR) || $(make_directory)  $(DOCDIR)
	test -d $(LIBLOC) || $(make_directory)  $(LIBLOC)
	(cd Help-Info;    tar cf - *) | (cd $(LIBLOC); umask 000; tar xpf -)
	find $(LIBLOC)    -type d -name .arch-ids -print0 | xargs -0r rm -rf
	$(install_file)   debian/changelog             $(DOCDIR)/changelog
	gzip -9fqr        $(DOCDIR)
	$(install_file)   debian/copyright  	 $(DOCDIR)/copyright
	(cd Help-Page;    tar cf - *) | (cd $(DOCDIR); umask 000; tar xpf -)
	find $(DOCDIR)    -type d -name .arch-ids -print0 | xargs -0r rm -rf
	gzip -9fq         $(DOCDIR)/angfaq*.txt
	chown -R root:root $(DOCDIR) $(LIBLOC);
	chmod -R u+w,go=rX $(DOCDIR) $(LIBLOC);

clean distclean:
	@echo nothing to do for clean