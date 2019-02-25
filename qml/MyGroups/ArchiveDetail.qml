import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1
import "../Model"
import "../Components"



Page {
    id: toolBuildSelect
    title: qsTr("Archive Detail")

    header:NavigationBar{
        id: navBar
        subtitle: qsTr("Result")
    }

    property int archiveId: 0

    onArchiveIdChanged:  {
        var item = ArchiveModel.findById(archiveId)
        if (item !== null){
            resultList.model.clear()
            for (var i=0; i < item.data.length; i++){
                resultList.model.append(item.data[i])
            }
            //var dateString = (new Date(item.createdDate)).toLocaleDateString();
            //navBar.subtitle = item.name + " (" + Date.fromLocaleDateString(dateString) + ")"
            navBar.subtitle = item.name + " (" + item.createdDate + ")"
        }
    }




    ListView {
        id:resultList
        anchors.fill: parent
        anchors.margins: 16
        anchors.topMargin: 20


        model: ListModel{

        }
        delegate:

            ItemDelegate{
                text: name
                hoverEnabled: false
                enabled: false
               // iconSource : ""
                //swipe.enabled: false

        }

        section {
            property: "groupName"
            criteria: ViewSection.FullString
            delegate: Text {
                topPadding: 16
                color:Material.foreground
                opacity: 0.6
                text: section


                Rectangle {
                    color: "lightgrey"
                    width: resultList.width
                    anchors.top: parent.bottom
                    height: 1

                }
            }
        }

        ScrollBar.vertical: ScrollBar {}

    }




}
