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
            //text: "menu"
            //iconId: "toolbar-view-menu"
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }

        ToolIcon
        {
            //text: "quit"
            platformIconId: "toolbar-close";
            onClicked: { Qt.quit(); }
            anchors.left: (parent === undefined) ? undefined : parent.left
        }

    }
}
