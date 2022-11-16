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
        color: "#2C3E50"

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
                    color: "yellow"
                }
                Text{
                    id:bottom
                    text: myText
                    width: parent.width
                    wrapMode: Text.Wrap
                    color: "white"
                    bottomPadding: 10
                    font.pixelSize: 18
                    Layout.maximumWidth: parent.width
                    horizontalAlignment: Text.AlignJustify
                }
            }

        }
    }
}
