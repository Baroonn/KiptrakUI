import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs
import "service.js" as Service
import "Database.js" as LocalStorage

import com.company.fileupload 1.0
import KipTrak 1.0
//CreateAssignment
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
                        Service.createImage(response.id, image.source, createdImage )
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

//                Text {
//                    id: title
//                    color: "#fff8f8"
//                    text: qsTr("Title*")
//                    anchors.left: parent.left
//                    anchors.top: createAssignmentHeading.bottom
//                    font.pixelSize: 18
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 20
//                }

//                Rectangle {
//                    id: titleRectangle
//                    height: 35
//                    color: "#fffdfd"
//                    radius: 6
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.top: title.bottom
//                    anchors.rightMargin: 20
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 10
//                    TextInput {
//                        id: titleInput
//                        color: "#020202"
//                        anchors.fill: parent
//                        font.pixelSize: 18
//                        verticalAlignment: Text.AlignVCenter
//                        leftPadding: 10
//                    }
//                }

                CreateFlickableAC{
                    id: descriptionInput
                    anchors.topMargin: 10
                    anchors.top: titleInput.bottom
                    stringDecorator: newAssignment.ui_description
                    comHeight: 100
                }

//                Text {
//                    id: description
//                    color: "#fff8f8"
//                    text: qsTr("Description*")
//                    anchors.left: parent.left
//                    anchors.top: titleInput.bottom
//                    font.pixelSize: 18
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 20
//                }

//                Rectangle {
//                    id: descriptionRectangle
//                    height: 100
//                    color: "#fffdfd"
//                    radius: 6
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.top: description.bottom
//                    anchors.rightMargin: 20
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 10

//                    Flickable {
//                          id: flick
//                          width: descriptionRectangle.width; height: descriptionRectangle.height;
//                          contentWidth: descriptionInput.contentWidth
//                          contentHeight: descriptionInput.contentHeight
//                          clip: true
//                          onContentYChanged: {
//                                      console.log("contentY:", contentY)
//                                  }
//                          function ensureVisible(r)
//                          {
//                              if (contentX >= r.x)
//                                  contentX = r.x;
//                              else if (contentX+width <= r.x+r.width)
//                                  contentX = r.x+r.width-width;
//                              if (contentY >= r.y)
//                                  contentY = r.y;
//                              else if (contentY+height <= r.y+r.height)
//                                  contentY = r.y+r.height-height;
//                          }

//                          TextEdit {
//                              id: descriptionInput
//                              color: "#020202"
//                              width: flick.width
//                              font.pixelSize: 18
//                              focus: true
//                              verticalAlignment: Text.AlignTop
//                              wrapMode: TextEdit.Wrap
//                              leftPadding: 10
//                              topPadding: 10
//                              onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
//                          }
//                    }
//                }

                CreateAssignmentComponent{
                    id: courseInput
                    anchors.topMargin: 10
                    anchors.top: descriptionInput.bottom
                    stringDecorator: newAssignment.ui_course
                    comHeight: 35
                }
//                Text {
//                    id: course
//                    color: "#fff8f8"
//                    text: qsTr("Course*")
//                    anchors.left: parent.left
//                    anchors.top: descriptionRectangle.bottom
//                    font.pixelSize: 18
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 20
//                }

//                Rectangle {
//                    id: courseRectangle
//                    height: 35
//                    color: "#fffdfd"
//                    radius: 6
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.top: course.bottom
//                    anchors.rightMargin: 20
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 10
//                    TextInput {
//                        id: courseInput
//                        color: "#020202"
//                        anchors.fill: parent
//                        font.pixelSize: 18
//                        verticalAlignment: Text.AlignVCenter
//                        leftPadding: 10
//                    }
//                }

                CreateAssignmentComponent{
                    id: teacherInput
                    anchors.topMargin: 10
                    anchors.top: courseInput.bottom
                    stringDecorator: newAssignment.ui_teacherName
                    comHeight: 35
                }
//                Text {
//                    id: teacher
//                    color: "#fff8f8"
//                    text: qsTr("Lecturer*")
//                    anchors.left: parent.left
//                    anchors.top: courseRectangle.bottom
//                    font.pixelSize: 18
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 20
//                }

