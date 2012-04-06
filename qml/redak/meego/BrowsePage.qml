/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import Qt.labs.folderlistmodel 1.0
import com.nokia.meego 1.0
import "../common/script.js" as Script


Page {
    id: browserPage
    property variant content: content
    property variant filename: dir.text
    property alias folderPath: folderModel.folder;

    signal loaded()
    signal error(/*string message*/)
    signal fileSelected(string path);

    signal folderChanged(string path);

    onFolderChanged: {
        dir.text = path
        folderModel.folder = path ;
    }

    onFileSelected: {
        Script.log( path ); //TODO: use signal
    }

    anchors.fill: parent

    //Component.onCompleted: { theme.inverted = !true }

    //    Connections {
    //        target: browserPage
    //        onFileSelected: {
    //            Script.handlePath( filename );
    //        }
    //    }

    tools:
        ToolBarLayout {
        ToolIcon {
            //text: qsTr("back")
            iconId: "toolbar-back"
            onClicked: { pageStack.pop(); }
        }

        ToolIcon {
            // text: qsTr("..")
            iconId: "toolbar-backspace"
            //platformIconId: "toolbar-view-menu"

            onClicked: {
                folderChanged(folderModel.parentFolder);
            }
        }

        ToolIcon {
            // text: qsTr("..")
            iconId: "toolbar-search"
            //platformIconId: "toolbar-view-menu"

            onClicked: {
                fileSelected( dir.text );
            }
        }
    }

    //    onLoaded: {
    //        Script.handleLoaded()
    //    }
    //    onError: {
    //        console.log(message);
    //    }

    Column {
        id: mColumn
        width: parent.width
        height: parent.height
        //anchors.fill: parent

        //Row {
        TextField {
            id: dir
            text: ( null == folderModel.folder ) ? "./" : folderModel.folder
            width:parent.width;
            placeholderText: "Directory or File to load"
            focus: false;

            Keys.onReturnPressed: {
                fileSelected(filename);
            }

            onFocusChanged:  {
                var start = dir.text.length;
                dir.select( start , start);
                dir.focus = true;
            }

            // https://bugreports.qt-project.org/browse/QTBUG-16870
            onAccepted: {
                folderModel.folder = text;
            }
        }
        //}

        ListView {
            id: listView
            clip: true
            //anchors.top: path.bottom
            //anchors.bottom: parent.bottom
            //anchors.fill: parent
            height: parent.height - dir.height
            width: parent.width;

            FolderListModel {
                id: folderModel
                nameFilters: ["*"]
                showDirs: true
                showDotAndDotDot: false
                //sortField: "Name"
            }

            Component {
                id: fileDelegate

                Rectangle {
                    property int type

                    width: parent.width
                    height: fileNameView.height * 1.5
                    border.color: Script.g_color_border
                    border.width: 5
                    radius: 10
                    color: ( mouseArea.pressed )
                           ? Script.g_color_bg_pressed
                           : folderModel.isFolder(index)
                             ? "#E0D0D0" : "#D0E0D0" //TODO
                    Image
                    {
                        id: icon
                        anchors.verticalCenter: parent.verticalCenter
                        x: Script.g_font_pixelSize / 2
                        smooth: true
                        source: folderModel.isFolder(index)
                                ? "image://theme/icon-s-invitation-pending"
                                : "image://theme/icon-s-invitation-accept"
                        visible: source != ''
                    }

                    Text {
                        id: fileNameView
                        text: fileName
                        font.pixelSize: Script.g_font_pixelSize
                        anchors.verticalCenter: parent.verticalCenter
                        x: Script.g_font_pixelSize * 2
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent

                        onClicked: {
                            fileNameView.color="red"
                            color: platformStyle.colorNormalLight
                            dir.text = filePath

                            if ( folderModel.isFolder(index) ) {
                                folderChanged(filePath);
                            } else {
                                fileSelected( filePath );
                            }

                        }
                    }
                }
            }

            model: folderModel

            delegate: fileDelegate

        }
    }
}
