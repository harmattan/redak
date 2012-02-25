import QtQuick 1.1
import Qt.labs.folderlistmodel 1.0
//import com.nokia.meego 1.0
import com.nokia.symbian 1.1
import Core 1.0
import "../common/script.js" as Script
import "../common"
//import "./"

Page {
    anchors.fill: parent
    tools: commonTools

    signal loaded()
    onLoaded: {
        Script.handleLoaded()
    }

    TextEdit{
        text: "path"
    }

    // FolderView {
    //     id: folderView
    //}
    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        //anchors.top: browserView.top
        //anchors.left: parent.left; anchors.right: parent.right


        FolderListModel {
            id: folderModel
            nameFilters: ["*"]
            showDirs: true
            showDotAndDotDot: true
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


}
