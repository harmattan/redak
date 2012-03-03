#! /usr/bin/make -f
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
	rm -rvf *.user *.zip *.sis *~
	find . -iname "*~" -exec rm -v '{}' \;


dist: distclean COPYING release rule/local/release



meld: qml/${package}/harmattan qml/${package}/symbian
	$@ $^


COPYING: /usr/share/common-licenses/GPL-3
	cp -a $< $@


debian/diff: debian qtc_packaging/debian_harmattan
	meld $^


diff: qml/${package}/harmattan qml/${package}/symbian
	meld $^


install:
	-ls ../${package}*/*.sis
	-ls ../redak-build-remote/redak_qt-4_7_4_symbianBelle.sis
	ln -fs $(pwd)/../*/*.sis ~/public_html/pub/file/

#%: rule/local/%

release: rule/local/release

rule/local/%:
	echo "todo: $@"

-include ~/bin/mk-local.mk
