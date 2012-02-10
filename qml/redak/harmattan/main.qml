import QtQuick 1.1
import com.nokia.meego 1.0
import Core 1.0
import "../common/script.js" as Script
import "../common"
import "./"


PageStackWindow {
    id: appWindow

    initialPage: mainPage
    property alias content: mainPage.content
    property string filename: "unknown.txt"

    Core {
        id: core
    }

    MainPage {
        id: mainPage
        //    anchors.fill: parent
        tools: commonTools
        //height: parent.height - commonTools.height
    }


    // http://www.developer.nokia.com/Community/Discussion/showthread.php?229427-How-to-hide-virtual-keyboard-in-Meego
    // http://nokiamobileblog.com/nokia-n9-tips-tricks/
//    Rectangle {
//        visible: false
//        Text {
//            id: currentFileNameView
//            text: qsTr("redak")
//        }

//        color: "red"
//        width: parent.width
//        height: currentFileNameView.height + Script.g_font_pixelSize
//    }

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

            MenuItem { // http://forum.meego.com/showthread.php?t=3800
                text: qsTr("SaveAs")
                onClicked: {
                    var component = Qt.resolvedUrl("SavePage.qml");
                    component.parent = pageStack.parent
                    //component.content = content;
                    pageStack.push( component ,  { content: content } )
                }
            }

            MenuItem { // http://forum.meego.com/showthread.php?t=3800
                text: qsTr("Select Toggle")
                onClicked: {
                    mainPage.editView.selectByMouse = !mainPage.editView.selectByMouse;
                }
            }

            MenuItem {
                text: qsTr("About")
                onClicked: {
                    //myDialog.visible = true;
                    //myDialog.focus = true;
                    content = mainPage.info;
                }
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
