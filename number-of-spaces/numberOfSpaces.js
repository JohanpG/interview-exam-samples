var readline = require('readline');
var rl = readline.createInterface(process.stdin, process.stdout);

// Accept the data line by line and print as it is
rl.on('line', function(line) {
    //Declare local scope block variable
    let segmentsCount
    //Splitting by spaces
    segmentsCount = line.split(" ").length - 1;
    //Using regex
    segmentsCount = line.match(/ /g).length;
    //segmentsCount = line.match(/\x20/g).length;//sames as above but with x20 as identifier
   
    console.log(segmentsCount);
}).on('close',function(){
    process.exit(0);
});