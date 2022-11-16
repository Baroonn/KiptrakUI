import QtQuick
import QtQuick.Controls 6.3

Item {
    width: parent.width
    height: parent.height
    Rectangle {
        id: rectangle
        color: "#2C3E50"
        anchors.fill: parent

        BusyIndicator {
            id: busyIndicator
            anchors.centerIn: parent
        }
    }

}
