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
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
            platformIconId: "toolbar-view-menu"
           //text: "menu"
            //iconId: "toolbar-view-menu"
		}

        ToolIcon
        {
            onClicked: { Qt.quit(); }
            anchors.left: (parent === undefined) ? undefined : parent.left
            platformIconId: "toolbar-close";
            //text: "quit"
        }

    }
}
