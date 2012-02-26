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


    //Component.onCompleted: { theme.inverted = true }

    Core {
        id: core
    }

    MainPage {
        id: mainPage
        //    anchors.fill: parent
        tools: commonTools
        //height: parent.height - commonTools.height
    }

    Menu {
        id: myMenu
        visualParent: pageStack

        MenuLayout {

            MenuItem {
                text: qsTr("Load")
                onClicked: {
                    //console.debug("loading:" + content );
                    var component = Qt.resolvedUrl("BrowserPage.qml");
                    pageStack.push( component ,  { content: content , mode: 0 } )
                }
            }

            MenuItem {
                text: qsTr("Save")
                onClicked: {
                    core.save( mainPage.content , filename );
                }
            }

            MenuItem {
                text: qsTr("Save As")
                onClicked: {
                    var component = Qt.resolvedUrl("BrowserPage.qml");
                    component.parent = pageStack.parent
                    pageStack.push( component ,  { content: content , mode: 1 } )
                }
            }

            MenuItem {
                text: qsTr("Edit Toggle")
                onClicked: {
                    mainPage.editView.enabled =!mainPage.editView.enabled ;
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
