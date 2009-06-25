############################ -*- Mode: Makefile -*- ###########################
## local.mk --- 
## Author           : Manoj Srivastava ( srivasta@glaurung.green-gryphon.com ) 
## Created On       : Sat Nov 15 10:42:10 2003
## Created On Node  : glaurung.green-gryphon.com
## Last Modified By : Manoj Srivastava
## Last Modified On : Wed Sep  6 12:28:54 2006
## Last Machine Used: glaurung.internal.golden-gryphon.com
## Update Count     : 6
## Status           : Unknown, Use with caution!
## HISTORY          : 
## Description      : 
## 
## arch-tag: b07b1015-30ba-4b46-915f-78c776a808f4
## 
###############################################################################

testdir:
	$(testdir)

debian/stamp/INST/angband-doc: debian/stamp/install/angband-doc
debian/stamp/BIN/angband-doc:  debian/stamp/binary/angband-doc

CLEAN/angband-doc::
	-rm -rf $(TMPTOP)


debian/stamp/install/angband-doc:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	rm -rf               $(TMPTOP)
	$(make_directory)    $(GAMEDIR)
	$(make_directory)    $(DOCDIR)
	$(make_directory)    $(DOCBASEDIR)
	$(make_directory)    $(LINTIANDIR)
	echo '$(package): description-synopsis-might-not-be-phrased-properly'>> \
                              $(LINTIANDIR)/$(package)
	$(install_file)      debian/changelog     $(DOCDIR)/
	$(install_file)      debian/README.debian $(DOCDIR)/
	gzip -9fqr           $(DOCDIR)
	$(MAKE)              $(INT_INSTALL_TARGET) prefix=$(TMPTOP) \
		       	           infodir=$(INFODIR)    mandir=$(MANDIR)
	$(install_file)      debian/copyright     $(DOCDIR)/copyright
	$(install_file)      debian/docentry      $(DOCBASEDIR)/$(package)
	$(install_file)      debian/docfaq1       $(DOCBASEDIR)/$(package)_faq1
	$(install_file)      debian/docfaq2       $(DOCBASEDIR)/$(package)_faq2
	@test -d debian/stamp/install || mkdir -p debian/stamp/install
	@echo done > $@

debian/stamp/binary/angband-doc:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	$(make_directory)    $(TMPTOP)/DEBIAN
	$(install_script)    debian/postinst        $(TMPTOP)/DEBIAN/postinst
	$(install_script)    debian/prerm           $(TMPTOP)/DEBIAN/prerm
	dpkg-gencontrol      -p$(package) -isp      -P$(TMPTOP)
	$(create_md5sum)     $(TMPTOP)
	chown -R root        $(TMPTOP)
	chmod -R u+w,go=rX   $(TMPTOP)
	dpkg --build         $(TMPTOP) ..
	@test -d debian/stamp/binary || mkdir -p debian/stamp/binary
	@echo done > $@
