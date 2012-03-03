/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.symbian 1.1
import Core 1.0
import "../common/script.js" as Script
import "../common"
import "./"

ToolBar {
    anchors.bottom: parent.bottom
    tools:
        ToolBarLayout {

        ToolButton
        {
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
            text: "menu"
//            iconSource: "option"
        }

        ToolButton
        {
            onClicked: { Qt.quit(); }
            anchors.left: (parent === undefined) ? undefined : parent.left
            text: "quit"
 //           iconSource: "close"
        }
    }
}
