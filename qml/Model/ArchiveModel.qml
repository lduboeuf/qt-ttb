pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "."

QtObject {


    property ListModel itemModel : ListModel {}


    function sortModel()
    {
        for(var i=0; i<itemModel.count; i++)
        {
            for(var j=0; j<i; j++)
            {
                if(itemModel.get(i).type === itemModel.get(j).type)
                    itemModel.move(i,j,1)
                break
            }
        }
    }


    function parseItem(row){
        return {
            rowId: row.archive_id,
            type: row.type,
            name: row.name,
            createdDate: row.dt
           }
    }

    function buildModel()
    {
        itemModel.clear()
        var list = findAll()
        for (var i = 0; i < list.length; i++) {
            itemModel.append(list[i])
        }

    }

    function findAll()
    {
        var items = [];
        Database.db.transaction(function (tx) {
            var results = tx.executeSql('SELECT archive_id, type, name, created_date FROM archive ORDER BY type, created_date DESC')
            for (var i = 0; i < results.rows.length; i++) {
                console.log(results.rows.item(i).name)
                items[i] = parseItem(results.rows.item(i))
            }
        })
        return items;
    }

    function findById(pArchiveId){
        var item = null
        Database.db.transaction(function (tx) {
            var results = tx.executeSql('SELECT *, datetime(created_date, \'unixepoch\', \'localtime\') as dt FROM archive WHERE archive_id = ?', pArchiveId)
            if (results.rows.length > 0) {
                item = parseItem(results.rows.item(0))
                item.data = JSON.parse(results.rows.item(0).data)
            }


        })
        return item;
    }

    function save(pType, pName, pData)
    {
        var rowid = 0;
        Database.db.transaction(function (tx) {
            tx.executeSql('INSERT INTO archive(type, name, data, created_date) VALUES(?, ?, ?, strftime(\'%s\',\'now\'))',
                          [pType, pName, JSON.stringify(pData)])
            var result = tx.executeSql('SELECT last_insert_rowid()')
            rowid = parseInt(result.insertId)
        })
        itemModel.append({
                             rowId: rowid,
                             type: pType,
                             name: pName,
                             data: pData,
                             createdDate: Date.now()
                         })

        sortModel()
    }

    function remove(index){
        var data = itemModel.get(index)
        console.log("delete index:"+index)
        Database.db.transaction(function (tx) {
            tx.executeSql('delete from archive where archive_id = ?', [data.rowId])
        })

        itemModel.remove(index, 1)

    }


    Component.onCompleted:{
        buildModel()
    }
}

