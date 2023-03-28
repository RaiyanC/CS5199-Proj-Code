# unconnected digraph
gap> d := EdgeWeightedDigraph([[1],[2]],[[5],[10]]);
<immutable digraph with 2 vertices, 2 edges>
gap> DigraphEdgeWeightedMinimumSpanningTree(d);     
Error, digraph must be connected,

# digraph with one node
gap> d := EdgeWeightedDigraph([[]],[[]]); 
<immutable empty digraph with 1 vertex>
gap> DigraphEdgeWeightedMinimumSpanningTree(d);
rec( mst := <immutable empty digraph with 1 vertex>, total := 0 )

# digraph with loop
gap> d := EdgeWeightedDigraph([[1]],[[5]]);
<immutable digraph with 1 vertex, 1 edge>
gap> DigraphEdgeWeightedMinimumSpanningTree(d);
rec( mst := <immutable empty digraph with 1 vertex>, total := 0 )

# digraph with cycle
gap> d := EdgeWeightedDigraph([[2],[3],[1]],[[5],[10],[15]]);
<immutable digraph with 3 vertices, 3 edges>
gap> DigraphEdgeWeightedMinimumSpanningTree(d);              
rec( mst := <immutable digraph with 3 vertices, 2 edges>, total := 15 )

# digraph with negative edge
gap> d := EdgeWeightedDigraph([[2],[]],[[-5],[]]);  
<immutable digraph with 2 vertices, 1 edge>
gap> DigraphEdgeWeightedMinimumSpanningTree(d);
rec( mst := <immutable digraph with 2 vertices, 1 edge>, total := -5 )

# digraph with negative cycle
gap> d := EdgeWeightedDigraph([[2],[3],[1]],[[-5],[-10],[-15]]);
<immutable digraph with 3 vertices, 3 edges>
gap> DigraphEdgeWeightedMinimumSpanningTree(d);
rec( mst := <immutable digraph with 3 vertices, 2 edges>, total := -25 )

# digraph with parallel edges
gap> d := EdgeWeightedDigraph([[2,2,2],[1]],[[10,5,15],[7]]);  
<immutable multidigraph with 2 vertices, 4 edges>
gap> DigraphEdgeWeightedMinimumSpanningTree(d);
rec( mst := <immutable digraph with 2 vertices, 1 edge>, total := 5 )
