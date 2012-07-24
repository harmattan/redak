/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import "../common/script.js" as Script
//import "../common"
//import "./"


Rectangle {
    anchors.bottom: parent.bottom
    width: parent.width
    height: menu.height

    //tools:
    Row {
        spacing: 2

        id: row

        Text {
            id: quit
            text: "quit"
            //          platformIconId: "toolbar-close"
            MouseArea{
                width: parent.width
                height: parent.width
                onClicked: {
                    handleQuit();
                    // Qt.quit();
                }
            }
        }

        Text
        {
            id: view
            text: "view"
            //        platformIconId: ( editPage.isEdit ) ? "toolbar-search" : "toolbar-search-selected";
            MouseArea{
                width: parent.width
                height: parent.width

                onClicked: { editPage.toggleEdit(); } }
        }

        Text
        {
            id: test
            text: "test"
            MouseArea{
                width: parent.width
                height: parent.width
                onClicked: { handleTest(); }
            }
        }

        Text
        {
            id: menu
            text: "menu"
            //          platformIconId: "toolbar-view-menu"
            MouseArea {
                width: parent.width
                height: parent.width

                onClicked: myMenu.toggle();
                //(DialogStatus.Closed == myMenu.status) ? myMenu.open() : myMenu.close();
            }
        }

    }
}
