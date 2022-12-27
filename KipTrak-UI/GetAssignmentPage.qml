import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    width: parent.width
    height: parent.height

    property alias contentId: assignId.text
    property alias listModel: listView.model
    Rectangle{
        id: back
        anchors.fill: parent
        anchors.margins: 10
        color: "#F5F5F4"

        Label{
            id: assignId
            visible: false
        }
        ListModel{
            id: model
        }
        ListView{
            id: listView
            anchors.fill: parent
            model: model
            delegate: ColumnLayout{
                width: parent.width
                anchors.margins: 10
                Label{
                    id: top
                    text: myLabel
                    font.pixelSize: 20
                    font.bold: true
                    color: "#1C4A5A"
                }
                Text{
                    id:bottom
                    text: myText
                    width: parent.width
                    wrapMode: Text.Wrap
                    color: "black"
                    bottomPadding: 10
                    font.pixelSize: 16
                    Layout.maximumWidth: parent.width
                    horizontalAlignment: Text.AlignJustify
                }
            }

        }
    }
}
