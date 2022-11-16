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
        color: "#2C3E50"
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
                id: home
                height: navBar.height
                width: navBar.width/3
                anchors.left: navBar.left
                color: "#2C3E50"
                Text{
                    id: homeText
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: "\uf015"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainStack.replace("GetAssignments.qml")
                        home.color = "#2C3E50"
                        homeText.color = "white"
                        search.color = "white"
                        searchText.color = "#2C3E50"
                        add.color = "white"
                        addText.color  = "#2C3E50"
                    }
                }

            }

            Rectangle{
                id: search
                anchors.left: home.right
                height: parent.height
                width: parent.width/3
                Text{
                    id: searchText
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: "\uf002"
                    color: "#2C3E50"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainStack.replace("SearchUsers.qml")
                        home.color = "white"
                        homeText.color = "#2C3E50"
                        search.color = "#2C3E50"
                        searchText.color = "white"
                        add.color = "white"
                        addText.color  = "#2C3E50"
                    }
                }
            }

            Rectangle{
                id: add
                anchors.left: search.right
                height: parent.height
                width: parent.width/3

                Text{
                    id: addText
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: "\uf044"
                    color: "#2C3E50"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainStack.replace("CreateAssignment.qml")
                        home.color = "white"
                        homeText.color = "#2C3E50"
                        search.color = "white"
                        searchText.color = "#2C3E50"
                        add.color = "#2C3E50"
                        addText.color  = "white"

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
