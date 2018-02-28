//////////////////////////////////////////  PALINDROME  ///////////////////////////////////////////////////
//The code below is checks if a string is palindrome or not using data and task parallel features of chapel.

//Takes input a string for checking whether it is palindrome or not
var str : string = stdin.read(string);

//Variable n stores length of given string
var n : int = str.length;

//Declares a sync variable palindrome of type bool and initialzes it to true, state of sync variable is full
var palindrome : sync bool = true;  				

//Checks parallerly a string is palindrome or not as each loop in parallel checks if index from start let say ith is same as ith from last
forall i in 1..n/2
{
  if(str.this(i) != str.this(n-i+1))
  {
  	//state of sync variable is empty
	palindrome;			
	//state of sync variable is full 
	palindrome = false;			         	

   }
}

//Displays result
var result : bool = palindrome.readFE();
if result==true then
	writeln(str," is palindrome");
else
	writeln(str," is not a palindrome");	     				
