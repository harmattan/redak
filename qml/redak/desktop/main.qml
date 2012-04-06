/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import QtDesktop 0.1

//import Redak 1.0
import "../common/script.js" as Script
import "../common"
import "./"


ApplicationWindow {

    id: appWindow

    //initialPage: editPage
    property alias content: editPage.content
    property alias folderPath: editPage.folderPath
    property variant filePath: '' ( null != parentFilePath ) ? parentFilePath : "default.txt";
    signal filenameSelected(string filename)
    property int mode: 0 //0=load 1=save
    property variant core: ( null != parentCore ) ? parentCore : redak;
    signal quit();
    signal test();

    property int pageMargin: 16

    Component.onCompleted: {
        Script.log("onCompleted:" + filePath );
        if ( null != filePath ) { filenameSelected( filePath ); }
        // theme.inverted = true
    }

    onFilenameSelected: {
        Script.log("onFilenameSelected:" + filename );
        var res = true;
        if ( (null != filename) && ( "" != filename ) ) {
            content = redak.load( filename );
            filePath = filename;
        }
    }

    //    onContentChanged: {
    //        Script.log("#{ onContentChanged: " + arg );
    //	handleContent( arg);
    //    }

    function handleContent(text) {
        Script.log("#{ handleContent " + text );
        this.content = text;
    }


    function browse(mode)
    {
        Script.log("browse:" + content );
        appWindow.mode = mode;
        var browserPage = Qt.resolvedUrl("BrowsePage.qml");
        browserPage.parent = pageStack.parent;
        folderPath = ( null != folderPath ) ? folderPath : "/";

        pageStack.push
                ( browserPage ,
                 { content: content , folderPath: folderPath} )
    }


    function handleQuit()
    {
        Script.log("#{ handleQuit");
        if ( null != core ) { content = core.quit(); }
        else { Qt.quit(); }
    }


    function handleTest()
    {
        //test();
        content = "test";
        if ( null != core ) { content = core.process("ls"); }
    }


    // QueryDialog {
    //     id: error
    //     titleText: "Error"
    //     acceptButtonText: "Close"
    //     message: "error"
    //     // "Popup count: " + platformPopupManager.popupStackDepth
    // }

    //Connections {
    //        target:redak
    //        onError: {
    //            error.message = text + "\n";
    //            // console.debug("onError:" +  error.message );
    //            error.open();
    //        }
    //    }

    EditPage {
        id: editPage
        // anchors.fill: parent
        //tools: commonTools
        height: parent.height - commonTools.height
        width: parent.width

        Tools{
            id: commonTools
            visible: true
            Connections {
                //             target: parent
                //	   onTest: {
                //	   test();
                //	  }
            }

        }
    }

    MainMenu {id:myMenu}


    //    Connections {
    //        target: browserPage
    //        onFileSelected: {
    //            console.log("main:onFileSelected: " + path );
    //            //Script.handlePath( filename ); //TODO
    //        }
    //    }
}
