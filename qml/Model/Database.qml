pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0

QtObject {

    property  var db: LocalStorage.openDatabaseSync("ttb", "1.0", "Team Toolbox", 1000000)

    function dbInit()
    {


        try {


            db.transaction(function (tx) {


                tx.executeSql('CREATE TABLE IF NOT EXISTS _group (group_id INTEGER  PRIMARY KEY, category_id INTEGER, name TEXT, type TEXT, created_date INTEGER);')
                tx.executeSql('CREATE TABLE IF NOT EXISTS item (item_id INTEGER  PRIMARY KEY,group_id INTEGER, name TEXT, created_date INTEGER);')
                tx.executeSql('CREATE TABLE IF NOT EXISTS category (category_id INTEGER  PRIMARY KEY,name TEXT, created_date INTEGER);')
                tx.executeSql('CREATE TABLE IF NOT EXISTS archive (archive_id INTEGER  PRIMARY KEY,type TEXT, name TEXT, comment TEXT, data TEXT, created_date INTEGER);')


                var results = tx.executeSql('SELECT count(*) as cnt FROM category')
                 if (parseInt(results.rows.item(0).cnt)===0){
                     //init datas
                     tx.executeSql('INSERT INTO category (name, created_date)  VALUES(?, ?)', ['Category 1', Date.now()])
                     tx.executeSql('INSERT INTO category (name, created_date)  VALUES(?, ?)', ['Category 2', Date.now()])
                     tx.executeSql('INSERT INTO category (name, created_date)  VALUES(?, ?)', ['Category 3', Date.now()])

                 }

            })
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }

    function dbReset(){
        try {
            db.transaction(function (tx) {

                tx.executeSql('DROP TABLE _group')
                tx.executeSql('DROP TABLE item')
                tx.executeSql('DROP TABLE category')
                tx.executeSql('DROP TABLE archive')
            })

            dbInit()
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }



    Component.onCompleted: {
        //dbReset()
        dbInit()
    }

}
