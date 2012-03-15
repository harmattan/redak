#! /usr/bin/make -f
#* #ident "$Id: $"
#* @author: rzr@gna.org - rev: $Author: rzr$
#* Copyright: See README file that comes with this distribution
#*****************************************************************************
package?=redak

#TODO: upgrade with yours
qtcreator?=/usr/local/opt/QtSDK/QtCreator/bin/qtcreator

default: help

help:
	@echo "edit"


edit: clean
	${qtcreator} *.pro


clean:
	rm -rf  ../redak-build-* *.o moc_*.cpp *~ Makefile 


distclean: clean
	cat debian/clean.txt | while read t ; do rm -rfv "$${t}" ; done
	rm -rvf *.user *.zip *.sis *~
	find . -iname "*~" -exec rm -v '{}' \;


dist: distclean COPYING release rule/local/release



meld: qml/${package}/meego qml/${package}/symbian
	$@ $^


COPYING: /usr/share/common-licenses/GPL-3
	cp -a $< $@


debian/diff: debian qtc_packaging/debian_harmattan
	meld $^


diff: qml/${package}/meego qml/${package}/symbian
	meld $^


install:
	-ls ../${package}*/*.sis
	-ls ../redak-build-remote/redak_qt-4_7_4_symbianBelle.sis
	ln -fs $(pwd)/../*/*.sis ~/public_html/pub/file/


#%: rule/local/%


release: distclean rule/local/release


rule/local/%:
	echo "todo: $@"


redak64.png: redak.svg  mk-local.mk
	convert -resize 64x64  $< $@


icon.txt.tmp: redak.svg  mk-local.mk
	convert -resize 26x26  $< tmp.png
	base64 < tmp.png | tr -d '\n' > $@
	wc $@
	rm -f tmp.png


-include ~/bin/mk-local.mk
