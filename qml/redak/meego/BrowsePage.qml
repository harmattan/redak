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
    property variant filename: location.text
    property alias folderPath: folderModel.folder;

    signal loaded()
    signal error(/*string message*/)
    signal fileSelected(string path);

    signal folderChanged(string path);

    onFolderChanged: {
        location.text = path
        folderModel.folder = path ;
    }

    onFileSelected: {
        Script.log( path ); //TODO: use signal
    }

    anchors.fill: parent

    Component.onCompleted: {
        //theme.inverted = !true
        Script.log("BrowsePage: " + folderPath );
        //location.text = folderPath ;
        //folderModel.submit ;
    }

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
            // iconId: "toolbar-backspace" //TODO
            iconId: "common-directory" //TODO
            //platformIconId: "toolbar-view-menu"

            onClicked: {
                folderChanged(folderModel.parentFolder);
            }
        }

        ToolIcon {
            // text: qsTr("..")
            // iconId: "toolbar-search"
             iconId: "content-document"
            //platformIconId: "toolbar-view-menu"

            onClicked: {
                fileSelected( location.text );
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
            id: location
            text: ( null == folderModel.folder ) ? "./" : folderModel.folder
            width:parent.width;
            placeholderText: "Directory or File to load"
            focus: false;

            Keys.onReturnPressed: {
                fileSelected(filename);
            }

            onFocusChanged:  {
                var start = location.text.length;
                location.select( start , start);
                location.focus = true;
            }

            // https://bugreports.qt-project.org/browse/QTBUG-16870
            // onAccepted: { //BUG: RM696-34-1_PR_005
            //    folderModel.folder = text;
            // } // Cannot assign to non-existent property "onAccepted"

            Item { //WORKAROUND:
                anchors.fill: parent
                focus: true
                Keys.onPressed: {
                    if (event.key == Qt.Key_Return) {
                        folderModel.folder = text;
                        event.accepted = true;
                    }
                }
            }
        }
        //}

        ListView {
            id: listView
            clip: true
            //anchors.top: path.bottom
            //anchors.bottom: parent.bottom
            //anchors.fill: parent
            height: parent.height - location.height
            width: parent.width;

            FolderListModel {
                id: folderModel
                nameFilters: ["*"]
                showDirs: true
                showDotAndDotDot: false
                //folder: (null != folder) ? folder : "file:///";
                //sortField: "Name"
            }

            Component {
                id: fileDelegate

                Rectangle {
                    property int type

                    width: parent.width
                    height: fileNameView.height * 1.5
                    border.color: Script.g_color_border
                    border.width: 5 // Script.g_font_pixelSize / 10;
                    radius: 10 //Script.g_font_pixelSize / 5;
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
//TODO
                        source: folderModel.isFolder(index)
                                ? "image://theme/icon-s-common-favorite-unmark"
                                : "image://theme/icon-s-common-favorite-mark";
//                                ? "image://theme/icon-s-invitation-pending"
//                                : "image://theme/icon-s-invitation-accept"
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
                            location.text = filePath

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
