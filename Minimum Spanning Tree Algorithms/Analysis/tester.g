Runtests := function(alg, nodes, probability, nrIterations)
  local algPath, analysisPath, headers, i, random_graph, nrNode;

  # read in necessary files
  Read("../test_creating_edgeweighted_digraph.g");
  Read("../Minimum Spanning Tree Algorithms/mst_graph_creator.g");
  algPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/", 
             Concatenation(String(alg), ".g"));

  Read(algPath);

  analysisPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/", 
                  Concatenation(String(alg),
                  Concatenation("/",
                  Concatenation(String(probability),
                  Concatenation("/",
                  Concatenation(String(alg), ".csv"))))));
            
  headers := "Vertices,Edges,StartTime,EndTime\n";
  PrintTo(analysisPath, headers);
  
  
  for nrNode in [1..nodes] do
    for i in [1..nrIterations] do
      # create random graphs and save them
      random_graph := CreateRandomMSTGraph(nrNode, probability);
      Prims(random_graph, probability);
    od;
  od;

end;