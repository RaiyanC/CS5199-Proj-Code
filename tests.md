SetUserPreference( "PackagesToLoad", ["PackageManager", "digraphs"] );
SetUserPreference( "UseColorPrompt", true );
SetUserPreference( "HistoryMaxLines", 1000 );
SetUserPreference( "SaveAndRestoreHistory", true );
SetUserPreference( "InfoDigraphs", 4 );
SetUserPreference( "Editor", "emacs" );

Digraph 1
test_gr := Digraph([[2,3,6],[1,3],[1,2,4,5],[3,5],[3,4,6],[1,5]]); 
weights := [[12,8,3],[12,5],[8,5,6,1],[6,9],[1,9,3],[3,3]];  

[ 18, HashMap([[ 1, [ 6 ] ], [ 6, [ 5 ] ], [ 5, [ 3 ] ], [ 3, [ 2, 4 ] ]]) ]



test_two := Digraph([[2,3],[1,3,4,5],[1,2,6],[2,5],[2,4,6],[3,5,7],[6]]);
weights_two := [[2,3],[2,1,1,4],[3,1,5],[1,1],[4,1,1],[5,1,1],[1]]; 


test_three := Digraph([[2,3],[1,3,4,5],[1,2,4],[2,3,5],[2,4]]);
weights_three := [[9,75],[9,95,19,42],[75,95,51],[19,51,31],[42,31]];


Read("../prim_v1.g"); Prims(test_gr, weights); 



For dijkstra
g := Digraph([[2,3,4],[1,3,4],[1,2,4,5,6],[1,2,3,5],[3,4,6],[3,5]]);
w := [[2,5,1], [2,3,2], [5,3,3,1,5], [1,2,3,1], [1,1,1], [5,1]];

<!-- https://www.scaler.com/topics/data-structures/dijkstra-algorithm/ -->
g2 := Digraph([[2,3],[1,3,4,5],[1,2,5],[2,5,6],[2,3,4,6],[4,5]]);
w2 := [[4,5],[4,11,9,7],[5,11,3],[9,13,2],[7,3,13,6],[2,6]]; 

<!-- expect 
rec( distances := [ 0, 4, 5, 13, 8, 14 ], edges := [ -1, 1, 2, 3, 3, 4 ], parents := [ -1, 1, 1, 2, 3, 5 ] ) -->

copying the graphs and weights
Read("../prim_v2.g");
ProfileLineByLine("../prims_v2_profile1.gz"); Prims(test_gr, weights); UnprofileLineByLine();
LoadPackage("profiling");
OutputAnnotatedCodeCoverageFiles("../prims_v2_profile1.gz", "../prims_v2_profile1_outdir");



# for testing edmond karp 
# https://github.com/anxiaonong/Maxflow-Algorithms/blob/master/Edmonds-Karp%20Algorithm.py

<!-- https://github.com/anxiaonong/Maxflow-Algorithms -->

Read("../prim_v1.g"); Prims(test_gr, weights); 

g3 := Digraph([[2,3], [3,4], [5], [5,6], [6], [6]]);
w3 := [[3,3], [2,3], [5], [4,2], [2], [3]];


g4 := Digraph([[2,3],[4],[2,5],[6],[4,6],[]]);
w4 := [[11,12],[12],[1,11],[19],[7,4],[]];


g5 := Digraph([[2,3],[4],[4],[]]);
w5 := [[5,3], [1], [1], []];


// testing multiple indegree
g6 := Digraph([[2,2], [3], []]);
w6 := [[5, 10], [20], []];

g7 := Digraph([[2,2], [3,3,3], []]);
w7 := [[5,10], [5,10,15],[]];