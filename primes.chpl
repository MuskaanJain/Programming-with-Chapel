//Chapel Program to find prime numbers before n

var sqr_primes:[1..0] int;   
var composites:[1..0] int;   
config var n:int;            //take input value of n
var flags:[1..n] int=1;     

//returns values of 2..x for which p*x<=n
iter number(x:int,o:int)
{
  var i:int=2;
  while(i*o<=x)
  {
    yield i;
    i=i+1;
  }
}

iter number(param tag: iterKind, x:int, o:int)
  where tag == iterKind.standalone
  {
    var i:int=2;
    while(i*o<=x)
    {
      yield i;
      i=i+1;
    }
  }
//a function to get prime numbers before n
proc primes(n:int)
{
  //base condition
  if n == 2 then sqr_primes.push_back(2);
  else
  {
    //recursion call for square root of n
    primes(ceil(sqrt(n)):int);		
    for p in sqr_primes
     {
       forall j in number(x=n,o=p)
       {
         //stores the composite number before square root of n
         composites.push_back(j*p);    
       }
     }
    //indicates which are prime(1) or composite(0)
    for k in composites do
      flags[k]=0;                      
      
    sqr_primes.clear();
    composites.clear();
    for k in 1..n
    {
     if flags[k]==1 then
     //stores the prime number before square root of n
     sqr_primes.push_back(k);        
    }
   sqr_primes.remove(1);
  }
}

primes(n);
//print the prime numbers before n
writeln(sqr_primes);                

/* INPUT

./primes --n=100

*/

/* OUTPUT

2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97

*/
