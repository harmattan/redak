import QtQuick 1.1
import Qt.labs.folderlistmodel 1.0
import com.nokia.meego 1.0
//import com.nokia.symbian 1.1
import Core 1.0
import "../common/script.js" as Script
import "../common"
import "./"


Page {
    property variant content: content
    property int mode: 0 //0=load 1=save

    signal loaded()

    anchors.fill: parent
    //Component.onCompleted: { theme.inverted = !true }

    tools: // commonTools
           ToolBarLayout {
        ToolIcon { iconId: "toolbar-back"; onClicked: { pageStack.pop(); }  }
    }

    onLoaded: {
        Script.handleLoaded()
    }

    Column {
        width: parent.width
        height: parent.height
        //anchors.fill: parent
        //Row {
        TextField{
            id: dir
            text: ( null == folderModel.folder ) ? "./" : folderModel.folder
            width:parent.width;
            placeholderText: "Directory or File to load"
            focus: false;
            onAccepted: {
                folderModel.folder = text;
            }
            Keys.onReturnPressed: {
                if ( 0 == mode ) {
                    platformCloseSoftwareInputPanel();
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

            //Image{
            //   source :"toolbar-home"
            //}

        }
        //}

        // FolderView {
        //     id: folderView
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
                showDotAndDotDot: true
                //sortField: "Name"
            }
            Component {
                id: fileDelegate

                Rectangle {
                    property int type

                    width: parent.width
                    height: fileNameView.height * 1.5
                    color: mouseArea.pressed ? Script.g_color_bg_pressed : Script.g_color_bg_normal;
                    border.color: "black"
                    border.width: 5
                    radius: 10

                    Image
                    {
                        id: icon
                        anchors.verticalCenter: parent.verticalCenter

                        smooth: true
                        source: folderModel.isFolder(index)
                                ? "image://theme/icon-s-invitation-pending"
                                : "image://theme/icon-s-invitation-accept"
                        visible: source != ''
                        x: Script.g_font_pixelSize / 2
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
