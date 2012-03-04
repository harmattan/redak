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

ToolBar {
    anchors.bottom: parent.bottom
    tools:
        ToolBarLayout {

        ToolIcon
        {
            // text: "quit"
            onClicked: { Qt.quit(); }
            platformIconId: "toolbar-close";
        }

        ToolIcon
        {
            // text: "view"
            platformIconId: ( mainPage.isEdit ) ? "toolbar-search" : "toolbar-search-selected";
            onClicked: { mainPage.toggleEdit(); }
        }

        ToolIcon
        {
            // text: "menu"
            platformIconId: "toolbar-view-menu"
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }

    }
}
