import QtQuick
import QtQuick.Controls
import "service.js" as Service
import "Database.js" as LocalStorage

Item {
    width: parent.width
    height: parent.height

    Rectangle {
        id: background
        color: "#2C3E50"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text{
            id: loginHeading
            anchors.left: parent.left
            anchors.top: parent.top
            color: "#fff8f8"
            anchors.leftMargin: 20
            anchors.topMargin: 50
            text: "Log In"
            font.pixelSize: 30
        }

        Text {
            id: username
            width: 92
            height: 19
            color: "#fff8f8"
            text: qsTr("Username")
            anchors.left: parent.left
            anchors.top: loginHeading.bottom
            font.pixelSize: 18
            anchors.leftMargin: 20
            anchors.topMargin: 20
        }

        Rectangle {
            id: userRectangle
            height: 35
            color: "#fffdfd"
            radius: 6
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: username.bottom
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.topMargin: 10
            TextInput {
                id: userInput
                color: "#020202"
                anchors.fill: parent
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
            }
        }

        Text {
            id: password
            width: 92
            height: 19
            color: "#fff8f8"
            text: qsTr("Password")
            anchors.left: parent.left
            anchors.top: userRectangle.bottom
            font.pixelSize: 18
            anchors.leftMargin: 20
            anchors.topMargin: 20
        }

        Rectangle {
            id: passwordRectangle
            height: 35
            color: "#fffdfd"
            radius: 6
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: password.bottom
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.topMargin: 10
            TextInput {
                id: passwordInput
                color: "#020202"
                anchors.fill: parent
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.MixedCase
                cursorVisible: false
                passwordCharacter: "*"
                leftPadding: 10
                echoMode: TextInput.Password
            }
        }

        Text {
            id: notAUser
            anchors.top: passwordRectangle.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "#fcfbfb"
            text: qsTr("Not a User?")
            font.pixelSize: 15
        }

        Text {
            id: error
            anchors.top: notAUser.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: qsTr("")
            font.pixelSize: 15
            color: "yellow"
        }

        Text {
            id: createAccount
            anchors.top: passwordRectangle.bottom
            anchors.topMargin: 20
            anchors.left: notAUser.right
            anchors.leftMargin: 20
            color: "#fcfbfb"
            text: qsTr("Create Account")
            font.pixelSize: 15

            MouseArea {
                id: mouseArea1
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    masterController.goCreateAccountView()
                }
            }
        }

        Rectangle {
            id: loginButton
            width: 195
            height: 45
            color: "#ffffff"
            radius: 20
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 20

            MouseArea {
                id: mouseArea
                anchors.fill: parent

                Text {
                    id: login
                    x: 67
                    y: 21
                    anchors.centerIn: parent
                    text: qsTr("Log In")
                    font.pixelSize: 19
                    fontSizeMode: Text.FixedSize
                }

                onClicked: {
                    login.text = "Loading..."
                    const entry = {
                        userName: userInput.text,
                        password: passwordInput.text,
                    }

                    Service.login(entry, function(response, status_code){
                        if(status_code === 200){
                            error.text = ""
                            console.log(response.token)
                            LocalStorage.dbSetAuthData(userInput.text, passwordInput.text, response.token)
                            masterController.ui_navigationController.goMainPageView()
                        }
                        else if(status_code === 401){
                            error.text = "Wrong Username or Password!"
                        }
                        else if(status_code === 422){
                            error.text = "Username and Password Required!"
                        }
                        else{
                            error.text = "Something went wrong! Please try again."
                        }

                        login.text = "Log In"

                    })
                }
            }
        }
    }

    Component.onCompleted: {
        LocalStorage.dbInit()
    }

}
