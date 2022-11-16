import QtQuick
import QtQuick.Controls
import "Database.js" as LocalStorage

Window {
    width: 360
    height: 700
    visible: true
    title: qsTr("KipTrak")

//    Text {
//        text: masterController.ui_welcomeMessage
//    }

    Connections{
        target: masterController.ui_navigationController
        onGoCreateAccountView: stack.push("CreateAccount.qml")
        onGoLoginView: stack.push("Login.qml")
        onGoMainPageView: stack.push("MainPage.qml")
        onGoSearchView: stack.push("SearchUsers.qml")
        onGoCreateAssignmentView: stack.push("CreateAssignment.qml")
    }


    StackView{
        id: stack
        anchors.fill: parent
        initialItem: "LoadPage.qml"
        Component.onCompleted: {
            LocalStorage.dbInit()
            var rows = LocalStorage.dbGetAuthDataCount();
            if(rows>0)
            {
                stack.replace("MainPage.qml")
            }
            else{
                stack.replace("Login.qml")
            }
        }

    }

}
