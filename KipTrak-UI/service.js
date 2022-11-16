.import "Database.js" as Storage

function request(verb, endpoint, obj, cb) {
    console.log('request: ' + verb + ' ' + 'https://kiptrak.azurewebsites.net/api' + (endpoint ? '/' + endpoint : ''))
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function() {
        print('xhr: on ready state change: ' + xhr.readyState)
        if(xhr.readyState === XMLHttpRequest.DONE) {
            if(cb) {
                var res = ""
                try{
                    res = JSON.parse(xhr.responseText.toString())
                }
                catch (ex){

                }
                if(endpoint !== "auth/login" && xhr.status==401)
                {

                }

                cb(res, xhr.status)
            }
        }
    }
    xhr.open(verb, 'https://kiptrak.azurewebsites.net/api' + (endpoint ? '/' + endpoint : ''))
    xhr.setRequestHeader('Content-Type', 'application/json')
    xhr.setRequestHeader('Accept', 'application/json')
    xhr.setRequestHeader("Authorization", `Bearer ${Storage.dbGetToken()}`)
    var data = obj ? JSON.stringify(obj) : ''
    xhr.send(data)
}

function getUsers(searchTerm,cb) {
    // GET http://kiptrak.azurewebsites.net/Assignments
    request('GET', `users?searchTerm=${searchTerm}`, null, cb)
}

function getFollowing(cb){
    request('GET', 'users/following', null, cb)
}

function createUser(entry, cb) {
    // POST http://kiptrak.azurewebsites.net/Assignments
    request('POST', 'auth/register', entry, cb)
}

function login(entry, cb){
    request('POST', 'auth/login', entry, cb)
}

function getAssignments(cb) {
    // GET http://kiptrak.azurewebsites.net/Assignments
    //request('GET', "assignments", null, cb)
    masterController.ui_webRequest.getAssignments(Storage.dbGetToken())
}

function createAssignment(entry, cb) {
    // POST http://kiptrak.azurewebsites.net/Assignments
    request('POST', "assignments", entry, cb)
}

function createLogicalAssignment(assignment){
    masterController.ui_webRequest.createAssignment(assignment, Storage.dbGetToken())
}

function deleteLogicalAssignment(id){
    masterController.ui_webRequest.deleteAssignment(Storage.dbGetToken(), id)
}

function createImage(id, file){
    uploader.postFile(`https://kiptrak.azurewebsites.net/api/assignments/${id}/uploadimage`,file, Storage.dbGetToken(), "form-data; name=\"file\"")
}


function getAssignment(name, cb) {
    // GET http://kiptrak.azurewebsites.net/Assignments/${name}
    request('GET', name, null, cb)
}

function deleteAssignment(name, cb) {
    // DELETE http://kiptrak.azurewebsites.net/Assignments/${name}
    request('DELETE',name , null, cb)
}

function followUser(name, cb){
    request('GET',name , null, cb)
}
