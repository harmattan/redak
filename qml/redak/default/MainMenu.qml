/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import "../common/script.js" as Script
//import "../common"
//import "./"


Rectangle {
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

    Row {

        Text {
            text: qsTr("Load")
            MouseArea {
                width: parent.width
                height: parent.width

                onClicked: {
                    browse(0);
                }
            }
        }

        Text {
            text: qsTr("Save")
            MouseArea {
                width: parent.width
                height: parent.width

                onClicked: {
                    redak.save( editPage.content , filePath );
                }
            }
        }

        Text {
            text: qsTr("Save As")
            MouseArea {
                width: parent.width
                height: parent.width
                onClicked: {
                    browse(1);
                }
            }
        }

        Text {
            text: qsTr("About")
            MouseArea {
                width: parent.width
                height: parent.width
                onClicked: {
                    //myDialog.visible = true;
                    //myDialog.focus = true;
                    content = Script.g_info;
                }
            }
        }

        Text {
            text: qsTr("Quit")
            MouseArea {
                width: parent.width
                height: parent.width
                onClicked: { handleQuit(); }
            }
        }
    }
}
