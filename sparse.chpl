////////////////////////////////////////// SPARSE MATRIX MULTIPLICATION  ///////////////////////////////////////////////////
//The code below is performing multiplication of a sparse matrix with a dense vector using data and task parallel features of chapel.
//A sparse matrix of size nxn is multiplied by a dense vector of size n.
//Sparse matrix is formed by sparsing a dense 2D domain of size nxn.


//A config variable n is taken to represent the nxn size of sparse matrix as well as size n of dense vector which can be changed from the command line by passing "--n=5" while executing the code
config var n = 4;

//To create a sparse domain first a dense domain of size nxn is taken
const denseDom = {1..n, 1..n};

//Sparse domain for the sparse matrix is formed by sparsing of the above dense domain of size nxn
var sparseDom: sparse subdomain(denseDom);

//A sparse matrix sparseMat is declared with domain equal to sparseDom
var sparseMat: [sparseDom] real;

//A dense vector denseVec of size n is declared
var denseVec : [1..n] real;

//Initializing the dense vector by taking input from terminal  
//Let consider dense vector : [1.0, 0.0, -1.0, 0.0]
for i in 1..n do
	denseVec(i) = stdin.read(real);

//Declares a matrix mulMat which will store the resultant matrix after multiplication of sparse matrix and dense vector
var mulMat : [1..n] real;

//Declares a sync variable sum which will store resulted value of say, ith row of resultant matrix at any stage
var sum : sync real = 0;	//state = full

//Declares a variable numOfNonZeroes which stores number of non-zero values in sparse matrix and initialize it by taking terminal input
var numOfNonZeroes : int = stdin.read(int);

//Declares a tuple which will store row , column and value for non-zeroes value in sparse matrix
var tuple : (int, int, real);

//Reads sparse matrix sparseMat
//Let consider sparse matrix given below
//	2.0		-1.0	0		0
//	-1.0	2.0		-1.0	0
//	0		-1.0	2.0		-1.0
//	0		0		-1.0	2.0

for i in 1..numOfNonZeroes{
	tuple = stdin.read(int, int, real);
	var (row, col, val) = tuple;
	sparseDom += (row, col);
	sparseMat(row, col) = val;
}

writeln("Sparse Matrix:");
writeln(sparseMat);


//A nested parallel loop where outer forall loop parallely calculates each row value for resultant matrix and inside forall loop calculates product of corresponding two values of ith column and ith row of sparse matrix and dense vector respectively for the row on which outer loop is executing and store the total sum in a sync variable sum  
forall i in 1..n {
	forall v in 1..n{
		sum += sparseMat(i,v)*denseVec(v);
	}
	mulMat(i) = sum;
	sum = 0;
}


//Prints out resultant matrix
//For the above example ouput is : [2.0 0.0 -2.0 1.0] 
writeln("[", mulMat, "]");

