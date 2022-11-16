.import QtQuick.LocalStorage 2.0 as Sql

function dbInit()
{

var db = Sql.LocalStorage.openDatabaseSync("Database", "", "KipTrak", 1000000)
try {
    db.transaction(function (tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS authData (username text, password text, token text)')
    tx.executeSql('CREATE TABLE IF NOT EXISTS assignment (id text, title text, description text, notes text, course text, teacherName text, dateDue text, createdAt text, username text, status text)')
//tx.executeSql('CREATE TABLE IF NOT EXISTS products_expenditure (rowid INTEGER PRIMARY KEY AUTOINCREMENT, category text, name text, default_amount numeric)')
})
    console.log("Database created")
} catch (err) {
console.log("Error creating table in database: " + err)
};
}

function dbGetHandle()
{
try {
var db = Sql.LocalStorage.openDatabaseSync("Database", "", "KipTrak", 1000000)
} catch (err) {
console.log("Error opening database: " + err)
}
return db
}

function dbSyncAssignment(json){
    console.log("In dbSyncAssignment")
    var ids = json.map(function(x){
        return x.id
    }
        )
    //Change overdue assignments
    var savedAssignments = dbGetAssignments()
    var savedAssignmentscount = dbGetAssignmentCount()
    var savedIds=[]
    for(var i = 0; i<savedAssignmentscount; i++){
        savedIds.push(savedAssignments.item(i).id)
        if(ids.indexOf(savedAssignments.item(i).id)===-1){
            dbUpdateAssignmentStatus("Overdue", savedAssignments.item(i).id)
        }
    }

    //Add new assignments
    console.log(json.length)
    for(var j =0; j<json.length;j++){
        console.log(json[j].id)
        if(savedIds.indexOf(json[j].id)===-1){
            console.log("new entry")

            var entry = json[j]
            console.log(json[j].id)
            dbSetAssignment(entry, 'New')
        }
    }
    console.log("Left dbSyncAssignment")
}
function dbGetAssignments(){
    console.log("In dbGetAssigments")
    var db = dbGetHandle()
    var assignments = ""
    db.transaction(function(tx){
        var data = tx.executeSql("SELECT * FROM assignment WHERE status = 'Completed' or status = 'New' ORDER BY createdAt desc")
        assignments = data.rows
    })
    console.log("Left dbGetAssignments")
    return assignments
}

function dbSetAssignment({id, title, description, notes, course, teacherName, dateDue, createdAt, username}, status){
    var db = dbGetHandle()
    var rowid = 0
    db.transaction(function(tx){
        tx.executeSql('INSERT INTO assignment(id, title, description, notes, course, teacherName, dateDue, createdAt, username, status) VALUES (?,?,?,?,?,?,?,?,?,?)', [id, title, description, notes, course, teacherName, dateDue, createdAt, username, status])
        console.log("Assignment Created")
    }
        )
}

function dbUpdateAssignmentStatus(status, id){
    var db = dbGetHandle()
    var rowid = 0
    db.transaction(function(tx){
        tx.executeSql(`UPDATE assignment SET status = '${status}' WHERE id='${id}'`)
    }
        )
}

function dbSetAuthData(username, password, token)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
    tx.executeSql('DELETE FROM authData')
    tx.executeSql('INSERT INTO authData(username, password, token) VALUES( ?, ?, ?)', [username, password, token])
        console.log(JSON.stringify(tx.executeSql(`SELECT * FROM authData`)))
    })
        console.log("Data created")

}
function dbGetAssignmentCount()
{
    var db = dbGetHandle()
    var count = 0
    db.transaction(function (tx) {
        var data = tx.executeSql(`SELECT COUNT(*) as count FROM assignment WHERE status = 'Completed' or status = 'New'`)
        console.log(JSON.stringify(data.rows.item(0).count))
        count = data.rows.item(0).count
    })

    return count
}

function dbGetAuthDataCount()
{
    var db = dbGetHandle()
    var count = 0
    db.transaction(function (tx) {
        var data = tx.executeSql(`SELECT COUNT(*) as count FROM authData`)
        console.log(JSON.stringify(data.rows.item(0).count))
        count = data.rows.item(0).count
    })

    return count
}

function dbGetToken()
{
    var token = ""
    var db = dbGetHandle()
    db.transaction(function(tx){
        var data = tx.executeSql('SELECT token FROM authData')
        if(data.rows.item(0) !== undefined)
        {
            token = data.rows.item(0).token
        }
    }
    )

    return token
}

function dbGetUserDetails()
{
    var details = ""
    var db = dbGetHandle()
    db.transaction(function(tx){
        var data = tx.executeSql('SELECT username, password FROM authData')
        details = data.rows.item(0).username + "&" + data.rows.item(0).password
    })

    return details
}
