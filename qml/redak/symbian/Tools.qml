/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.symbian 1.1
import Redak 1.1
import "../common/script.js" as Script


ToolBar {
    anchors.bottom: parent.bottom
    tools:
        ToolBarLayout {

        ToolButton {
            // text: "quit"
            iconSource: "toolbar-home"
            onClicked: { quitDialog.open(); }
        }

        //        ToolButton
        //        {
        //            // text: "view"
        //            iconSource: ( editPage.isEdit ) ? "toolbar-search"
        //                                            : "toolbar-search"; //TODO

        //                                            // : "toolbar-search-selected";
        //            onClicked: {
        //        //console.log( iconSource );
        //            editPage.toggleEdit(); }
        //        }


        ToolButton {
            // text: "menu"
            iconSource: "toolbar-menu"
            onClicked: (DialogStatus.Closed == myMenu.status) ? myMenu.open() : myMenu.close()
        }

    }
}
