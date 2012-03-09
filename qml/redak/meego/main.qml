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

    initialPage: editPage
    property alias content: editPage.content
    property alias folderPath: editPage.folderPath
    // property variant filePath: ( null != filePath ) ? filePath : "default.txt";
    signal filenameSelected(string filename)

    Component.onCompleted: {
        // console.log("onCompleted:" + filePath );
        if ( null != filePath ) { filenameSelected( filePath ); }
        // theme.inverted = true
    }

    onFilenameSelected: {
        var res = true;
        //Script.log("onFilenameSelected:" + filename );
        if ( (null != filename) && ( "" != filename ) ) {
            content = core.load( filename );
        }
    }

    function browse(mode)
    {
        // console.debug("loading:" + content );
        var browserPage = Qt.resolvedUrl("BrowserPage.qml");
        browserPage.parent = pageStack.parent;
        folderPath = ( null != folderPath ) ? folderPath : "/";
        pageStack.push
( browserPage , 
 { content: content , mode: mode , folderPath: folderPath} )
    }


    Core {
        id: core
    }

    QueryDialog {
        id: error
        titleText: "Error"
        acceptButtonText: "Close"
        message: "error"
        // "Popup count: " + platformPopupManager.popupStackDepth
    }

    Connections {
        target:core
        onError: {
            error.message = text + "\n";
            // console.debug("onError:" +  error.message );
            error.open();
        }
    }

    EditPage {
        id: editPage
        // anchors.fill: parent
        tools: commonTools
        // height: parent.height - commonTools.height

        Tools{
            id: commonTools
            visible: true
        }
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
                    core.save( editPage.content , filename );
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

    //    Connections {
    //        target: browserPage
    //        onFileSelected: {
    //            console.log("main:onFileSelected: " + path );
    //            //Script.handlePath( filename ); //TODO
    //        }
    //    }
}
