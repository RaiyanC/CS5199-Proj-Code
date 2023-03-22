SetUserPreference( "PackagesToLoad", ["PackageManager", "digraphs", "profiling"] );
SetUserPreference( "UseColorPrompt", true );
SetUserPreference( "HistoryMaxLines", 1000 );
SetUserPreference( "SaveAndRestoreHistory", true );
SetUserPreference( "InfoDigraphs", 4 );
SetUserPreference( "Editor", "emacs" );

in digraphs-1.6.1/ init.g and read.g
ReadPackage("digraphs", "gap/weights.gd"); 
ReadPackage("digraphs", "gap/weights.gi");

in digraphs-1.6.1/gap/ doc.g

Digraph 1
test_gr := Digraph([[2,3,6],[1,3],[1,2,4,5],[3,5],[3,4,6],[1,5]]); 
weights := [[12,8,3],[12,5],[8,5,6,1],[6,9],[1,9,3],[3,3]];  

[ 18, HashMap([[ 1, [ 6 ] ], [ 6, [ 5 ] ], [ 5, [ 3 ] ], [ 3, [ 2, 4 ] ]]) ]



test_two := Digraph([[2,3],[1,3,4,5],[1,2,6],[2,5],[2,4,6],[3,5,7],[6]]);
weights_two := [[2,3],[2,1,1,4],[3,1,5],[1,1],[4,1,1],[5,1,1],[1]]; 


test_three := Digraph([[2,3],[1,3,4,5],[1,2,4],[2,3,5],[2,4]]);
weights_three := [[9,75],[9,95,19,42],[75,95,51],[19,51,31],[42,31]];


Read("../prim_v1.g"); Prims(test_gr, weights); 
Read("../Minimum Spanning Tree Algorithms/prim_v2.g"); Prims(test_gr, weights); 




For dijkstra
g := Digraph([[2,3,4],[1,3,4],[1,2,4,5,6],[1,2,3,5],[3,4,6],[3,5]]);
w := [[2,5,1], [2,3,2], [5,3,3,1,5], [1,2,3,1], [1,1,1], [5,1]];


# dont reuse rcg5 as its random, trying to debug floydwarshall
Read("../Shortest Path Algorithms/dijkstra.g"); Dijkstra(rcg5.random_graph, rcg5.weights, 1);
rec( distances := [ 0, 23, 24, 30, 29, 31, 43, 11, 65, 17 ], 
  edges := [ fail, 1, 2, 1, 2, 2, 2, 2, 3, 3 ], parents := [ fail, 1, 8, 5, 3, 2, 6, 1, 7, 8 ] )

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

rec( flows := [ [  ], [ [ 11 ], [ 1 ] ], [ [ 12 ] ], [ [ 12 ], [ 7 ] ], [ [ 11 ] ], 
      [ [ 19 ], [ 4 ] ] ], max_flow := 23, 
  parents := [ [  ], [ 1, 3 ], [ 1 ], [ 2, 5 ], [ 3 ], [ 4, 5 ] ] )

g5 := Digraph([[2,3],[4],[4],[]]);
w5 := [[5,3], [1], [1], []];


// testing multiple indegree
g6 := Digraph([[2,2], [3], []]);
w6 := [[5, 10], [20], []];

g7 := Digraph([[2,2], [3,3,3], []]);
w7 := [[5,10], [5,10,15],[]];

rec( flows := [ [  ], [ [ 5, 10 ] ], [ [ 5, 10, 0 ] ] ], max_flow := 15, 
  parents := [ [  ], [ 1, 1 ], [ 2, 2, 2 ] ] )

<!-- https://www.quora.com/Why-does-Dinics-algorithm-work-in-O-V-2-*-E-while-Edmonds-Karp-works-in-O-V-*-E-2 -->



data analysis

DeclareAttribute("EdgeWeights", IsDigraph);
Read("../test_creating_edgeweighted_digraph.g");
Read("../Minimum Spanning Tree Algorithms/mst_graph_creator.g");
rd := CreateRandomMSTGraph(1000,0.5);
<!-- Read("../Minimum Spanning Tree Algorithms/Analysis/p.g"); Prims(rd); -->


