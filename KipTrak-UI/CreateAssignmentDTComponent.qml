import QtQuick
import KipTrak 1.0
Item {
    property DateTimeDecorator dateTimeDecorator
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
            color: "black"
            text: dateTimeDecorator.ui_label
            font.pixelSize: 18
        }

        Rectangle {
            id: background
            color: "#fffdfd"
            radius: 6
            border.color: "black"
            width: parent.width
            TextInput {
                id: textValue
                color: "#020202"
                anchors.fill: parent
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
                text: dateTimeDecorator.ui_prettyDateString
            }
        }
    }


    Binding {
        target: dateTimeDecorator
        property: "ui_value"
        value: textValue.text
    }

}
