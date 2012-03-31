/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
//import Core 1.0
import "../common/script.js" as Script
import "../common"
import "./"

Rectangle {
    anchors.bottom: parent.bottom
    //tools:
    Rectangle {

       Image {
            // text: "quit"
//            platformIconId: "toolbar-close"
            MouseArea{ onClicked: { Qt.quit(); } }
        }

        Image
        {
            // text: "view"
  //          platformIconId: ( editPage.isEdit ) ? "toolbar-search" : "toolbar-search-selected";
            MouseArea{ onClicked: { editPage.toggleEdit(); } }
        }

        Image
        {
            // text: "menu"
//            platformIconId: "toolbar-view-menu"
            MouseArea { onClicked: (DialogStatus.Closed == myMenu.status) ? myMenu.open() : myMenu.close(); }
        }

    }
}
