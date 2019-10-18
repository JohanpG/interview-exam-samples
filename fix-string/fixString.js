var readline = require('readline');
var rl = readline.createInterface(process.stdin, process.stdout);
// Create global variables to hold the expected test cases and the counter of each test executed
var testCases= 0;
var testCounter =0;

// Accept the data line by line and print as it is
rl.on('line', function(line) {
    //Check if the line is a integer containing the number of test cases
    if(parseInt(line) && line>=1 && line<=10 && testCases == 0)
    {
        //Set test cases variable so we know how many test to expect next
        testCases= line;
        //console.log(testCases);
    }
    //Check that the test line is all lower case and  length is lower than 10^5
    else if ((testCounter<=testCases)
        && (line.toLowerCase()) ==line
        && (line.length >=1)
        && (line.length <= 1000000))
    {
        //Create block scoped variable to hold the result of the modified string without the duplicated consecutive caracters
        let fixedString= line.toString().replace(/(.)\1+/g,'$1');
        console.log(fixedString);
        //console.log(testCounter);
    }
    else{
        process.exit(0);
    }
    //Increase test counter
    ++testCounter

}).on('close',function(){
    process.exit(0);
});