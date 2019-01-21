pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0

QtObject {

    property  var db: LocalStorage.openDatabaseSync("ttb", "1.0", "Team Toolbox", 1000000)

    function dbInit()
    {

        try {
            db.transaction(function (tx) {
                //tx.executeSql('DROP TABLE _group')
                //tx.executeSql('DROP TABLE member')

                tx.executeSql('CREATE TABLE IF NOT EXISTS _group (group_id INTEGER  PRIMARY KEY,name TEXT, type TEXT);')
                tx.executeSql('CREATE TABLE IF NOT EXISTS item (item_id INTEGER  PRIMARY KEY,group_id INTEGER, name TEXT);')

            })
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }



    Component.onCompleted: {
        dbInit()
    }

}
