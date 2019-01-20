pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "Database.js" as DB

QtObject {

    readonly property string groupTypePeoplesName: "peoples"
    readonly property string groupTypeItemsName: "items"
    readonly property string groupTypeTasksName: "tasks"

    function getImageSource(typeName)  {
        var imgSource = ""
        if (groupTypePeoplesName===typeName){
            imgSource = "../assets/contact-group.svg"
        }else if(groupTypeItemsName===typeName){
            imgSource = "../assets/items.svg"

        }else if(groupTypeTasksName===typeName){
            imgSource = "../assets/tasks.svg"

        }

       return imgSource
    }



    //groupModel is shared among several Pages
    property ListModel groupModel : ListModel {}

    function addGroup(groupName, selectedGroupType){
        var id = DB.insertGroup(groupName, selectedGroupType)
        groupModel.append({rowId: id, name: groupName, type: selectedGroupType})

    }

    function removeGroup(index){
        var data = groupModel.get(index)
        console.log("delete index:"+index)
        DB.deleteGroup(data.rowid)

        groupModel.remove(index, 1)

    }

    function updateGroup(index, rowId, name, type){
        var data = groupModel.get(index)
        DB.updateGroup(rowId, name, type)
        data.name = name
        data.type = type
    }

      Component.onCompleted:{
        groupModel.clear()
        var groupList = DB.findGroups()
        for (var i= 0; i < groupList.length; i++){
            console.log(groupList[i])
            groupModel.append(groupList[i])
        }

    }
}