Read("../Minimum Spanning Tree Algorithms/Analysis/tester.g"); Runtests("p",500,0.5,3);


Read("../Minimum Spanning Tree Algorithms/Analysis/tester.g"); Runtests("p",1001,0.05,5,10);
python3 analyser.py -p "./0.5/p.csv" "./0.25/p.csv"


python3 analyser.py -p "./1/k.csv" "./0.5/k.csv" "./0.25/k.csv" "./0.125/k.csv" "./0.01/k.csv" "./1/p.csv" "./0.5/p.csv" "./0.25/p.csv" "./0.125/p.csv" "./0.01/p.csv" -c -s



API 
python3 analyser.py -p <paths to all the csv of one algo> [optional] -c <path to other csvs of other algo to compare> [optional- default to not save]-s <save graph>


 # for shortest path
Read("../Shortest Path Algorithms/Analysis/tester.g"); Runtests("d",1001,1,5,10);

 Read("../Shortest Path Algorithms/sp_graph_creator.g");rd := CreateRandomSPGraph(20,0.1);
 Read("../Shortest Path Algorithms/dijkstra.g"); Dijkstra(rd.random_graph, rd.start);
 Read("../Shortest Path Algorithms/bellmanford.g"); Bellman(rd.random_graph, rd.start);

Read("../Shortest Path Algorithms/Analysis/tester.g"); Runtests("j",1003,1,5,10);
Read("../Shortest Path Algorithms/Analysis/tester.g"); Runtests("j",1001,0.5,5,10);
Read("../Shortest Path Algorithms/Analysis/tester.g"); Runtests("j",1001,0.25,5,10);
Read("../Shortest Path Algorithms/Analysis/tester.g"); Runtests("j",1001,0.125,5,10);
Read("../Shortest Path Algorithms/Analysis/tester.g"); Runtests("j",1001,0.01,5,10);
 # for maximal flow

DeclareAttribute("EdgeWeights", IsDigraph);
Read("../test_creating_edgeweighted_digraph.g");

Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("ek",1002,1,5,10);
Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("ek",1002,0.5,5,10);
Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("ek",1002,0.25,5,10);
Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("ek",1002,0.125,5,10);
Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("ek",1002,0.01,5,10);

Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("dc",1002,1,5,10);
Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("dc",1002,0.5,5,10);
Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("dc",1002,0.25,5,10);
Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("dc",1002,0.125,5,10);
Read("../Maximal Flow Algorithms/Analysis/tester.g"); Runtests("dc",1002,0.01,5,10);



# mst 
g := EdgeWeightedDigraph([[2,3,6],[1,3],[1,2,4,5],[3,5],[3,4,6],[1,5]], [[12,8,3],[12,5],[8,5,6,1],[6,9],[1,9,3],[3,3]]);

Read("../Minimum Spanning Tree Algorithms/kruskals.g"); Kruskals(g); 


# DEBUGGING EK AND DC
Read("../Maximal Flow Algorithms/mf_graph_creator.g"); rmfg := CreateRandomMFGraph(1000,1);
Read("../Maximal Flow Algorithms/edmondkarp.g"); Edmondkarp(rmfg.random_graph, rmfg.start, rmfg.destination);


# Johnson
https://www.coursera.org/lecture/algorithms-npcomplete/johnsons-algorithm-i-eT0Xt
g := EdgeWeightedDigraph([[2,3],[4],[4],[]],[[5,1],[6],[11],[]]);
Read("../Shortest Path Algorithms/johnson.g"); Johnson(g); 

johnson better for sparse graphs, floyd better for dense graphs

# painting graphs

Read("../Minimum Spanning Tree Algorithms/paint_mst.g"); PaintMST(digraph, mst);


Read("../Minimum Spanning Tree Algorithms/paint_mst.g"); paint:= PaintMST(rg2, DigraphEdgeWeightedMinimumSpanningTree(rg2).mst);
Splash(DotColoredDigraph(rg2, paint.vertColors, paint.edgeColors));


Read("../Minimum Spanning Tree Algorithms/paint_mst.g"); paint:= PaintMST(rg, DigraphEdgeWeightedMinimumSpanningTree(rg).mst, "lightpink", "blue", "black");
Splash(DotColoredDigraph(rg, paint.vertColors, paint.edgeColors));