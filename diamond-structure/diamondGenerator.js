
function diamond(number) {
  let allLines='';
  var line='';
  //up
  for(i=1;i<=number;i++) {
    line='';
    for(j=1;j<=i;j++) {

        line+=+j; //left

    }
    for(j=i;j>1;j--) {

        line+=(j-1); //right

    }
    //console.log('CurrentLine', line)
    let paddingSpaces= (((number*2)-1 ) - line.length)/2 ;
    allLines+=' '.repeat(paddingSpaces)+line;
    allLines+='\n';
  }

  //down
  for(i=number-1;i>=1;i--) 
  {
    line='';

    for(j=1;j<=i;j++) {

        line+=j; //left

    }
    for(j=i;j>1;j--) {

        line+=(j-1); //right

    }
    //console.log('CurrentLine', line)
    let paddingSpaces= (((number*2)-1 ) - line.length)/2 ;
    allLines+=' '.repeat(paddingSpaces)+line;
    allLines+='\n';
  }
  console.log(allLines)
    

}

diamond(3);
diamond(5);