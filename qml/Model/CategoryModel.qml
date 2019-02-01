pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "."
//import "./Database.js" as DB

QtObject {


    property ListModel categoryModel : ListModel {}

    function add(categName){

        var rowid = 0;
        Database.db.transaction(function (tx) {
            tx.executeSql('INSERT INTO category(name, created_date) VALUES(?,  ?)',
                          [categName,  Date.now()])
            var result = tx.executeSql('SELECT last_insert_rowid()')
            rowid = parseInt(result.insertId)
        })
        console.log("id"+ rowid)

        categoryModel.append({rowId: rowid, name: categName, createdDate: Date.now()})

        return rowid

    }

    function remove(index){
        var data = categoryModel.get(index)
        console.log("delete index:"+index)
        Database.db.transaction(function (tx) {
            tx.executeSql('delete from category where category_id = ?', [data.rowId])
        })

        categoryModel.remove(index, 1)
        GroupModel.buildModel()

    }

    function update(index, rowId, name){
        var data = categoryModel.get(index)

        Database.db.transaction(function (tx) {
            console.log("update rowId:"+rowId + " with name:" + name)

            tx.executeSql(
                        'update category set name=? where category_id = ?', [name, rowId])
        })

        data.name = name

        GroupModel.buildModel()
    }

    function buildModel(){
        categoryModel.clear()

         Database.db.transaction(function (tx) {

            var results = tx.executeSql('SELECT * FROM category')
            for (var i = 0; i < results.rows.length; i++) {
                console.log("ID"+ results.rows.item(i).category_id + " name"+ results.rows.item(i).name)
                categoryModel.append({
                     rowId: results.rows.item(i).category_id,
                     name: results.rows.item(i).name,
                     createdDate: results.rows.item(i).created_date
                 })
            }
        })

    }



      Component.onCompleted:{
        buildModel()


    }
}
