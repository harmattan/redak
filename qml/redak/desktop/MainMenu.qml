/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import QtDesktop 0.1
//import Qt.labs.components.native 1.0

import "../common/script.js" as Script
import "../common"
import "./"


ContextMenu {
    id: myMenu
    visible: false
    //        visualParent: pageStack


    function open()
    {
        myMenu.visible=true;
    }

    function close()
    {
        this.visible=false;
    }

    function toggle()
    {
        this.visible=!this.visible;
    }

    onSelectedIndexChanged:{
        console.log(".");
    }

    //Row {

    MenuItem {
        text: qsTr("Load")

//        onClicked: {
//            browse(0);
  //      }
    }


    MenuItem {
        text: qsTr("Save")

//        MouseArea {
//            width: parent.width
//            height: parent.width

//            onClicked: {
//                redak.save( editPage.content , filePath );
//            }
//        }
    }


    MenuItem {
        text: qsTr("Save As")
        //            MouseArea {
        //                width: parent.width
        //                height: parent.width
        //                onClicked: {
        //                    browse(1);
        //                }
        //            }
    }

    MenuItem {
        text: qsTr("About")
        //            MouseArea {
        //                width: parent.width
        //                height: parent.width
        //                onClicked: {
        //                    //myDialog.visible = true;
        //                    //myDialog.focus = true;
        //                    content = Script.g_info;
        //                }
        //            }
    }

    MenuItem {
        text: qsTr("Quit")
        //            MouseArea {
  //                   width: parent.width
    //                 height: parent.width
    //      onClicked: { Script.log("handleQuit"); }
                //    }
                //}
    }
}