//                Rectangle {
//                    id: teacherRectangle
//                    height: 35
//                    color: "#fffdfd"
//                    radius: 6
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.top: teacher.bottom
//                    anchors.rightMargin: 20
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 10
//                    TextInput {
//                        id: teacherInput
//                        color: "#020202"
//                        anchors.fill: parent
//                        font.pixelSize: 18
//                        verticalAlignment: Text.AlignVCenter
//                        leftPadding: 10
//                    }
//                }

                CreateAssignmentComponent{
                    id: dateDueInput
                    anchors.topMargin: 10
                    anchors.top: teacherInput.bottom
                    stringDecorator: newAssignment.ui_dateDue
                    comHeight: 35
                }
//                Text {
//                    id: dateDue
//                    color: "#fff8f8"
//                    text: qsTr("Date Due*")
//                    anchors.left: parent.left
//                    anchors.top: teacherRectangle.bottom
//                    font.pixelSize: 18
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 20
//                }

//                Rectangle {
//                    id: dateDueRectangle
//                    height: 35
//                    color: "#fffdfd"
//                    radius: 6
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.top: dateDue.bottom
//                    anchors.rightMargin: 20
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 10
//                    TextEdit {
//                        id: dateDueInput
//                        color: "#020202"
//                        anchors.fill: parent
//                        font.pixelSize: 18
//                        verticalAlignment: Text.AlignVCenter
//                        leftPadding: 10

//                        Text {
//                            text: "  Example. 2022-02-20"
//                            color: "#aaa"
//                            visible: !dateDueInput.text && !dateDueInput.activeFocus
//                            anchors.fill: parent
//                            verticalAlignment: Text.AlignVCenter
//                            font.pixelSize: 18
//                        }
//                    }
//                }


                CreateFlickableAC{
                    id: notesInput
                    anchors.topMargin: 10
                    anchors.top: dateDueInput.bottom
                    stringDecorator: newAssignment.ui_notes
                    comHeight: 100
                }
//                Text {
//                    id: notes
//                    color: "#fff8f8"
//                    text: qsTr("Notes")
//                    anchors.left: parent.left
//                    anchors.top: dateDueInput.bottom
//                    font.pixelSize: 18
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 20
//                }

//                Rectangle {
//                    id: notesRectangle
//                    height: 100
//                    color: "#fffdfd"
//                    radius: 6
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.top: notes.bottom
//                    anchors.rightMargin: 20
//                    anchors.leftMargin: 20
//                    anchors.topMargin: 10
//                    Flickable {
//                          id: flick2
//                          width: notesRectangle.width; height: notesRectangle.height;
//                          contentWidth: notesInput.contentWidth
//                          contentHeight: notesInput.contentHeight
//                          clip: true
//                          onContentYChanged: {
//                                      console.log("contentY:", contentY)
//                                  }
//                          function ensureVisible(r)
//                          {
//                              if (contentX >= r.x)
//                                  contentX = r.x;
//                              else if (contentX+width <= r.x+r.width)
//                                  contentX = r.x+r.width-width;
//                              if (contentY >= r.y)
//                                  contentY = r.y;
//                              else if (contentY+height <= r.y+r.height)
//                                  contentY = r.y+r.height-height;
//                          }
//                          TextEdit {
//                              id: notesInput
//                              color: "#020202"
//                              focus: true
//                              width: flick2.width
//                              font.pixelSize: 18
//                              verticalAlignment: Text.AlignTop
//                              wrapMode: TextEdit.Wrap
//                              leftPadding: 10
//                              topPadding: 10
//                              onCursorRectangleChanged: flick2.ensureVisible(cursorRectangle)
//                          }
//                    }
//                }

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
                        text: image.source == ""?"":"File Recognized"
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
                    anchors.topMargin: 70

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
                            const entry = {
                                title: newAssignment.ui_title.ui_value,
                                description: newAssignment.ui_description.ui_value,
                                course : newAssignment.ui_course.ui_value,
                                dateDue: newAssignment.ui_dateDue.ui_value,
                                teacherName: newAssignment.ui_teacherName.ui_value,
                                notes: newAssignment.ui_notes.ui_value
                            }
                            const createdImage = function(rs, st){
                                if(st === 204){
                                    error.text = "Successfully uploaded file!"
                                }
                            }

                            const createAssign = function(response, status_code){
                                console.log("Trying...")
                                createAssignmentt.text = "Create Assignment"
                                if(status_code === 201)
                                {
                                    error.text = "Successfully created assignment!"
                                    if(image.source != ""){
                                        error.text += "\nUploading File..."
                                        Service.createImage(response.id, image.source, createdImage )
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

                            //Service.createAssignment(entry, createAssign)
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
//
