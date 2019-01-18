function dbInit()
{
    var db = LocalStorage.openDatabaseSync("ttb", "1.0", "Team Toolbox", 1000000)
    try {
        db.transaction(function (tx) {
            //tx.executeSql('DROP TABLE groups')
            //tx.executeSql('DROP TABLE members')

            tx.executeSql('CREATE TABLE IF NOT EXISTS groups (group_id INTEGER  PRIMARY KEY,name TEXT);')
            tx.executeSql('CREATE TABLE IF NOT EXISTS members (member_id INTEGER  PRIMARY KEY,group_id INTEGER, name TEXT);')

        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("ttb", "1.0",
                                               "Team Toolbox", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function insertGroup(pName)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO groups(name) VALUES(?)',
                      [pName])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

function findAllGroups()
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        listModel.clear()
        var results = tx.executeSql('SELECT * FROM groups')
        for (var i = 0; i < results.rows.length; i++) {
            console.log(results.rows.item(i).name)
            listModel.append({
                 rowid: results.rows.item(i).group_id,
                 name: results.rows.item(i).name

             })
        }
    })
}

function updateGroup(pId, pName)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql(
                    'update groups set name=? where group_id = ?', [pName, pId])
    })
}

function deleteGroup(pId)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        console.log("delete rowid:" + pId)
        tx.executeSql('delete from groups where group_id = ?', [pId])
    })
}



function findAllMembers(pGroupId)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        listModel.clear()
        var results = tx.executeSql('SELECT * FROM members WHERE group_id = ?', [pGroupId])
        for (var i = 0; i < results.rows.length; i++) {
            console.log(results.rows.item(i).name)
            listModel.append({
                 rowid: results.rows.item(i).member_id,
                 name: results.rows.item(i).name,
                 groupid: results.rows.item(i).group_id,

             })
        }
    })
}

function insertMember(pGroupId, pName)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO members(group_id, name) VALUES(?, ?)',
                      [pGroupId, pName])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

function updateMember(pId, pName)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql(
                    'update members set name=? where member_id = ?', [pName, pId])
    })
}

function deleteMember(pId)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        console.log("delete rowid:" + pId)
        tx.executeSql('delete from members where member_id = ?', [pId])
    })
}
