import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml
import "service.js" as Service
import "Database.js" as LocalStorage
import KipTrak 1.0

Item {
    width: parent.width
    height: parent.height

    Rectangle{
        anchors.fill: parent
        color: "#F5F5F4"

        FontLoader{
            id: webFont
            source: "qrc:/solidFonts.otf"
        }

        FontLoader{
            id: netWebFont
            source: "qrc:/Lato.ttf"
        }

        Connections{
            target: masterController.ui_webRequest
            onRequestComplete: function(status_code, response){
                error.text = ""
                drawer.close()
                if(status_code === 200)
                {
                    var pendingCount = 0
                    var completedCount = 0
                    model.clear()
                    response = JSON.parse(response.toString())
                    console.log("Got In")
                    LocalStorage.dbSyncAssignment(response)
                    var count = LocalStorage.dbGetAssignmentCount()
                    var assignments = LocalStorage.dbGetAssignments()
                    for(var i = 0; i<count; i++){
                        var x = assignments.item(i)
                            listView.model.append({
                                                      titleText: x.title.length <= 30? x.title : (x.title.substring(0,30)+"..."),
                                                      dueDateText: x.dateDue.split('T')[0],
                                                      teacherText: x.teacherName,
                                                      courseText: x.course,
                                                      assignIdText: x.id,
                                                      descText: x.description,
                                                      notesText: x.notes,
                                                      actualTitleText: x.title,
                                                      createdByText: x.username,
                                                      createdAtText: x.createdAt.split('T')[0]
                                                  })
                        if(x.status === "New"){
                            pendingCount++;
                        }
                        else if (x.status==="Completed"){
                            completedCount++;
                        }

                    }

                    //pendingLabel.text = "Pending \n"+pendingCount
                    pendingText.text = pendingCount
                    //completedLabel.text = "Completed \n"+completedCount
                    completedText.text = completedCount
                    busyIndicator.visible = false
                }
                else if(status_code === 401)
                {
                    var userdetails = LocalStorage.dbGetUserDetails()
                    const userentry = {
                        userName : userdetails.split("&")[0],
                        password : userdetails.split("&")[1]
                    }

                    Service.login(userentry, function(res, status){
                        if(status === 200){
                            console.log(res.token)
                            LocalStorage.dbSetAuthData(userdetails.split("&")[0], userdetails.split("&")[1], res.token)
                            Service.getAssignments()
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
                    model.clear()
                    pendingCount = 0
                    completedCount = 0
                    console.log("Got In")
                    count = LocalStorage.dbGetAssignmentCount()
                    assignments = LocalStorage.dbGetAssignments()
                    for(var a = 0; a<count; a++){
                        x = assignments.item(a)
                            listView.model.append({
                                                      titleText: x.title.length <= 30? x.title : (x.title.substring(0,30)+"..."),
                                                      dueDateText: x.dateDue.split('T')[0],
                                                      teacherText: x.teacherName,
                                                      courseText: x.course,
                                                      assignIdText: x.id,
                                                      descText: x.description,
                                                      notesText: x.notes,
                                                      actualTitleText: x.title,
                                                      createdByText: x.username,
                                                      createdAtText: x.createdAt.split('T')[0],
                                                      statusText: x.status
                                                  })
                        if(x.status === "New"){
                            pendingCount++;
                        }
                        else if (x.status==="Completed"){
                            completedCount++;
                        }

                    }
                    pendingText.text = pendingCount
                    completedText.text = completedCount
                    busyIndicator.visible = false
                    error.text = "Error syncing your assignments"
                }
            }
        }

        ListModel{
            id: model
        }
        Rectangle{
            id: dashboard
            width: parent.width
            color: "#1C4A5A"
            height: 80
            Label{
                id: greeting
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: "white"
                font.pixelSize: 30
                font.family: netWebFont.name
                text: "Hi, " + LocalStorage.dbGetUserDetails().split("&")[0]
                font.bold: true
            }

            Label{
                id: dated
                text: new Date().toLocaleString(Qt.locale(),"dddd, dd MMMM")
                anchors.top: parent.top
                anchors.topMargin: 50
                anchors.left: parent.left
                anchors.leftMargin: 10
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                font.italic: true
                height: 15
                color: "white"
            }
        }

        Flickable{
            id: stats
            width: parent.width
            height: 100
            contentWidth: (parent.width *2) + 20
            contentHeight: 100
            anchors.top: dashboard.bottom
            //anchors.topMargin: 27
            anchors.left: parent.left
            //anchors.leftMargin: 10
            boundsMovement: Flickable.StopAtBounds
            z:99
            Rectangle{
                color: "#1C4A5A"
                anchors.fill: parent
                height: 100
                z:99
                RowLayout{
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.margins: 10
                    spacing: 15
                    width: parent.width
                    height: 100

                        Rectangle{
                            id: pending
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignLeft
                            height: 100
                            width: parent.width/2 - 25
                            color: "#ED7014"
                            radius: 6
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            z:2
                            Label{
                                id: pendingLabel
                                text: "Pending \n" + pendingText.text
                                font.pixelSize: 25
                                color: "white"
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text{
                                id: pendingText
                                visible: false
                            }
                        }

                        Rectangle{
                            id: completed
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignLeft
                            height: 100
                            width: parent.width/2 -25
                            color: "#FA8128"
                            radius: 6
                            z:2
                            Label{
                                id: completedLabel
                                text: "Completed \n" + completedText.text
                                font.pixelSize: 25
                                color: "white"
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text{
                                id: completedText
                                visible: false
                            }
                        }
                }
            }
        }
        Rectangle{
            id: middle
            width: parent.width
            height: 45
            color: "#1C4A5A"
            anchors.top: stats.bottom
            anchors.topMargin: -25
            z: 50
            radius: 50
        }

        ListView{
            Rectangle{
                anchors.fill: parent
                color: "#F5F5F4"
                z:-99
                anchors.top: parent.top
                anchors.topMargin: 80
            }

            id: listView
            anchors.top: middle.bottom
            anchors.topMargin: -20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: errorRect.top

            model: model
            header:Rectangle{
                id: headerListView
                z:99
                height: 80
                width: parent.width
                //color: "#F5F5F4"
                gradient: Gradient{
                    GradientStop{position: 0.8; color: "#F5F5F4"}
                    GradientStop{position: 1.0; color:"#00F5F5F4"}
                }

                Label{
                    id: headerLabel
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Your Assignments"
                    color: "#1C4A5A"
                    font.pixelSize: 25
                    font.family: netWebFont.name
                    z:2
                }


            }

            headerPositioning: ListView.OverlayHeader
            delegate: MouseArea{
                width: parent.width
                height: 100
                Rectangle{
                    anchors.fill: parent
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.topMargin: 5
                    anchors.bottomMargin: 5
                    //color: "#D6DCDC"
                    color: "white"
                    radius: 6
                    Label{
                        id: title
                        text: titleText
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        font.pixelSize: 20
                        //color: "white"
                        height: 35
                        clip: true
                        opacity: 1
                        font.family: netWebFont.name
                    }

                    Label{
                        id:actualTitle
                        text: actualTitleText
                        visible: false
                    }

                    Label{
                        id: assignId
                        text: assignIdText
                        visible: false
                        color: "black"

                    }
                    Label{
                        id: status
                        text: statusText
                        visible: false
                        color: "black"
                    }

                    Label{
                        id: course
                        text: courseText
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.top: title.bottom
                        color: "#aaa"
                        height: 25
                        opacity: 1
                    }

                    Label {
                        id: teacher
                        text: teacherText
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.top: course.bottom
                        color: "#aaa"
                        height: 25
                        opacity: 1
                    }
                    Rectangle{
                        id: daysLeftRectangle
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        width: 100
                        height: 25
                        color: "#FAF9F6"
                        radius: 5
                        Label{
                            id: dueDate
                            text: {
                                const currentDate = new Date();
                                const d = dueDateText.split('-');
                                const dueDated = new Date(`${d[1]}/${d[2]}/${d[0]}`);
                                var daysLeft = Math.floor((dueDated.getTime() - currentDate.getTime())/(1000*60*60*24));
                                if(daysLeft<1){
                                    dueDate.color = "#FC6A03"
                                }
                                if(daysLeft<0){
                                    daysLeft=0;
                                }

                                return `${daysLeft} ${daysLeft==1?"day":"days"} left`;
                            }
                                //"Due: \n" + dueDateText
                            anchors.centerIn: parent
                            color: "#90EE90"
                            opacity: 1
                        }
                    }


                    Label{
                        id:due
                        text: dueDateText
                        visible: false
                    }

                    Label{
                        id: description
                        text: descText
                        visible: false
                    }

                    Label{
                        id: notes
                        text: notesText
                        visible:false
                    }

                    Label{
                        id: createdBy
                        text: createdByText
                        visible: false
                    }

                    Label{
                        id: createdAt
                        text: createdAtText
                        visible: false
                    }

                }

//                CheckBox{
//                    id:checkBox
//                    checked: status.text === "Completed" ? true : false
//                    checkState: status.text === "Completed"? Qt.Checked:Qt.Unchecked
//                    checkable: true
//                    anchors.right: parent.right
//                    anchors.rightMargin:10
//                    onClicked: {
//                        console.log(checkBox.checked)
//                        if(checkBox.checked){
//                            LocalStorage.dbUpdateAssignmentStatus("Completed", assignId.text)
//                        }
//                        else{
//                            LocalStorage.dbUpdateAssignmentStatus("New", assignId.text)
//                        }

//                    }
//                }

                Text{
                    id: customCheckBox
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    font{
                        family: webFont.name
                        pixelSize: 25
                    }
                    text: status.text === "Completed"? "\uf058" : "\uf111"
                    color: "#1C4A5A"
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            console.log(assignId.text)
                            if(customCheckBox.text === "\uf058"){
                                LocalStorage.dbUpdateAssignmentStatus("New", assignId.text)
                                customCheckBox.text = "\uf111"
                                var a = parseInt(pendingText.text)
                                pendingText.text = ++a
                                var b = parseInt(completedText.text)
                                completedText.text = --b
                            }
                            else{
                                LocalStorage.dbUpdateAssignmentStatus("Completed", assignId.text)
                                customCheckBox.text = "\uf058"
                                a = parseInt(pendingText.text)
                                pendingText.text = --a
                                b = parseInt(completedText.text)
                                completedText.text = ++b
                            }
                        }
                    }

                }

                onClicked: {
                    //masterController.ui_navigationController.goViewAssignment(assignment.toJson())
                    getAssignment.listModel.clear()
                    getAssignment.listModel.append({
                                                       myLabel: "Title: ",
                                                       myText: actualTitle.text
                                                   })
                    getAssignment.listModel.append({
                                                       myLabel: "Description: ",
                                                       myText: description.text
                                                   })
                    getAssignment.listModel.append({
                                                       myLabel: "Course ",
                                                       myText:course.text
                                                   })
                    getAssignment.listModel.append({
                                                       myLabel:"Lecturer: " ,
                                                       myText:teacher.text
                                                   })
                    getAssignment.listModel.append({
                                                       myLabel:"Date Due: " ,
                                                       myText:due.text
                                                   })
                    getAssignment.listModel.append({
                                                       myLabel:"Notes: " ,
                                                       myText:notes.text
                                                   })
                    getAssignment.listModel.append({
                                                       myLabel:"Created By:  " ,
                                                       myText: createdBy.text
                                                   })
                    getAssignment.listModel.append({
                                                       myLabel:"Created At:  " ,
                                                       myText: createdAt.text
                                                   })
                    getAssignment.contentId = assignId.text
//                    getAssignment.contentCreated = created.text
                    deleteError.text = ""
                    drawer.open()
                }
            }
        }
        Rectangle{
            id:errorRect
            width: parent.width
            anchors.bottom: parent.bottom
            color: "#F5F5F4"
            height: 30
            Label{
                id: error
                text: ""
                color: "red"
                anchors.centerIn: parent
                z:199
            }
        }

        BusyIndicator{
            id: busyIndicator
            width: 35

            ColorAnimation {
                from: "blue"
                to: "black"
                duration: 200
            }
            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
        }


        Drawer{
            id: drawer
            width: parent.width
            height: parent.height
            edge: Qt.BottomEdge
            interactive: false
            background: Rectangle{
                color: "#F5F5F4"//#F5F5F4
                anchors.fill: parent
            }
            GetAssignmentPage{
                id: getAssignment
                anchors.top: parent.top
                anchors.bottom: deleteError.top
            }
            Label{
                id: deleteError
                anchors.bottom: drawerFooter.top
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.Wrap
                color: "yellow"
            }
            Rectangle{
                id: drawerFooter
                width: parent.width
                anchors.bottom: parent.bottom
                height: 65
                color: "#F5F5F4"
                Rectangle{
                    id: closeButton
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.right: downloadButton.left
                    anchors.rightMargin: 10
                    height: 40
                    color: "orange"
                    radius: 5
                    width: parent.width/3.4
                    Text{
                        text: "CLOSE"
                        font.family: "Helvetica"
                        color: "white"
                        anchors.centerIn: parent
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            drawer.close()
                        }
                    }

                }

                Rectangle{
                    id: downloadButton
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.right: deleteButton.left
                    anchors.rightMargin: 10
                    height: 40
                    color: "blue"
                    radius: 5
                    width: parent.width/3.4
                    Text{
                        text: "VIEW FILE"
                        font.family: "Helvetica"
                        color: "white"
                        anchors.centerIn: parent
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            //downloader.doDownload(getAssignment.contentId)
                            Qt.openUrlExternally("https://kiptrak.blob.core.windows.net/images/" + getAssignment.contentId + ".pdf")
                        }
                    }

                }

                Rectangle{
                    id: deleteButton
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    height: 40
                    color: "red"
                    radius: 5
                    width: parent.width/3.4
                    Text{
                        color: "white"
                        font.family: "Helvetica"
                        text: "DELETE"
                        anchors.centerIn: parent
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            const deleteAssignsCallback = function(response, status){
                                if(status===204){
                                    Service.getAssignments()
                                }
                                else{
                                    deleteError.text = "You cannot delete this assignment."
                                }
                            }

                            var endpoint = getAssignment.contentId
                            Service.deleteAssignment(`assignments/${endpoint}`, deleteAssignsCallback)
                            //Service.getAssignments()
                        }
                    }

                }
            }

        }

    }

    Component.onCompleted: {
        Service.getAssignments()
    }
}
