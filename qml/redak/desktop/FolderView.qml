/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import Qt.labs.folderlistmodel 1.0
import Qt.labs.components.native 1.0
import QtDesktop 0.1

import Redak 1.0
import "../common/script.js" as Script
import "../common"
import "./"

ListView {
    id: folderView
    anchors.fill: parent
    clip: true
    //anchors.top: browserView.top
    //anchors.left: parent.left; anchors.right: parent.right

    FolderListModel {
        id: folderModel
        nameFilters: ["*"]
        showDirs: true
        //showDotAndDotDot: true
        //sortField: "Name"
    }
    Component {
        id: fileDelegate
        Rectangle {
            width: parent.width
            height: fileNameView.height * 1.5
            //color: "gray"
            border.color: "black"
            border.width: 5
            radius: 10
            //anchors.fill: parent

            Text {
                id: fileNameView
                text: fileName
                font.pixelSize: Script.g_font_pixelSize
                anchors.verticalCenter: parent.verticalCenter
                x: Script.g_font_pixelSize

            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    color: platformStyle.colorNormal
                }

                onClicked: {
                    //fileNameView.color="red";
                    if ( folderModel.isFolder(index) ) {
                        folderModel.folder = filePath;
                    } else {
                        Script.load( filePath );
                    }
                    color: platformStyle.colorNormalLight
                }
            }
        }
    }

    model: folderModel

    delegate: fileDelegate

}
