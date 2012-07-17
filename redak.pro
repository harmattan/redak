#! /usr/bin/qmake .
#* #ident "$Id: $"
#* @author: rzr@gna.org - rev: $Author: rzr$
#* Copyright: See README file that comes with this distribution
#*****************************************************************************/

SOURCES += \
    main.cpp \
    redak.cpp \
    config.cpp

HEADERS += \
    redak.h \
    config.h


#VERSION = 0.0.0

# Additional import path used to resolve QML modules in Creators code model
QML_IMPORT_PATH =

TEMPLATE = app

#TEMPLATE = lib

INCLUDEPATH += /usr/include/applauncherd


# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

CONFIG += plugin

# Add dependency to Symbian components
CONFIG += qt-components
config += qt-components
#For older SDKs you may need:
#CONFIG += qtquickcomponents

greaterThan(QT_MAJOR_VERSION, 4) {
       QT += widgets
       QT += quick1
} else {
       QT += declarative
}


symbian {

  # default version for selfsigned binaries :
  #symbian:TARGET.UID3 = 0xE65F5F5E

  TARGET.UID3 += 0x20062277

  #symbian:VER_MAJ=0
  #symbian:VER_MIN=0
  #symbian:VER_PAT=0
  VERSION=0.5.2
  #VERSION=0.0.0


  PRIVATEDIR=$$replace(TARGET.UID3, "^0x", "")

  redak_installer.pkg_prerules += vendorinfo

  vendorinfo += "%{\"rzr\"}" ":\"rzr\""

  # http://qt-project.org/forums/viewthread/9302
  redak_installer.pkg_prerules += \
  "; Dependency to Symbian Qt Quick components" \
  "(0x200346DE), 1, 0, 0, {\"Qt Quick components\"}"

  # Smart Installer package's UID
  # This UID is from the protected range and therefore the package will
  # fail to install if self-signed. By default qmake uses the unprotected
  # range value if unprotected UID is defined for the application and
  # 0x2002CCCF value if protected UID is given to the application
  DEPLOYMENT.installer_header = 0x2002CCCF


  #symbian:TARGET.CAPABILITY += AllFiles
  #symbian:TARGET.CAPABILITY += WriteUserData ReadUserData NetworkServices

  # Add more folders to ship with the application, here
  qmlfiles.source = qml/redak/symbian qml/redak/common
  qmlfiles.target = qml

  DEPLOYMENT += redak_installer

  OTHER_FILES += redak.pkg


} else:android {


  OTHER_FILES += \
    android/res/values-zh-rCN/strings.xml \
    android/res/drawable/logo.png \
    android/res/drawable/icon.png \
    android/res/layout/splash.xml \
    android/res/values-fr/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/values-et/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/drawable-ldpi/icon.png \
    android/res/values-ms/strings.xml \
    android/res/values-de/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-nb/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-ru/strings.xml \
    android/res/values-el/strings.xml \
    android/res/values-rs/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values/libs.xml \
    android/res/values/strings.xml \
    android/res/values-es/strings.xml \
    android/res/values-nl/strings.xml \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/AndroidManifest.xml \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/origo/QtActivity.java \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/version.xml

} else:unix {

  !isEmpty(MEEGO_VERSION_MAJOR) {

    qmlfiles.source = qml/redak/common qml/redak/meego
    qmlfiles.target = qml

    contains(MEEGO_EDITION,harmattan) { #maemo6

      DEFINES += Q_WS_HARMATTAN=1 

      OTHER_FILES += \
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
  #
    } else { #meego/mer/nemo # rpm?

      OTHER_FILES += \
      redak.desktop

      INSTALLS+=desktop icon

      desktop.files = redak.desktop
      desktop.path = /usr/share/applications/

      icon.files = redak80.png
      icon.path = /usr/share/icons/hicolor/80x80/apps/

    }


  } else { # not meego

    qmlfiles.source = qml/redak
    qmlfiles.target = qml

    CONFIG += install_desktop

    install_desktop {
      desktop.files = redak.desktop
      desktop.path  = /usr/share/applications/
      INSTALLS += desktop
    }

  }

} else { #windows?

}


OTHER_FILES += \
    README.txt \
    TODO.txt \
    AUTHORS.txt \
    mk-local.mk \
    redak64.png



DEPLOYMENTFOLDERS+=qmlfiles

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

#eof
