#! /usr/bin/make -f
#* #ident "$Id: $"
#* @author: rzr@gna.org - rev: $Author: rzr$
#* Copyright: See README file that comes with this distribution
#*****************************************************************************
default: help

package?=redak
#version?=0.0.0
version?=0.6.0


#TODO: upgrade with yours
#qtcreator?=/usr/local/opt/QtSDK/QtCreator/bin/qtcreator
qtcreator?=qtcreator


help:
	@echo "edit"


edit: clean
	${qtcreator} *.pro

rule/android/edit: clean
	/usr/local/opt/necessitas/QtCreator/bin/necessitas \
	*.pro

#TODO
rule/android/configure:
	/usr/local/opt/android-sdk-linux/tools/android  update project -t android-7 -p android

clean:
	rm -rf  ../redak-build-* *.o moc_*.cpp *~ Makefile
	-cat 'debian/clean' | while read t ; do rm -rv "$${t}" ; done


distclean: clean
	cat debian/clean.txt | while read t ; do rm -rfv "$${t}" ; done
	rm -rvf *.user *.zip *.sis *~ *.so *.tmp
	rm -rvf obj ./android/bin android/assets/qml/redak android/libs/armeabi
	find . -iname "*~" -exec rm -v '{}' \;
	find . -iname "*.class" -exec rm -v '{}' \;
	find . -iname "*.apk" -exec rm -v '{}' \;
	chmod a-rx *.cpp *.h *.pro *.png *.svg *.spec *.txt
	chmod a-rx COPYING
	chmod -Rv a+rX .
	rm -fv *.pkg
	rm -fv *.autosave


dist: distclean COPYING release rule/local/release


rule/diff/common: qml/${package}/meego qml/${package}/common
	meld $^


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

deploy:
	find ${CURDIR}-build-remote/ -type f -iname "*.sis" \
	| while read t ; do ln -fs $${t} ~/public_html/pub/file/ ; done

all:
	qmake-qt4
	make CXXFLAGS=-fPIC


run: qml/${package}/common/main.qml all
	qmlviewer -maximized -P ${CURDIR}/ $<


run/py: ${package}.py
	${<D}/${<F}


test:distclean all run clean


debuild:distclean
	fakeroot ./debian/rules binary
	dpkg --contents ../*.deb

dep/desktop:
	${sudo} apt-get install \
	  libqt4-declarative-folderlistmodel libqt4-dev

dep/harmattan:
	${sudo} apt-get install \
	  applauncherd-dev pkg-config make

#%: rule/local/%


release: distclean rule/local/release

rule/version:
#	echo '${version}' | tee -a VERSION.txt
	sed -e "s/^var g_version.*/var g_version = \"${version}\" ;/g" -i 'qml/redak/common/script.js'
	sed -e "s/^[ ]*VERSION.*/VERSION=${version}/g" -i redak.pro
	sed -e "s/^Version:.*/Version: ${version}/g" -i redak.spec
	echo "# TODO: check debian/changelog *.changes *.pkg"


check/release:
	@echo "# check version in script.js debian/changelog "
	grep -r -i 'g_version' qml/redak/common/script.js
	grep 'Version:' ${package}.spec


rule/local/%:
	echo "todo: $@"


redak64.png: redak.svg  mk-local.mk
	convert -resize 64x64  $< $@

convert/%: redak.svg  mk-local.mk
	convert -resize ${@F}x${@F}  $< tmp-${@F}.png


icon.txt.tmp: redak.svg  mk-local.mk
	convert -resize 26x26  $< tmp.png
	base64 < tmp.png | tr -d '\n' > $@
	wc $@
	rm -f tmp.png


rule/platform/symbian:
	md5sum *.sis >> README.txt 


-include ~/bin/mk-local.mk
