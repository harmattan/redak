import QtQuick 1.1
import Qt.labs.folderlistmodel 1.0
import com.nokia.symbian 1.1
import Core 1.0
import "../common/script.js" as Script
import "../common"
import "./"


Page {
    property variant content: content
    property int mode: 0 //0=load 1=save

    signal loaded()

//    property alias browserView: mColumn.browserView
//    property alias folderModel: browserView.folderModel

    anchors.fill: parent
    //Component.onCompleted: { theme.inverted = !true }

    tools: // commonTools
           ToolBarLayout {
        ToolButton {
            text: qsTr("back")
            //iconSource: "back"
            //platformIconId: "toolbar-view-menu"
            anchors.left: (parent === undefined) ? undefined : parent.left
            onClicked: { pageStack.pop(); }
        }

        ToolButton {
            text: qsTr("parent")
            //iconSource: "back"
            //platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: {
                //console.log( folderModel.parentFolder  );
                dir.text = folderModel.parentFolder
                folderModel.folder = folderModel.parentFolder ;
            }
        }
    }

    onLoaded: {
        Script.handleLoaded()
    }

    Column {
        id: mColumn
        width: parent.width
        height: parent.height

        //Row {
        TextField{
            id: dir
            text: ( null == folderModel.folder ) ? "./" : folderModel.folder
            width:parent.width;
            placeholderText: "Directory or File to load"
            focus: false;
//          onAccepted: {
//              folderModel.folder = text;
//          }
            Keys.onReturnPressed: {
                if ( 0 == mode ) {
                    //platformCloseSoftwareInputPanel();
                    Script.load( dir.text );
                    listView.focus = true;
                    //              pageStack.pop();
                } else {
                    var filename = ( null === dir ) ? "unknown.txt" : dir.text;
                    console.log("saving:" + dir.text );
                    core.save( content, filename );
                    listView.focus = true;
                    pageStack.pop();

                }
            }
            onFocusChanged:  {
                var start = dir.text.length;
                dir.select( start , start);
                dir.focus = true;
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
            width:parent.width;

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
                    color: mouseArea.pressed ? Script.g_color_bg_pressed : Script.g_color_bg_normal;
                    border.color: "grey"
                    border.width: 5
                    radius: 10

                    Rectangle
                    {
                        id: icon
                        anchors.verticalCenter: parent.verticalCenter

                        smooth: true
//                        source: folderModel.isFolder(index)
//                                ? "image://theme/icon-s-invitation-pending"
//                                : "image://theme/icon-s-invitation-accept"
//                        visible: source != ''
                        color: folderModel.isFolder(index) ? "red" : "green"
                        x: Script.g_font_pixelSize / 2
                        width: Script.g_font_pixelSize
                        height: Script.g_font_pixelSize
                    }
                    Text {
                        id: fileNameView
                        text: fileName
                        font.pixelSize: Script.g_font_pixelSize
                        anchors.verticalCenter: parent.verticalCenter
                        x: Script.g_font_pixelSize * 2
//                      color: "white"
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent

                        onClicked: {
                            fileNameView.color="red";
                            color: platformStyle.colorNormalLight

                            if ( folderModel.isFolder(index) ) {
                                dir.text = filePath
                                folderModel.folder = filePath;
                            } else {
                                if ( 0 == mode ) {
                                    Script.load( filePath );
                                } else {
                                    core.save( content, filePath );
                                    pageStack.pop();
                                }
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
