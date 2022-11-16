import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs
import "service.js" as Service
import "Database.js" as LocalStorage

import com.company.fileupload 1.0
import KipTrak 1.0

Item {
    width: parent.width
    height: parent.width
    property Assignment newAssignment: masterController.ui_newAssignment
    Flickable{
        id: frame
        width: parent.width
        height: parent.height
        contentWidth: parent.width
        contentHeight: 1000
        Connections{
            target: masterController.ui_webRequest
            onRequestComplete: function(status_code, response){
                response = JSON.parse(response.toString())
                createAssignmentt.text = "Create Assignment"
                if(status_code === 201)
                {
                    error.text = "Successfully created assignment!"
                    if(image.source != ""){
                        error.text += "\nUploading File..."
                        Service.createImage(response.id, image.source)
                    }
                }
                else if (status_code === 422)
                {
                    error.text=""
                    for (var key in response)
                    {
                        error.text += response[key][0]
                        error.text += "\n"
                    }
                }
                else if (status_code === 400)
                {
                    error.text = "Please fill all the required fields(*)"
                }
                else if (status_code === 401)
                {
                    var userdetails = LocalStorage.dbGetUserDetails()
                    const userentry = {
                        userName : userdetails.split("&")[0],
                        password : userdetails.split("&")[1]
                    }

                    Service.login(userentry, function(res, status){
                        if(status === 200){
                            tries = 1
                            console.log(res.token)
                            LocalStorage.dbSetAuthData(userdetails.split("&")[0], userdetails.split("&")[1], res.token)
                            Service.createAssignment(entry, createAssign)
                        }
                        else if(status === 401){
                            error.text = "Authorization error. Please log in again."
                        }
                        else{
                            error.text = "Something went wrong during authorization! Try Again"
                        }
                    })
                }
                else
                {
                    error.text = "Something went wrong! Try Again."
                }
            }
        }
        Rectangle{
            id: mainFrame
            anchors.fill: parent
            color: "#2C3E50"
                Text{
                    id: createAssignmentHeading
                    text: "Create \nAssignment"
                    font.pixelSize: 42
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    color: "white"
                    width: parent.width
                    wrapMode: Text.Wrap
                }

                CreateAssignmentComponent{
                    id: titleInput
                    anchors.topMargin: 10
                    anchors.top: createAssignmentHeading.bottom
                    stringDecorator: newAssignment.ui_title
                    comHeight: 35
                }

                CreateFlickableAC{
                    id: descriptionInput
                    anchors.topMargin: 10
                    anchors.top: titleInput.bottom
                    stringDecorator: newAssignment.ui_description
                    comHeight: 100
                }

                CreateAssignmentComponent{
                    id: courseInput
                    anchors.topMargin: 10
                    anchors.top: descriptionInput.bottom
                    stringDecorator: newAssignment.ui_course
                    comHeight: 35
                }

                CreateAssignmentComponent{
                    id: teacherInput
                    anchors.topMargin: 10
                    anchors.top: courseInput.bottom
                    stringDecorator: newAssignment.ui_teacherName
                    comHeight: 35
                }

                CreateAssignmentDTComponent{
                    id: dateDueInput
                    anchors.topMargin: 10
                    anchors.top: teacherInput.bottom
                    dateTimeDecorator: newAssignment.ui_dateDue
                    comHeight: 35
                }

                CreateFlickableAC{
                    id: notesInput
                    anchors.topMargin: 10
                    anchors.top: dateDueInput.bottom
                    stringDecorator: newAssignment.ui_notes
                    comHeight: 100
                }

                Text {
                    id: imageText
                    color: "#fff8f8"
                    text: qsTr("Upload Pdf: ")
                    anchors.left: parent.left
                    anchors.top: notesInput.bottom
                    font.pixelSize: 18
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                }

                Rectangle {
                    id: imageRectangle
                    height: 20

                    color: "#fffdfd"
                    radius: 6
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: imageText.bottom
                    anchors.rightMargin: 20
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                    Text{
                        anchors.fill: parent
                        text: image.source == ""?"":"File recognized"
                        font.pixelSize: 18
                        anchors.leftMargin: 15
                    }

                    Image {
                        id: image
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                    }

                }
                MenuItem {
                    id: menu
                    anchors.left: parent.left
                    anchors.top: imageRectangle.bottom
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                    text: "Select a file..."
                    onTriggered: fileDialog.open()
                }

                Text {
                    id: error
                    anchors.top: menu.bottom
                    anchors.topMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    color: "yellow"
                    text: qsTr("")
                    font.pixelSize: 15
                }

                Rectangle {
                    id: createAssignmentButton
                    width: 195
                    height: 45
                    color: "#ffffff"
                    radius: 20
                    anchors.top: menu.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 100

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent

                        Text {
                            id: createAssignmentt
                            x: 67
                            y: 21
                            anchors.centerIn: parent
                            text: qsTr("Create Assignment")
                            font.pixelSize: 19
                            fontSizeMode: Text.FixedSize
                        }

                        onClicked: {
                            createAssignmentt.text = "Loading..."
                            var breakL = 0
                            var tries = 0

                            const createdImage = function(rs, st){
                                if(st === 204){
                                    error.text = "Successfully uploaded file!"
                                }
                            }

                            Service.createLogicalAssignment(newAssignment)
                        }
                    }
                }

                FileDialog{
                    id: fileDialog
                    nameFilters: [ "Documents (*.pdf)"]
                    currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                    onAccepted: {
                        image.source = selectedFile
                    }
                }

                FileUpload {
                    id: uploader

                    onComplete: {
                        if(backStatus==="204"){
                            error.text = "Successfully uploaded pdf!"
                        }
                        else{
                            error.text = "Could not upload pdf!"
                        }
                    }
                }
        }
    }
}
