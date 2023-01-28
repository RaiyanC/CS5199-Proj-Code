# tests for minimum spanning trees

# test one
gap> test_one := Digraph([[2,3,6],[1,3],[1,2,4,5],[3,5],[3,4,6],[1,5]]);
<immutable digraph with 6 vertices, 16 edges>
gap> weights_one := [[12,8,3],[12,5],[8,5,6,1],[6,9],[1,9,3],[3,3]];       
[ [ 12, 8, 3 ], [ 12, 5 ], [ 8, 5, 6, 1 ], [ 6, 9 ], [ 1, 9, 3 ], [ 3, 3 ] ]
gap> Read("../prim_v2.g"); Prims(test_one, weights_one);                    
[ 18, HashMap([[ 1, [ 6 ] ], [ 6, [ 5 ] ], [ 5, [ 3 ] ], [ 3, [ 2, 4 ] ]]) ]

# test two
gap> test_two := Digraph([[2,3],[1,3,4,5],[1,2,6],[2,5],[2,4,6],[3,5,7],[6]]);
<immutable digraph with 7 vertices, 18 edges>
gap> weights_two := [[2,3],[2,1,1,4],[3,1,5],[1,1],[4,1,1],[5,1,1],[1]]; 
[ [ 2, 3 ], [ 2, 1, 1, 4 ], [ 3, 1, 5 ], [ 1, 1 ], [ 4, 1, 1 ], [ 5, 1, 1 ],\
 [ 1 ] ]
gap> Read("../prim_v2.g"); Prims(test_two, weights_two);                      
[ 7, HashMap([[ 1, [ 2 ] ], [ 2, [ 3, 4 ] ], [ 4, [ 5 ] ], [ 5, [ 6 ] ], [ 6, [ 7 ] ]]) ]
