/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.meego 1.0
import Redak 1.1
import "../common/script.js" as Script


ToolBar {
    anchors.bottom: parent.bottom
    tools:
        ToolBarLayout {

        ToolIcon {
            // text: "quit"
            // platformIconId: "toolbar-close" //TODO
            platformIconId: "toolbar-application"; //TODO  
            onClicked: { quitDialog.open(); }
        }

        ToolIcon
        {
            // text: "view"
            platformIconId: ( editPage.isEdit ) 
             ? "toolbar-edit" : "toolbar-done"; //TODO
            // ? "toolbar-search" : "toolbar-search-selected"; //TODO
            onClicked: { editPage.toggleEdit(); }
        }

        ToolIcon {
            // text: "menu"
            platformIconId: "toolbar-view-menu"
            onClicked: (DialogStatus.Closed == myMenu.status) ? myMenu.open() : myMenu.close()
        }

    }
}
