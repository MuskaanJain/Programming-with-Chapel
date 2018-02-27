
var name : string = "Level";
var n : int ;
n = name.length;
var palindrome : sync bool = true;  				//state = full

forall i in 1..n/2
{
  if(name.this(i) != name.this(n-i+1))
  {
	palindrome;						//state = empty
	palindrome = false;			         	//state = full
   }
}

writeln(palindrome.readFE());      				//state = full
