/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.meego 1.0
import Redak 1.1
import "../common/script.js" as Script
import "../common"
import "./"


Menu {
    id: myMenu
    visualParent: pageStack

    MenuLayout {

        MenuItem {
            text: qsTr("Load")
            onClicked: {
                browse(0);
            }
        }

        MenuItem {
            text: qsTr("Save")
            onClicked: {
                redak.save( editPage.content , filePath );
            }
        }

        MenuItem {
            text: qsTr("Save As")
            onClicked: {
                browse(1);
            }
        }

        MenuItem {
            text: qsTr("About")
            onClicked: {
                aboutDialog.open();
                if  ( ( null == content ) || ("" == content ) ) { content = Script.g_info; }
            }
        }

        //            MenuItem {
        //                text: qsTr("Exec")
        //                onClicked: {
        //                    var content = editPage.content;
        //                    var content = redak.process( content );
        //                    editPage.setContents( content );
        //                }
        //            }

        MenuItem {
            text: qsTr("Quit")
            onClicked: {
                quitDialog.open();
            }
        }

    }
}
