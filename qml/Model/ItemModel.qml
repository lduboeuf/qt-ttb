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
                console.log(results.rows.item(i).name)
                itemModel.append({
                              rowId: results.rows.item(i).item_id,
                              name: results.rows.item(i).name,
                              groupId: results.rows.item(i).group_id,

                          })
            }
        })

        return list;
    }

//    function findAllitems(pGroupId)
//    {
//        Database.db.transaction(function (tx) {
//            listModel.clear()
//            var results = tx.executeSql('SELECT * FROM item WHERE group_id = ?', [pGroupId])
//            for (var i = 0; i < results.rows.length; i++) {
//                console.log(results.rows.item(i).name)
//                listModel.append({
//                                     rowid: results.rows.item(i).item_id,
//                                     name: results.rows.item(i).name,
//                                     groupid: results.rows.item(i).group_id,

//                                 })
//            }
//        })
//    }

    function insertMember(pGroupId, pName)
    {
        var rowid = 0;
        Database.db.transaction(function (tx) {
            tx.executeSql('INSERT INTO item(group_id, name) VALUES(?, ?)',
                          [pGroupId, pName])
            var result = tx.executeSql('SELECT last_insert_rowid()')
            rowid = result.insertId
        })
        itemModel.append({
                             rowId: rowid,
                             name: pName,
                             groupId: pGroupId,

                         })
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
