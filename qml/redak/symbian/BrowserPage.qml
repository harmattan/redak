/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import Qt.labs.folderlistmodel 1.0
import com.nokia.symbian 1.1
import "../common/script.js" as Script


Page {
    id: browserPage
    property variant content: content
    property int mode: 0 //0=load 1=save
    property variant filename: dir.text
    property alias folderPath: folderModel.folder;

    signal loaded()
    signal error(/*string message*/)
    signal fileSelected(string path);

    signal folderChanged(string path);

    onFolderChanged: {
        Script.handleFolderChanged(path); //TODO: path param on pop
        dir.text = path
        folderModel.folder = path ;
    }

    onFileSelected: {
        Script.handlePath( path ); //TODO: use signal
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
        ToolButton {
            //text: qsTr("back")
            iconSource: "toolbar-back"
            onClicked: { pageStack.pop(); }
        }

        ToolButton {
            // text: qsTr("..")
            iconSource: "toolbar-previous"
            //platformIconId: "toolbar-view-menu"

            onClicked: {
                folderChanged(folderModel.parentFolder);
            }
        }

        ToolButton {
            // text: qsTr("..")
            iconSource: "toolbar-next"
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
            // placeholderText: "Directory or File to load"
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
            //onAccepted: {
            //    folderModel.folder = text;
            //}

            //            Keys.onReturnPressed: {
            //          }
            //            Rectangle {
            //                anchors {
            //                    top: parent.top;
            //                    right: parent.right;
            //                    margins: platformStyle.paddingMedium
            //                }
            //                id: valid
            //                //fillMode: Image.PreserveAspectFit
            //                smooth: true;
            //                //               visible: dir.text
            //                //source: "toolbar-back"
            //                height: parent.height - platformStyle.paddingMedium * 2
            //                width: parent.height - platformStyle.paddingMedium * 2
            //                color: "blue"
            //                MouseArea {
            //                    anchors {
            //                        horizontalCenter: parent.horizontalCenter;
            //                        verticalCenter: parent.verticalCenter
            //                    }
            //                    height: valid.height;
            //                    width: valid.height
            //                    onClicked: {
            //                        handlePath( dir.text );
            //                    }
            //                }
            //            }
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
                    border.width: 5 // Script.g_font_pixelSize / 10;
                    radius: 10 //Script.g_font_pixelSize / 5;
                    color: mouseArea.pressed
                           ? Script.g_color_bg_pressed
                           : Script.g_color_bg_normal;


                    Rectangle
                    {
                        id: icon
                        anchors.verticalCenter: parent.verticalCenter
                        x: Script.g_font_pixelSize / 2
                        smooth: true
                        // source: folderModel.isFolder(index)
                        // ? "image://theme/icon-s-invitation-pending"
                        // : "image://theme/icon-s-invitation-accept"
                        color: folderModel.isFolder(index)
                               ? "red" : "green"
                        // visible: source != ''

                        width: Script.g_font_pixelSize
                        height: Script.g_font_pixelSize
                        border.color: Script.g_color_border
                        border.width: Script.g_font_pixelSize / 10;
                        radius: Script.g_font_pixelSize / 4;

                        //                      Text { text: folderModel.isFolder(index) ? "+" : "-" ;
                        //                    	font.pixelSize:Script.g_font_pixelSize;
                        //                  	anchors.verticalCenter: parent.verticalCenter
                        //                	anchors.horizontalCenter: parent.horizontalCenter
                        //              }
                    }

                    Text {
                        id: fileNameView
                        text: fileName
                        font.pixelSize: Script.g_font_pixelSize
                        anchors.verticalCenter: parent.verticalCenter
                        x: Script.g_font_pixelSize * 2
                        color: "white"
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
