 function shuffle( array ) {
    for (var i = array.length - 1; i >= 0; i--) {

        var j = Math.floor( Math.random() * ( i + 1) );

        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

    return array;
}


var groupListName = "Team"

function build(list, nbItems){

    var groupToAdd = (list.length % nbItems > 0)  ? 1: 0
    var nbGroups = Math.floor(list.length/nbItems) + groupToAdd

    var shuffled_array = shuffle(list);

    var k = 0;
    for (var i=0; i < nbGroups; i++){

        //var groupName = groupListNames[i];
        var groupName = groupListName + " " + (i +1)

        for (var j=0; j < nbItems; j++){
            shuffled_array[k].groupName = groupName;
            k++;
            if (k>=shuffled_array.length) break;
        }

    }
    return shuffled_array;
}


