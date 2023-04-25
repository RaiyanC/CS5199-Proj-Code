# empty digraphs
gap> d := EdgeWeightedDigraph([],[]);
<immutable empty digraph with 0 vertices>
gap> DigraphMaximumFlow(d, 1, 1);
Error, empty digraph has no paths,

# single vertex (also empty digraphs)
gap> d := EdgeWeightedDigraph([[]],[[]]);
<immutable empty digraph with 1 vertex>
gap> DigraphMaximumFlow(d, 1, 1);        
Error, empty digraph has no paths,

# source = dest
gap> d := EdgeWeightedDigraph([[2],[]],[[5],[]]);
<immutable digraph with 2 vertices, 1 edge>
gap> DigraphMaximumFlow(d, 1, 1);                
rec( flows := [  ], maxFlow := 0, parents := [  ] )

# has loop 
gap> d := EdgeWeightedDigraph([[1,2],[]],[[5,10],[]]);
<immutable digraph with 2 vertices, 2 edges>
gap> DigraphMaximumFlow(d, 1, 2);
rec( flows := [ [  ], [ 10 ] ], maxFlow := 10, parents := [ [  ], [ 1 ] ] )

# invalid source
gap> d := EdgeWeightedDigraph([[1,2],[]],[[5,10],[]]);                
<immutable digraph with 2 vertices, 2 edges>
gap> DigraphMaximumFlow(d, 5, 2);
Error, invalid source,

# invalid sink
gap> d := EdgeWeightedDigraph([[1,2],[]],[[5,10],[]]);
<immutable digraph with 2 vertices, 2 edges>
gap> DigraphMaximumFlow(d, 1, 5);
Error, invalid sink,

# sink not reachable
gap> d := EdgeWeightedDigraph([[1],[]],[[5],[]]);     
<immutable digraph with 2 vertices, 1 edge>
gap> DigraphMaximumFlow(d, 1, 2);
rec( flows := [ [  ], [  ] ], maxFlow := 0, parents := [ [  ], [  ] ] )

# source has in neighbours
gap> d := EdgeWeightedDigraph([[2],[3],[]],[[5],[10],[]]); 
<immutable digraph with 3 vertices, 2 edges>
gap> DigraphMaximumFlow(d, 2, 3);
rec( flows := [ [  ], [  ], [ 10 ] ], maxFlow := 10, parents := [ [  ], [  ], [ 2 ] ] )


# sink has out neighbours
gap> d := EdgeWeightedDigraph([[2],[3],[2]],[[5],[10],[7]]);
<immutable digraph with 3 vertices, 3 edges>
gap> DigraphMaximumFlow(d, 2, 3);                           
rec( flows := [ [  ], [  ], [ 10 ] ], maxFlow := 10, parents := [ [  ], [  ], [ 2 ] ] )

# cycle
gap> d := EdgeWeightedDigraph([[2],[3],[1]],[[5],[10],[7]]);
<immutable digraph with 3 vertices, 3 edges>
gap> DigraphMaximumFlow(d, 1, 3);
rec( flows := [ [  ], [ 5 ], [ 5 ] ], maxFlow := 5, parents := [ [  ], [ 1 ], [ 2 ] ] )