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
        //ToolIcon
        ToolButton
        {
            text: "menu"
            //iconSource: "option"
            //platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }

        ToolButton
        {
            text: "quit"
            onClicked: { Qt.quit(); }
            anchors.left: (parent === undefined) ? undefined : parent.left
        }
    }
}
