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

        ToolIcon {
            // text: "quit"
            platformIconId: "toolbar-close"
            onClicked: { Qt.quit(); }
        }

        ToolIcon
        {
            // text: "view"
            platformIconId: ( editPage.isEdit ) ? "toolbar-search" : "toolbar-search-selected";
            onClicked: { editPage.toggleEdit(); }
        }

        ToolIcon
        {
            // text: "menu"
            platformIconId: "toolbar-view-menu"
            onClicked: (DialogStatus.Closed == myMenu.status) ? myMenu.open() : myMenu.close()
        }

    }
}
