import QtQuick
import QtQuick.Controls
import "service.js" as Service

Item {
    width: parent.width
    height: parent.height

    Rectangle{
        opacity: 1
        anchors.fill: parent
        color: "#F5F5F4"

        Rectangle {
            id: searchRectangle
            height: 35
            color: "#fffdfd"
            border.color: "black"
            radius: 6
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 20
            z:1

            TextInput{
                id: userInput
                color: "#020202"
                text: ""
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: searchRectangle.width - 20
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10

                Text {
                    text: "  Search for User"
                    color: "#aaa"
                    visible: !userInput.text && !userInput.activeFocus
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }
            }
            MouseArea{
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 40
                Text{
                    id: searchText
                    font{
                        family: webFont.name
                        pixelSize: 15
                    }
                    text: "\uf002"
                    color: "#2C3E50"
                    anchors.centerIn: parent
                }

                onClicked: {
                    error.text="Searching..."
                    var following = ""
                    var userInputTex = userInput.displayText.toString()
                    const getUser = function(response, status_code){
                        if(status_code === 200){
                            model.clear()
                            error.text=response.length === 0 ? "No user" : ""
                            if(response.length === 0){
                                //error.text = "No user found"
                            }
                            else{

                                //error.text = ""
                            }

                            response.forEach(function(x){
                                console.log(userInputTex)
                                if(userInputTex === ""){
                                    return
                                }

                                if(x.userName.toLowerCase().includes(userInputTex.toLowerCase())){
                                    listView.model.append({
                                                              userIdText: x.id,
                                                              usernameText: x.userName,
                                                              buttonText: following.includes(x.userName)?"Unfollow":"Follow"
                                                          })
                                }
                            })
                        }
                    }

                    const getFollowing = function(response, status_code){

                        if(status_code === 200){

                            response.forEach(function(x){
                                following += (x.userName + "|")
                            }
                            )

                            Service.getUsers(userInput.displayText.toString(), getUser)
                        }
                    }


                    Service.getFollowing(getFollowing)

                }
            }
        }
        Label {
            id: error
            anchors.top:  searchRectangle.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            height: 30
            color: "#1C4A5A"
        }

        ListModel{
            id: model
        }

        ListView{
            id: listView
            anchors.top: error.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            model: model
            headerPositioning: ListView.InlineHeader
            delegate: Rectangle{
                width: parent.width
                height: 50
                color: "#2C3E50"
                Label{
                    id:userId
                    visible: false
                    text: userIdText
                }

                Label{
                    id: username
                    text: usernameText
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    color: "white"
                }

                MouseArea{
                    id: followButton
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width/4
                    Text{
                        id: status
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        text: buttonText
                    }
                    onClicked: {
                        const followUser = function(response, status_code){
                            if(status_code === 204){
                                status.text = status.text == "Follow"?"Unfollow":"Follow"
                            }
                            else{

                            }


                        }

                        if(status.text === "Follow"){
                            Service.followUser(`users/${userId.text}/follow`, followUser)
                        }
                        else{
                            Service.followUser(`users/${userId.text}/unfollow`, followUser)
                        }
                    }
                }
            }
        }
    }
}
