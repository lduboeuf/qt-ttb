shuffle = function ( array ) {
    for (var i = array.length - 1; i >= 0; i--) {

        var j = Math.floor( Math.random() * ( i + 1) );

        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

    return array;
}

badShuffle = function ( array ) {
    array.sort(function () {
        return .5 - Math.random();
    });

    return array;
}

createArrayOfArrays = function ( number_of_arrays ) {
    var array = [];
    for (var i = 0; i < number_of_arrays; i++) {
        var sub_array = {name: i, items: []};
        array.push(sub_array);
    }
    return array;
}

build = function(list){


//var list = [{id: 1, name: "ttt1"}, {id:2, name: "ttt2"}, {id:3, name: "ttt3"}, {id:4, name: "tttt4"}];
    var nbGroups = 3;

    var shuffled_array = shuffle(list);
    var final_groups = createArrayOfArrays(nbGroups);


    var current_group_number = 0;

    do {
        if ( nbGroups == (current_group_number) )
            current_group_number = 0;

        var popped = shuffled_array.pop();

        final_groups[current_group_number].items.push(popped);

        // Optional, you don't need to shuffle each time.
        // shuffled_names = durnstenfeldShuffle( shuffled_names );

        current_group_number++;
    } while ( shuffled_array.length > 0 );

    return final_groups;
}
