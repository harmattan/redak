/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.meego 1.0
import Redak 1.1
import "../common/script.js" as Script


PageStackWindow {

    id: appWindow

    initialPage: editPage
    property alias content: editPage.content
    property alias folderPath: browsePage.folderPath
    property variant filePath: ( null != parentFilePath ) ? parentFilePath : "default.txt";
    signal filenameSelected(string filename)
    property int mode: 0 //0=load 1=save
    showStatusBar: false;

    Component.onCompleted: {
        Script.log("onCompleted:" + filePath );
        if ( null != filePath ) { filenameSelected( filePath ); }
        folderPath = ( null != folderPath ) ? folderPath : "file:///";
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
        Script.log("#{ browse: " + folderPath );
        appWindow.mode = mode;
        folderPath = ( null != folderPath || "" == folderPath ) ? folderPath : "file:///";

        pageStack.push
                ( browsePage ,
                 { content: content , folderPath: folderPath} );

        Script.log("#} browse: " + folderPath );
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
        message: "Please Confirm"
        acceptButtonText: "Yes"
        rejectButtonText: "No"
        onAccepted: {
            Qt.quit();
        }
    }

    QueryDialog {
        id: ioDialog
        titleText: "IO: Are you sure ?"
        message: "Please Confirm"
        acceptButtonText: "Yes"
        rejectButtonText: "No"
        onAccepted: {
            Script.handlePath( filePath ); //TODO: use signal
        }
    }

    MainMenu
    {
        id: myMenu
        visualParent: pageStack //TODO vs appWindow
    }


    //    Connections {
    //        target: browserPage
    //        onFileSelected: {
    //            console.log("main:onFileSelected: " + path );
    //            //Script.handlePath( filename ); //TODO
    //        }
    //    }
}
