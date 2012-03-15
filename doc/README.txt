{{Note|This is an entry in the [[Symbian Qt Quick Components Competition 2012Q1]]}}

{{note|This page is unfinished, I will finish it before 17 March, 2012. if you are interested, add your e-mail here, please}}

{{ArticleMetaData <!-- v1.1 -->
|sourcecode= <!-- Link to example source code e.g. [[Media:The Code Example ZIP.zip]] -->
|installfile= <!-- Link to installation file (e.g. [[Media:The Installation File.sis]]) -->
|devices= Nokia E7,
|platform=Meego Harmattan, Symbian Belle, Qt 4.7.4
|devicecompatability= <!-- Compatible devices e.g.: All* (must have internal GPS) -->
|dependencies= Qt Quick Components 1.1
|signing=<!-- Signing requirements - empty or one of: Self-Signed, DevCert, Manufacturer -->
|capabilities= <!-- Capabilities required by the article/code example (e.g. Location, NetworkServices. -->
|keywords= Redak, Text.Editor
|id= <!-- Article Id (Knowledge base articles only) -->
|language= <!-- Language category code for non-English topics - e.g. Lang-Chinese -->
|translated-by= <!-- [[User:XXXX]] -->
|translated-from-title= <!-- Title only -->
|translated-from-id= <!-- Id of translated revision -->
|review-by=<!-- After re-review: [[User:username]] -->
|review-timestamp= <!-- After re-review: YYYYMMDD -->
|update-by= <!-- After significant update: [[User:username]]-->
|update-timestamp= <!-- After significant update: YYYYMMDD -->
|creationdate= 20120207  <!-- Format YYYYMMDD -->
|author= [[User:www.rzr.online.fr]]
}}

  Package: redak
  URL:  http://rzr.online.fr/q/redak
  Contact: Philippe Coval <rzr@gna.org>
  Licence: GPL-3 (OpenSource Free Libre Software)


Redak is just a simple text editor to be used on touchscreen. Basic features are Load, Save, Save As, Browse and Edit text. It has been tested on maemo/meego harmattan n950 and n9 ...


== Introduction ==

History of this project :

I needed a basic text editor to handle files on my handset ...
So I created once a Qt texteditor under the name redaktilo
as sample to teach Qt on desktop or tablets (n810) ...
using QtGui was usable with a resistive screen (n810)
but not on capacitives screens so I deciced to create it
again from scratch using QtQuick...

Today supported platform are symbian and meego harmattan.

Basic features are ready to be tested :
* Load, Save, Save As, Browse and Edit text (select, cut and paste).

Features are very limited but enough for me ?

I can't promise I will polish it and add more features but it's opensource
so I can promise i will make efforts to merge patches ?

The project is mostly based on QmL and uses C++/Qt for io.(load/save)...


== Components==

IO access is done in C++ , the rest UI logic etc is pure qml Javascript


Used ones (symbian or meego) :

* PageStackWindow Page QueryDialog
* Menu MenuLayout MenuItem ToolBar ToolBarLayout ToolButton
* Flickable  Column ListView FolderListModel Component   MouseArea
* TextArea TextField Text
* Image Rectangle
* Connections

Since the project is opensource you can tear out and reuse my components :


Custom ones to be reused :

* EditPage : the text area
* BrowserPage : the file browser for loading saving pages


== Problem Areas ==

First I created for harmattan then ported to Symbian, the main issue was a minor bug in C++ that prevent loading files (bad path workaround). I feared that was a security issue but it's not ...

Most of the qml code is common between MeeGo and Symbian. But I did not share common parts and I prefer to merge new features ...

I had to find also common images to reuse platform ones ...

* QueryDialog : Had to workaround this bug (using an extra '\n')
https://bugreports.qt-project.org/browse/QTCOMPONENTS-1090


== Future ==

I wish I had a n900 to port it to maemo5 too or a RasperyPI to edit text on TV ...

I'll also plan to use it to test Qt lighthouse ports


== Download ==

https://projects.developer.nokia.com/redak/files

ScreenShot: https://projects.developer.nokia.com/redak/files/screenshot.png

Icon: https://projects.developer.nokia.com/redak/projecticon?environment_name=redak

I plan to publish to ovi stable version ...
but feel free to build form sources too...


== MORE ==

* http://stackoverflow.com/questions/8696448/emit-signals-from-javascript-to-qml
* http://www.developer.nokia.com/Community/Discussion/showthread.php?173714-how-to-create-XB-Maemo-Icon-26
* http://wiki.maemo.org/Packaging_a_Qt_application#Finding_your_package_in_debian
* http://kunalmaemo.blogspot.com/2011/04/signal-slot-connection-with-qml-and-qt.html
* http://doc.qt.nokia.com/4.7-snapshot/qml-variant.html
* http://harmattan-dev.nokia.com/docs/library/html/qt-components/qt-components-meego-dialog.html
* http://www.developer.nokia.com/Community/Wiki/Special:WhatLinksHere/Redak
