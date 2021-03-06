/*Dijkstra Algorithm-an algorithm for finding the shortest paths between nodes in a graph*/

// takes input as number of vertex
var V: int=stdin.read(int);
var graph: [1..V,1..V] int;

// takes input as weight of vertex(i,j)
for (i,j) in {1..V, 1..V} do
   graph(i,j) =stdin.read(int);							 
 
 //A function to find the vertex with minimum distance value,
 //from the set of vertices not yet included in shortest path tree
proc minDistance(dist: [1..V] int, visited: [1..V] bool):int			
{
  // Initialize min value
   var min: int = max(int);						
   var min_index: int;
   for i in 1..V
   {
     if (visited[i] == false && dist[i] <= min)
     {
         min = dist[i];
	 min_index = i;
     }
   }
   return min_index;
}

// A function to print the constructed distance array
proc printSolution(dist: [1..V] int, n:int)			      	
{
   writeln("Vertex       Distance from Source");
   for i in 1..V do
      writeln(i,"		",dist[i]);
}
 
// Funtion that implements Dijkstra's single source shortest path algorithm
// for a graph represented using matrix representation

proc dijkstra(graph: [1..V, 1..V] int, src:int)
{
    // The output array dist[i] will hold the shortest distance from source to i
    var dist:[1..V] int;     

    // visited[i] will true if vertex i is included in shortest
    // path tree or shortest distance from src to i is finalized
    var visited:[1..V] bool;
    
    // Initialize all distances as max integer and visited[] as false
     for i in 1..V
     {
        dist[i] = max(int);
	visited[i] = false;
     }
 
     // Distance of source vertex from itself is always 0
     dist[src] = 0;
 
     // Find shortest path for all vertices
     for count in 1..V-1
     {
       
       // Pick the minimum distance vertex from the set of vertices not
       // yet processed. u is always equal to src in first iteration.
       var u: int= minDistance(dist, visited);
 
       // Mark the picked vertex as processed
       visited[u] = true;
 
       // Update dist value of the adjacent vertices of the picked vertex.
       for i in 1..V
       {
 
         // Update dist[v] only if is not in visited, there is an edge from 
         // u to v, and total weight of path from src to  v through u is 
         // smaller than current value of dist[v]
         if (visited[i]==false && graph(u,i) !=0 && dist[u] != max(int)
                                       && dist[u]+graph(u,i) < dist[i]) then
            dist[i] = dist[u] + graph(u,i);
       }
     }
 
     // print the constructed distance array
     printSolution(dist, V);
}
 
dijkstra(graph, 1);   //src always being the first vertex


/* Passing Input as 
9
0 4 0 0 0 0 0 8 0
4 0 8 0 0 0 0 11 0
0 8 0 7 0 4 0 0 2
0 0 7 0 9 14 0 0 0
0 0 0 9 0 10 0 0 0
0 0 4 14 10 0 2 0 0
0 0 0 0 0 2 0 1 6
8 11 0 0 0 0 1 0 7
0 0 2 0 0 0 6 7 0
*/

/* Output
Vertex       Distance from Source
1		0
2		4
3		12
4		19
5		21
6		11
7		9
8		8
9		14
*/


