 function shuffle( array ) {
    for (var i = array.length - 1; i >= 0; i--) {

        var j = Math.floor( Math.random() * ( i + 1) );

        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

    return array;
}


var groupListNames = ["Team1", "Team2", "Team3", "Team4" ];

function build(list, nbItems){

    var nbGroups = Math.floor(list.length/nbItems) + (list.length % nbItems)

    var shuffled_array = shuffle(list);

    var k = 0;
    for (var i=0; i < nbGroups; i++){

        var groupName = groupListNames[i];

        for (var j=0; j < nbItems; j++){
            shuffled_array[k].groupName = groupName;
            k++;
            if (k>=shuffled_array.length) break;
        }

    }
    return shuffled_array;
}


