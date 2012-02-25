#! /usr/bin/make -f
package?=redak

qtcreator?=/usr/local/opt/QtSDK/QtCreator/bin/qtcreator

default: help

help:
	@echo "edit"


edit: clean
	${qtcreator} *.pro


clean:
	rm -rf  ../redak-build-* *.o moc_*.cpp *~ Makefile 


distclean: clean
	rm -rvf *.user *.zip *.sis
	find . -iname "*~" -exec rm -v '{}' \;


release: distclean
	~/bin/arc.sh -e debian_
	debuild -S


meld: qml/${package}/harmattan qml/${package}/symbian
	$@ $^
