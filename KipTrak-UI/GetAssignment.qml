import QtQuick
import QtQuick.Controls

Item {
    width: parent.width
    height: parent.height
    property alias contentTitle: header.text
    property alias contentId: assignId.text
    property alias listModel: listView.model
//    property alias contentDescription: descriptionText.text
//    property alias contentCourse: courseText.text
//    property alias contentTeacher: teacherText.text
//    property alias contentDateDue: dateDueText.text
//    property alias contentNotes: notesText.text
//    property alias contentCreated: created.text
//    property alias contHeight: back.height
    Rectangle{
        id: back
        anchors.fill: parent
        //anchors.margins: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 50
        color: "#2C3E50"
        Label{
                    id: assignId
                    visible: false
        }
        ListModel{
            id: model
        }
        Label{
            id: header
            width: parent.width
            anchors.top: parent.top
            wrapMode: Text.Wrap
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            font.pointSize: 24
            color: "white"
            background: Rectangle{
                anchors.fill: parent
                color: "#2C3E50"
            }

            z:1
        }
        ListView{
            id: listView
            anchors.top: header.bottom
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            model: model
            delegate: Text{
                text: myText
                width: parent.width
                wrapMode: Text.Wrap
                color: "white"
                topPadding: 10
            }
        }


    }

}
