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
        color: "#F5F5F4"
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
                color: "#F5F5F4"
                z:-99
            }

            Rectangle{
                id: home
                height: navBar.height
                width: navBar.width/3
                anchors.left: navBar.left
                color: "#F5F5F4"
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
                        homeText.color = "#ED7014"

                        searchText.color = "black"

                        addText.color  = "black"
                        if(mainStack.currentItem.toString().split('_')[0]!=="GetAssignments"){
                            mainStack.push("GetAssignments.qml")
                        }
                    }
                }

            }

            Rectangle{
                id: search
                anchors.left: home.right
                height: parent.height
                width: parent.width/3
                color: "#F5F5F4"
                Text{
                    id: searchText
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: "\uf002"
                    color: "black"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        //home.color = "white"
                        homeText.color = "black"
                        //search.color = "#2C3E50"
                        searchText.color = "#ED7014"
                        //add.color = "white"
                        addText.color  = "black"
                        if(mainStack.currentItem.toString().split('_')[0]!=="SearchUsers"){
                            mainStack.push("SearchUsers.qml")
                        }
                    }
                }
            }

            Rectangle{
                id: add
                anchors.left: search.right
                height: parent.height
                width: parent.width/3
                color: "#F5F5F4"
                Text{
                    id: addText
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: "\uf044"
                    color: "black"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        //home.color = "white"
                        homeText.color = "black"
                        //search.color = "white"
                        searchText.color = "black"
                        //add.color = "#2C3E50"
                        addText.color  = "#ED7014"
                        if(mainStack.currentItem.toString().split('_')[0]!=="CreateAssignment"){
                            mainStack.push("CreateAssignment.qml")
                        }
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
