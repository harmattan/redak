import QtQuick 1.1
import com.nokia.symbian 1.1
import Core 1.0
import "../common/script.js" as Script
import "../common"
import "./"


PageStackWindow {
    id: appWindow

    initialPage: mainPage

    Core {
        id: core
    }

    MainPage {
        id: mainPage
        visible: true
        //    anchors.fill: parent
        tools: commonTools
        //height: parent.height - commonTools.height
    }

    // http://www.developer.nokia.com/Community/Discussion/showthread.php?229427-How-to-hide-virtual-keyboard-in-Meego
    // http://nokiamobileblog.com/nokia-n9-tips-tricks/
    Rectangle {
        visible: false
        Text {
            id: currentFileNameView
            text: qsTr("redak")
        }

        color: "red"
        width: parent.width
        height: currentFileNameView.height + Script.g_font_pixelSize
    }

    Menu {
        id: myMenu
        visualParent: pageStack

        MenuLayout {

            MenuItem {
                text: qsTr("Load")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("BrowserPage.qml"))
                }
            }

            MenuItem {
                text: qsTr("Save")
                onClicked: {
                    //pageStack.push(Qt.resolvedUrl("BrowserPage.qml"))
                    core.save( mainPage.content , currentFileNameView.text);
                }
            }

            MenuItem {
                text: qsTr("http://rzr.online.fr/q/redak")
            }

            MenuItem {
                text: qsTr("Quit")
                onClicked: { Qt.quit(); }
            }
        }
    }

    Tools{
        id: commonTools
        visible: true
//        focus: true
    }

}
