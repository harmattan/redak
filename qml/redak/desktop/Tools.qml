/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import QtDesktop 0.1
import "../common/script.js" as Script
import "../common"
import "./"


ToolBar {
    anchors.top: parent.bottom
    width: parent.width
    height: menu.height

    //tools:
    Row {
        spacing: 2

        id: row

        ToolButton {
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

        ToolButton
        {
            id: view
            text: "view"
            //        platformIconId: ( editPage.isEdit ) ? "toolbar-search" : "toolbar-search-selected";
            MouseArea{
                width: parent.width
                height: parent.width

                onClicked: { editPage.toggleEdit(); } }
        }

        ToolButton
        {
            id: test
            text: "test"
            MouseArea{
                width: parent.width
                height: parent.width
                onClicked: { handleTest(); }
            }
        }

        ToolButton
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
