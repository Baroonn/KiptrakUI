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
            id: createAccountHeading
            anchors.left: parent.left
            anchors.top: parent.top
            color: "#fff8f8"
            anchors.leftMargin: 20
            anchors.topMargin: 50
            text: "Create Account"
            font.pixelSize: 30
        }

        Text {
            id: username
            width: 92
            height: 19
            color: "#fff8f8"
            text: qsTr("Username*")
            anchors.left: parent.left
            anchors.top: createAccountHeading.bottom
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
            id: email
            width: 92
            height: 19
            color: "#fff8f8"
            text: qsTr("Email*")
            anchors.left: parent.left
            anchors.top: userRectangle.bottom
            font.pixelSize: 18
            anchors.leftMargin: 20
            anchors.topMargin: 20
        }

        Rectangle {
            id: emailRectangle
            height: 35
            color: "#fffdfd"
            radius: 6
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: email.bottom
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.topMargin: 10
            TextInput {
                id: emailInput
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
            text: qsTr("Password*")
            anchors.left: parent.left
            anchors.top: emailRectangle.bottom
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
            id: phone
            width: 92
            height: 19
            color: "#fff8f8"
            text: qsTr("Phone")
            anchors.left: parent.left
            anchors.top: passwordRectangle.bottom
            font.pixelSize: 18
            anchors.leftMargin: 20
            anchors.topMargin: 20
        }

        Rectangle {
            id: phoneRectangle
            height: 35
            color: "#fffdfd"
            radius: 6
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: phone.bottom
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.topMargin: 10
            TextInput {
                id: phoneInput
                color: "#020202"
                anchors.fill: parent
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
            }
        }

        Text {
            id: aUser
            anchors.top: phoneRectangle.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "#fcfbfb"
            text: qsTr("Already a User?")
            font.pixelSize: 15
        }

        Text {
            id: error
            anchors.top: aUser.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "yellow"
            text: qsTr("")
            font.pixelSize: 15
        }

        Text {
            id: login
            anchors.top: phoneRectangle.bottom
            anchors.topMargin: 20
            anchors.left: aUser.right
            anchors.leftMargin: 20
            color: "#fcfbfb"
            text: qsTr("Login")
            font.pixelSize: 15

            MouseArea {
                id: mouseArea1
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    masterController.goLoginView()
                }
            }
        }

        Rectangle {
            id: createAccountButton
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
                    id: createAccount
                    x: 67
                    y: 21
                    anchors.centerIn: parent
                    text: qsTr("Create Account")
                    font.pixelSize: 19
                    fontSizeMode: Text.FixedSize
                }

                onClicked: {
                    createAccount.text = "Loading..."
                    const entry = {
                        userName: userInput.text,
                        email: emailInput.text,
                        password: passwordInput.text,
                        phone: phoneInput.text
                    }

                    Service.createUser(entry, function(response, status_code){
                        if(status_code===201)
                        {

                            Service.login(entry, function(res, status){
                                if(status===200){
                                    LocalStorage.dbSetAuthData(userInput.text, passwordInput.text, res.token)
                                    masterController.ui_navigationController.goMainPageView()
                                }

                            }
                            )
                        }
                        else if(status_code === 400)
                        {
                            error.text=""
                            for (var key in response)
                            {
                                error.text += response[key][0]
                                error.text += "\n"
                            }

//                            if(response.hasOwnProperty("DuplicateEmail")){
//                                error.text += "Email is already taken!\n"
//                            }
//                            if(response.hasOwnProperty("DuplicateUserName")){
//                                error.text += "Username is already taken!\n"
//                            }
                        }
                        else if(status_code === 422){
                            error.text = "Please fill all required fields(*)"
                        }
                        else{
                            error.text="Something went wrong! Please try again"
                        }

                        createAccount.text = "Create Account"

                    })
                }
            }
        }


    }

}
