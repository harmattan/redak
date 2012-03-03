/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/
import QtQuick 1.1
import com.nokia.meego 1.0
import Core 1.0
import "../common/script.js" as Script
import "../common"
import "./"


Page {
    id: pageView
    property alias textArea: textArea
    property alias content: textArea.text

    tools: commonTools

    //Component.onCompleted: { theme.inverted = true }

    Flickable {
        id: flickable

        width: parent.width
        height: parent.height
        clip: true


        //contentWidth: textArea.width
        //contentHeight: textArea.height

        //contentWidth: textArea.paintedWidth
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

        TextArea {
            id: textArea
            property int paintedHeight: ( textArea.height > pageView.height ) ? textArea.height : pageView.height
            width: flickable.width
            //height: flickable.height
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
