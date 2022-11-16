import QtQuick
import KipTrak 1.0
Item {
    property StringDecorator stringDecorator
    property alias comHeight: background.height
    anchors.left: parent.left
    anchors.leftMargin: 10
    anchors.right: parent.right
    anchors.rightMargin: 10
    height: background.height + title.height + 20
    Flow{
        anchors.fill: parent
        anchors.margins: 4
        spacing: 10
        Text {
            id: title
            color: "#fff8f8"
            text: stringDecorator.ui_label
            font.pixelSize: 18
        }

        Rectangle {
            id: background
            color: "#fffdfd"
            radius: 6
            width: parent.width
            Flickable {
                  id: flick
                  width: background.width; height: background.height;
                  contentWidth: textValue.contentWidth
                  contentHeight: textValue.contentHeight
                  clip: true
                  onContentYChanged: {
                      console.log("contentY:", contentY)
                  }
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

                  TextEdit {
                      id: textValue
                      color: "#020202"
                      width: flick.width
                      font.pixelSize: 18
                      focus: true
                      verticalAlignment: Text.AlignTop
                      wrapMode: TextEdit.Wrap
                      leftPadding: 10
                      topPadding: 10
                      onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                      text: stringDecorator.ui_value
                  }
            }
        }
    }


    Binding {
        target: stringDecorator
        property: "ui_value"
        value: textValue.text
    }

}
