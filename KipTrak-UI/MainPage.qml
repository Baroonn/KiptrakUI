import QtQuick
import QtQuick.Controls

Item {
    width: parent.width
    height: parent.height


    Rectangle{
        FontLoader{
            id: webFont
            source: "qrc:/solidFonts.otf"
        }
        anchors.fill: parent
        color: "#1C4A5A"
        StackView{
            id: mainStack
            initialItem: "GetAssignments.qml"
            anchors.bottom: navBar.top
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Row{
            id: navBar
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50
            Rectangle{
                anchors.fill: parent
                color: "#1C4A5A"
                z:-99
            }

            Rectangle{
                id: home
                height: navBar.height
                width: navBar.width/3
                anchors.left: navBar.left
                color: "#1C4A5A"
                Text{
                    id: homeText
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: "\uf015"
                    color: "#ED7014"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainStack.replace("GetAssignments.qml")

                        homeText.color = "#ED7014"

                        searchText.color = "white"

                        addText.color  = "white"
                    }
                }

            }

            Rectangle{
                id: search
                anchors.left: home.right
                height: parent.height
                width: parent.width/3
                color: "#1C4A5A"
                Text{
                    id: searchText
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: "\uf002"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainStack.replace("SearchUsers.qml")
                        //home.color = "white"
                        homeText.color = "white"
                        //search.color = "#2C3E50"
                        searchText.color = "#ED7014"
                        //add.color = "white"
                        addText.color  = "white"
                    }
                }
            }

            Rectangle{
                id: add
                anchors.left: search.right
                height: parent.height
                width: parent.width/3
                color: "#1C4A5A"
                Text{
                    id: addText
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: "\uf044"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainStack.replace("CreateAssignment.qml")
                        //home.color = "white"
                        homeText.color = "white"
                        //search.color = "white"
                        searchText.color = "white"
                        //add.color = "#2C3E50"
                        addText.color  = "#ED7014"

                    }
                }
            }


        }

    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:10}
}
##^##*/
