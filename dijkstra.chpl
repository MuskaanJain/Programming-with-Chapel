  var V: int=stdin.read(int);
  
// A utility function to find the vertex with minimum distance value, from
// the set of vertices not yet included in shortest path tree

var graph: [1..V,1..V] int;
   for (i,j) in {1..V, 1..V} do
      graph(i,j) =stdin.read(int);
 
  
proc minDistance(dist: [1..V] int, sptSet: [1..V] bool):int
{
   // Initialize min value
   var min: int = max(int);
   var min_index: int;
   for i in 1..V
   {
     if (sptSet[i] == false && dist[i] <= min)
     {
         min = dist[i];
	 min_index = i;
	 }
 	 }
   return min_index;
}
 
// A utility function to print the constructed distance array
proc printSolution(dist: [1..V] int, n:int)
{
   writeln("Vertex   Distance from Source");
   for i in 1..V do
      writeln(i,"  ",dist[i]);
}
 
// Funtion that implements Dijkstra's single source shortest path algorithm
// for a graph represented using adjacency matrix representation
proc dijkstra(graph: [1..V, 1..V] int, src:int)
{
    var dist:[1..V] int;     // The output array.  dist[i] will hold the shortest
                      // distance from src to i
    var sptSet:[1..V] bool; // sptSet[i] will true if vertex i is included in shortest
                     // path tree or shortest distance from src to i is finalized
    
     // Initialize all distances as INFINITE and stpSet[] as false
     for i in 1..V
     {
        dist[i] = max(int);
	sptSet[i] = false;
	}
 
     // Distance of source vertex from itself is always 0
     dist[src] = 0;
 
     // Find shortest path for all vertices
     for count in 1..V-1
     {
       
       // Pick the minimum distance vertex from the set of vertices not
       // yet processed. u is always equal to src in first iteration.
       var u: int= minDistance(dist, sptSet);
 
       // Mark the picked vertex as processed
       sptSet[u] = true;
 
       // Update dist value of the adjacent vertices of the picked vertex.
       for i in 1..V
       {
 
         // Update dist[v] only if is not in sptSet, there is an edge from 
         // u to v, and total weight of path from src to  v through u is 
         // smaller than current value of dist[v]
         if (sptSet[i]==false && graph(u,i) !=0 && dist[u] != max(int)
                                       && dist[u]+graph(u,i) < dist[i]) then
            dist[i] = dist[u] + graph(u,i);
	    }
     }
 
     // print the constructed distance array
     printSolution(dist, V);
}
 
     dijkstra(graph, 1);