/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.meego 1.0
import "../common/script.js" as Script


Page {
    id: editPage
    property alias content: textArea.text

    property alias isEdit : textArea.enabled;
    //property bool isEdit : true;

    signal contents(string contents)
    property bool isChanged: false;

    tools: commonTools

    onContents:{
        textArea.height = 0;
        textArea.text = contents;
    }

    onContentChanged:  {
        isChanged = true;
    }

    function setContents(contents)
    {
        textArea.height = 0;
        textArea.text = contents;
        isChanged = false;
    }

    function toggleEdit()
    {
        Script.log("#{ toggleEdit : " + isEdit )
        isEdit = ! isEdit;
        // isEdit = textArea.readOnly;
        // isEdit = ! textArea.enableSoftwareInputPanel ;
        // textArea.enabled = !textArea.enabled ;
        // textArea.enableSoftwareInputPanel = isEdit;
        //textArea.focus = isEdit;
        textArea.readOnly = !isEdit;

        textArea.enabled = isEdit
        //flickable.enabled = !isEdit;
        //flickable.focus = !isEdit;
        //flickable.returnToBounds();
        //flickable.interactive = !isEdit;
        //

        //flickable.focus=!isEdit;
        textArea.focus=isEdit;

        if ( isEdit ) {
            flickable.interactive = true;
            textArea.forceActiveFocus();
        } else {
            flickable.interactive = !isEdit;
            flickable.focus= !isEdit;
            flickable.forceActiveFocus();
        }

        //textArea.cursorPosition = textArea.cursorPosition;
        //var b = textArea.selectionStart;
        //var e = textArea.selectionEnd;
        //textArea.select( b, e);
        Script.log("#} toggleEdit : " + isEdit )

        return isEdit;
    }
    //Component.onCompleted: { theme.inverted = true }

    Flickable {
        id: flickable
        anchors.margins: - Script.g_font_pixelSize
        width: parent.width
        height: parent.height
        clip: true
        // interactive: !textArea.enabled
//      interactive: false
        //boundsBehavior: Flickable.DragOverBounds;

        // contentWidth: textArea.paintedWidth
        contentHeight: textArea.paintedHeight

        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;
        }

        onFocusChanged: Script.log("Flickable.focus="+focus);

//        onMovementStarted: {
//          textArea.focus=false;
//        }
//        onMovementEnded: {
//          textArea.focus=true;
//        }

        TextArea {
            id: textArea
            width: parent.width
            //height: parent.height
            property int paintedHeight: ( textArea.height > editPage.height ) ? textArea.height : editPage.height
            //anchors.leftMargin: Script.g_font_pixelSize/3;
            //anchors.rightMargin: Script.g_font_pixelSize/3;
            //cursorVisible: true
            //selectByMouse: false
            focus: true
            text: Script.g_info
            smooth: true
            wrapMode: TextEdit.Wrap
            textFormat: TextEdit.PlainText
            font.pixelSize: Script.g_font_pixelSize
            //implicitHeight: parent.height

            // onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
            //font.family: "Courier" //TODO
            //            MouseArea {
            //                onPressAndHold: textArea.closeSoftwareInputPanel();
            //                onClicked: {
            //                    if (!textArea.activeFocus) {
            //                        textArea.forceActiveFocus();
            //                        textArea.openSoftwareInputPanel();
            //                    } else {
            //                        textArea.focus = false;
            //                    }
            //                }
            //            }

            //onEnabledChanged: flickable.interactive = !enabled;
            //onEnabledChanged: flickable.interactive = true;
            //onFocusChanged: flickable.interactive = ( textArea.focus ) ;
            onFocusChanged: Script.log("TextArea.focus="+focus);

//            MouseArea {
  //                  anchors.fill: parent
    //                onClicked: {
      //                  Script.log("MouseArea.OnClicked")
        //                parent.forceActiveFocus();
          //              //parent.openSoftwareInputPanel();
            //        }
//            }
        }
    }
}
