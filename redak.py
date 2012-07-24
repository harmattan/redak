#! /usr/bin/env python
# #ident "$Id: $"
# @author: rzr@gna.org - rev: $Author: rzr$
# Copyright: See README file that comes with this distribution
################################################################################
# -*- encoding: iso-8859-15 -*-

import sys
import PySide

from PySide import QtCore
from PySide.QtCore import QObject, QUrl, QProcess
from PySide.QtGui import QApplication
from PySide.QtDeclarative import QDeclarativeView,QDeclarativeEngine

from PySide.QtCore import Signal as pyqtSignal
from PySide.QtCore import Slot as pyqtSlot


__package__ = 'redak'
__author__ = 'Philippe Coval (RzR)'
__email__ = 'rzr@gna.org'
__version__ = '0.0.0'


class Redak(QDeclarativeView):

    contentChanged = pyqtSignal(str)


    def __init__(self, parent=None):
	platform = 'common'
	platform = 'desktop'
        src = 'qml/redak/' + platform + '/main.qml'
        super(Redak, self).__init__(parent)
        self.setWindowTitle(__package__)
        self.setSource(QUrl.fromLocalFile(src))
        self.setResizeMode(QDeclarativeView.SizeRootObjectToView)
        self.setGeometry(200, 200, 400, 400)
#       self.showFullScreen()
        root = self.rootObject()
        root.quit.connect( self.quit )
        root.test.connect( self.test )
        self.rootContext().setContextProperty("parentCore", self);
        print "http://bugs.pyside.org/show_bug.cgi?id=1000"
#       self.contentChanged.connect( self.slotContent );
#       self.contentChanged.connect( root.onContentChanged );
#       self.contentChanged.connect( root.handleContent );


    def quit(self):
#       print "quitting"
        self.rootContext().setContextProperty("parentCore", None );
        PySide.QtCore.QCoreApplication.quit()


    def test(self):
#       print "Testing emit"
        content = "content"
        print "Content: " + content
        self.contentChanged.emit( content )
        return content;


    @QtCore.Slot(unicode,result=unicode)
    def process(self,command):
#       print "process"
        content = "content"
        process = QProcess()
        process.start(command)
        process.closeWriteChannel()
        process.waitForFinished()
#       process.closeWriteChannel()
        content = process.readAllStandardOutput()
        print "Content: " + content
        return unicode(content);


    @QtCore.Slot(unicode,result=unicode)
    def load(self,command):
        return "todo"


    @QtCore.Slot(unicode,unicode,result=bool)
    def save(self,content,filename):
        return false


    @QtCore.Slot(str)
    def slotContent(self,content):
        print "#{ slotContent"
        root = self.rootObject()
        root.handleContent(content)
        print content


    @staticmethod
    def main(argv):
        if len(argv) > 1:
            print PySide.QtCore.qVersion()
        app = QApplication(argv)
        view = Redak()
        view.show()
        sys.exit(app.exec_())


if __name__ == "__main__":
    Redak.main(sys.argv)


#eof
