pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "."
//import "./Database.js" as DB

QtObject {

    readonly property string groupTypePeoplesName: "peoples"
    readonly property string groupTypeItemsName: "items"
    readonly property string groupTypeTasksName: "tasks"

    function getImageSource(typeName)  {
        var imgSource = ""
        if (groupTypePeoplesName===typeName){
            imgSource = "/assets/contact-group.svg"
        }else if(groupTypeItemsName===typeName){
            imgSource = "/assets/items.svg"

        }else if(groupTypeTasksName===typeName){
            imgSource = "/assets/tasks.svg"

        }

       return imgSource
    }



    //groupModel is shared among several Pages
    property ListModel groupModel : ListModel {}

    function addGroup(newData){
        //var id = DB.insertGroup(groupName, selectedGroupType)
        var rowid = 0;
        Database.db.transaction(function (tx) {
            tx.executeSql('INSERT INTO _group(name, type, created_date, category_id) VALUES(?, ?, ?, ?)',
                          [newData.name, newData.type, Date.now(), newData.categoryId])
            var result = tx.executeSql('SELECT last_insert_rowid()')
            rowid = parseInt(result.insertId)
        })
        console.log("id"+ rowid)
        newData.rowId = rowid
        newData.createdDate = Date.now()

        groupModel.append(newData)

        return rowid

    }

    function removeGroup(index){
        var data = groupModel.get(index)
        console.log("delete index:"+index)
        Database.db.transaction(function (tx) {
            tx.executeSql('delete from _group where group_id = ?', [data.rowId])
        })

        groupModel.remove(index, 1)

    }

    function updateGroup(index, newData){
        var data = groupModel.get(index)

        Database.db.transaction(function (tx) {
            tx.executeSql(
                        'update _group set name=?, type=?, category_id=? where group_id = ?', [newData.name, newData.type, newData.rowId, newData.categoryId])
        })

        groupModel.set(index, newData)

    }

    function buildModel(){
        groupModel.clear()

         Database.db.transaction(function (tx) {

            var results = tx.executeSql('SELECT group_id, _group.name as groupName, type, _group.category_id as categoryId, category.name as categoryName FROM _group LEFT JOIN category ON _group.category_id = category.category_id')
            for (var i = 0; i < results.rows.length; i++) {
                //console.log(results.rows.item(i).name + " - " + results.rows.item(i).type)
                groupModel.append({
                     rowId: results.rows.item(i).group_id,
                     name: results.rows.item(i).groupName,
                     type: results.rows.item(i).type,
                     createdDate: results.rows.item(i).created_date,
                     categoryId: results.rows.item(i).categoryId,
                     categoryName: results.rows.item(i).categoryName

                 })
            }
        })

    }



      Component.onCompleted:{
        buildModel()

//        var groupList = DB.findGroups()
//        for (var i= 0; i < groupList.length; i++){
//            console.log(groupList[i])
//            groupModel.append(groupList[i])
//        }

    }
}
