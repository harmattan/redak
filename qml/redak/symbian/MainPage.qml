import QtQuick 1.1
import com.nokia.symbian 1.1
import Core 1.0
import "../common/script.js" as Script
import "../common"
import "./"


Page {
    id: pageView
    property alias textEdit: textEdit
    property alias content: textEdit.text

    tools: commonTools

    //Component.onCompleted: { theme.inverted = true }

    Flickable {
        id: flickable

        width: parent.width
        height: parent.height
        clip: true

        //        contentWidth: edit.paintedWidth
        //        contentHeight: edit.paintedHeight

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
            id: textEdit
            width: flickable.width
            height: flickable.height
            //anchors.leftMargin: Script.g_font_pixelSize/3;
            //anchors.rightMargin: Script.g_font_pixelSize/3;
            //cursorVisible: true
            //selectByMouse: false
            focus: true
            text: Script.g_info
            smooth: true
            wrapMode: TextArea.Wrap
            textFormat: TextEdit.PlainText
            font.pixelSize: Script.g_font_pixelSize
            //onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
        }
    }
}
