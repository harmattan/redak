/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../common/script.js" as Script


Page {
    id: editPage
    property alias content: textArea.text

    property alias isEdit : textArea.enabled;

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
        //textArea.height = 0;
        textArea.text = contents;
        isChanged = false;
        //Script.log("#} setContents " + textArea.height );
    }

    function toggleEdit()
    {
        textArea.enabled = !textArea.enabled ;
        // textArea.enableSoftwareInputPanel  = textArea.enabled;
        textArea.focus = textArea.enabled;
        flickable.focus = !textArea.focus;
        return textArea.enabled;
    }
    //Component.onCompleted: { theme.inverted = true }

    Flickable {
        id: flickable
        anchors.margins: Script.g_font_pixelSize
        width: parent.width
        height: parent.height
        clip: true

        // contentWidth: textArea.paintedWidth
        // contentHeight: textArea.paintedHeight

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

        TextArea {
            id: textArea
            width: parent.width
            height: parent.height
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

        }
    }
}
