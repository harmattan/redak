/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.meego 1.0
import Redak 1.0
import "../common/script.js" as Script


PageStackWindow {

    id: appWindow

    initialPage: editPage
    property alias content: editPage.content
    property alias folderPath: editPage.folderPath
    property variant filePath: ( null != parentFilePath ) ? parentFilePath : "default.txt";
    signal filenameSelected(string filename)
    property int mode: 0 //0=load 1=save

    Component.onCompleted: {
        Script.log("onCompleted:" + filePath );
        if ( null != filePath ) { filenameSelected( filePath ); }
        // theme.inverted = true
    }

    onFilenameSelected: {
        Script.log("onFilenameSelected:" + filename );
        var res = true;
        //Script.log("onFilenameSelected:" + filename );
        if ( (null != filename) && ( "" != filename ) ) {
            content = redak.load( filename );
            filePath = filename;
        }
    }

    function browse(mode)
    {
        Script.log("browse:" + content );
        appWindow.mode = mode;
        //var browsePage = Qt.resolvedUrl("BrowsePage.qml");
        folderPath = ( null != folderPath ) ? folderPath : "/";

        pageStack.push
                ( browsePage ,
                 { content: content , folderPath: folderPath} )
    }


    Redak {
        id: redak
    }

    QueryDialog {
        id: error
        titleText: "Error"
        acceptButtonText: "Close"
        message: "error"
        // "Popup count: " + platformPopupManager.popupStackDepth
    }

    Connections {
        target:redak
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

    BrowsePage {
        id: browsePage;
        parent: pageStack /*.parent */;

        onFileSelected: {
            Script.log("onFileSelected " + mode  + editPage.isChanged );
            filePath = path;
            if ( 0 == mode ) {
                if ( editPage.isChanged ) {
                    ioDialog.open();
                } else {
                    Script.handlePath( filePath );
                }
            } else {
                ioDialog.open();
            }

        }

        onFolderChanged: {
            Script.handleFolderChanged(path); //TODO: path param on pop
        }
    }

    QueryDialog {
        id: aboutDialog
        titleText: "About Redak"
        message: Script.g_info
        rejectButtonText: "Back"
    }

    QueryDialog {
        id: quitDialog
        titleText: "Quit: Are you sure ?"
        message: "please Confirm"
        acceptButtonText: "Yes"
        rejectButtonText: "No"
        onAccepted: {
            Qt.quit();
        }
    }

    QueryDialog {
        id: ioDialog
        titleText: "Io: Are you sure ?"
        message: "please Confirm"
        acceptButtonText: "Yes"
        rejectButtonText: "No"
        onAccepted: {
            Script.handlePath( filePath ); //TODO: use signal
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
                    redak.save( editPage.content , filePath );
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
                    aboutDialog.open();
                    if  ( ( null == content ) || ("" == content ) ) { content = Script.g_info; }
                }
            }

            MenuItem {
                text: qsTr("Exec")
                onClicked: {
                    var content = editPage.content;
                    var content = redak.process( content );
                    editPage.setContents( content );
                }
            }

            MenuItem {
                text: qsTr("Quit")
                onClicked: {
                    quitDialog.open();
                }
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
