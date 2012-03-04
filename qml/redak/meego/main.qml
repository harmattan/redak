/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
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

    function browse(mode)
    {
        //console.debug("loading:" + content );
        var component = Qt.resolvedUrl("BrowserPage.qml");
        component.parent = pageStack.parent
        pageStack.push( component ,  { content: content , mode: mode } )
    }


    Core {
        id: core
    }

    QueryDialog {
            id: error
            titleText: "Error"
            acceptButtonText: "Close"
            message: "error" // "Popup count: " + platformPopupManager.popupStackDepth
        }
    Connections {
            target:core
            onError: {
                console.debug(text);
                error.message = text;
                error.open();
            }
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
                    browse(0);
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
                    browse(1);
                }
            }

            MenuItem {
                text: qsTr("About")
                onClicked: {
                    //myDialog.visible = true;
                    //myDialog.focus = true;
                    content = Script.g_info;
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
    }

}
