#! /usr/bin/qmake .
#* #ident "$Id: $"
#* @author: rzr@gna.org - rev: $Author: rzr$
#* Copyright: See README file that comes with this distribution
#*****************************************************************************/

# Add more folders to ship with the application, here
qmlfiles.source = qml/redak
qmlfiles.target = qml

DEPLOYMENTFOLDERS = qmlfiles

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =


symbian {
# default version for selfsigned binaries :
# symbian:TARGET.UID3 = 0xE65F5F5E

symbian:TARGET.UID3 = 0x20062277

#symbian:VER_MAJ=0
#symbian:VER_MIN=0
#symbian:VER_PAT=0
symbian:VERSION=0.5.1

PRIVATEDIR=$$replace(TARGET.UID3, "^0x", "")
my_deployment.pkg_prerules += vendorinfo
DEPLOYMENT += my_deployment
vendorinfo += "%{\"rzr\"}" ":\"rzr\""


# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

#symbian:TARGET.CAPABILITY += AllFiles
#symbian:TARGET.CAPABILITY += WriteUserData ReadUserData
}


# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable
CONFIG += qt-components
CONFIG += plugin

# Add dependency to Symbian components
# CONFIG += qt-components

greaterThan(QT_MAJOR_VERSION, 4) {
       QT += widgets
       QT += quick1
} else {
       QT += declarative
}


#TEMPLATE = lib

INCLUDEPATH += /usr/include/applauncherd



# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    redak.cpp \
    config.cpp

HEADERS += \
    redak.h \
    config.h

#maemo5 {
contains(MEEGO_EDITION,harmattan) {

qmlfiles.source = qml/redak/common qml/redak/meego
qmlfiles.target = qml

OTHER_FILES += \
    README.txt \
    TODO.txt \
    mk-local.mk \
    debian/ \
    debian/control \
    debian/changelog \
    debian/rules \
    debian/links \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qtc_packaging/debian_fremantle/rules \
    qtc_packaging/debian_fremantle/README \
    qtc_packaging/debian_fremantle/copyright \
    qtc_packaging/debian_fremantle/control \
    qtc_packaging/debian_fremantle/compat \
    qtc_packaging/debian_fremantle/changelog \
    redak64.png
}
#}


# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

#eof
