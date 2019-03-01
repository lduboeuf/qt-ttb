pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "."

QtObject {


    property ListModel itemModel : ListModel {}



    function buildModel(pGroupId)
    {
        itemModel.clear()
        var list = []
        Database.db.transaction(function (tx) {
            var results = tx.executeSql('SELECT * FROM item WHERE group_id = ?', [pGroupId])
            for (var i = 0; i < results.rows.length; i++) {
                //console.log(results.rows.item(i).name)
                itemModel.append({
                              rowId: results.rows.item(i).item_id,
                              name: results.rows.item(i).name,
                              groupId: results.rows.item(i).group_id,
                              createdDate: results.rows.item(i).created_date,
                              selected: false
                          })
            }
        })

        return list;
    }

    function findAllitems(pGroupIds)
    {
        var items = [];
        Database.db.transaction(function (tx) {
            var results = tx.executeSql('SELECT * FROM item WHERE group_id IN (' + pGroupIds.toString() +')')
            for (var i = 0; i < results.rows.length; i++) {
                console.log(results.rows.item(i).name)
                items[i] = {
                     rowId: results.rows.item(i).item_id,
                     name: results.rows.item(i).name,
                     groupId: results.rows.item(i).group_id,
                     createdDate: results.rows.item(i).created_date,
                       selected: false
                 }

            }
        })
        return items;
    }

    function insertMember(pGroupId, pName)
    {
        var rowid = 0;
        Database.db.transaction(function (tx) {
            tx.executeSql('INSERT INTO item(group_id, name, created_date) VALUES(?, ?, strftime(\'%s\',\'now\'))',
                          [pGroupId, pName])
            var result = tx.executeSql('SELECT last_insert_rowid()')
            rowid = parseInt(result.insertId)
        })
        itemModel.append({
                             rowId: rowid,
                             name: pName,
                             groupId: pGroupId,
                             createdDate: Date.now()
                         })
    }

    function insertMembers(pGroupId, pNames)
    {
        for (var i=0; i < pNames.length; i++){
            insertMember(pGroupId, pNames[i])
        }
    }


    function updateMember(index, pId, pName)
    {
        var data = itemModel.get(index)

        Database.db.transaction(function (tx) {
            tx.executeSql(
                        'update item set name=? where item_id = ?', [pName, pId])
        })

        data.name = pName

    }

    function deleteMember(index)
    {
        var data = itemModel.get(index)
        Database.db.transaction(function (tx) {
            console.log("delete rowid:" + data.rowId)
            tx.executeSql('delete from item where item_id = ?', [data.rowId])
        })

        itemModel.remove(index, 1)
    }



    Component.onCompleted:{

    }
}
