# not strongly connected
gap> d := EdgeWeightedDigraph([[2],[]],[[5],[]]);
<immutable digraph with 2 vertices, 1 edge>
gap> DigraphEdgeWeightedShortestPaths(d, 1);   
Error, digraph must be strongly connected,

# graph one node
gap> d := EdgeWeightedDigraph([[]],[[]]);           
<immutable empty digraph with 1 vertex>
gap> DigraphEdgeWeightedShortestPaths(d, 1);
rec( distances := [ 0 ], edges := [ fail ], parents := [ fail ] )

# graph with one node and self loop
gap> d := EdgeWeightedDigraph([[1]],[[5]]);
<immutable digraph with 1 vertex, 1 edge>
gap> DigraphEdgeWeightedShortestPaths(d, 1);                       
rec( distances := [ 0 ], edges := [ fail ], parents := [ fail ] )

# graph with two nodes and self loop on second node
gap> d := EdgeWeightedDigraph([[2],[1,2]],[[5],[5,5]]);
<immutable digraph with 2 vertices, 3 edges>
gap> DigraphEdgeWeightedShortestPaths(d, 1);           
rec( distances := [ 0, 5 ], edges := [ fail, 1 ], parents := [ fail, 1 ] )

# graph with cycle
gap> d := EdgeWeightedDigraph([[2],[3],[1]],[[2],[3],[4]]);
<immutable digraph with 3 vertices, 3 edges>
gap> DigraphEdgeWeightedShortestPaths(d, 1);                       
rec( distances := [ 0, 2, 5 ], edges := [ fail, 1, 1 ], 
  parents := [ fail, 1, 2 ] )

# parallel edges
gap> d := EdgeWeightedDigraph([[2,2,2],[1]],[[10,5,15],[7]]);   
<immutable multidigraph with 2 vertices, 4 edges>
gap> DigraphEdgeWeightedShortestPaths(d, 1);
rec( distances := [ 0, 5 ], edges := [ fail, 2 ], parents := [ fail, 1 ] )

# negative edges
gap> d := EdgeWeightedDigraph([[2],[1]],[[-2],[7]]);          
<immutable digraph with 2 vertices, 2 edges>
gap> DigraphEdgeWeightedShortestPaths(d, 1);
rec( distances := [ 0, -2 ], edges := [ fail, 1 ], parents := [ fail, 1 ] )

# parallel negative edges
gap> d := EdgeWeightedDigraph([[2,2,2],[1]],[[-2,-3,-4],[7]]);
<immutable multidigraph with 2 vertices, 4 edges>
gap> DigraphEdgeWeightedShortestPaths(d, 1);
rec( distances := [ 0, -4 ], edges := [ fail, 3 ], parents := [ fail, 1 ] )

# negative cycle
gap> d := EdgeWeightedDigraph([[2,2,2],[1]],[[-10,5,-15],[7]]);
<immutable multidigraph with 2 vertices, 4 edges>
gap> DigraphEdgeWeightedShortestPaths(d, 1);
Error, negative cycle exists,

# source not in graph pos int
gap> d := EdgeWeightedDigraph([[2],[1]],[[2],[7]]);
<immutable digraph with 2 vertices, 2 edges>
gap> DigraphEdgeWeightedShortestPaths(d, 3);
Error, source vertex does not exist within digraph

# source not in graph neg int
gap> DigraphEdgeWeightedShortestPaths(d, -1);
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `DigraphEdgeWeightedShortestPaths' on 2 \
arguments


