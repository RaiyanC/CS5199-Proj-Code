Runtests := function(alg, nodes, probability, nrIterations, step)
  local algPath, analysisPath, headers, i, random_graph, nrNode, idx;

  # read in necessary files
  Read("../test_creating_edgeweighted_digraph.g");
  Read("../Minimum Spanning Tree Algorithms/mst_graph_creator.g");
  algPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/", 
             Concatenation(String(alg), ".g"));

  Read(algPath);

  analysisPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/", 
                  Concatenation(String(probability),
                  Concatenation("/",
                  Concatenation(String(alg), ".csv"))));
            
  headers := "Vertices,Edges,StartTime,EndTime\n";
  PrintTo(analysisPath, headers);
  
  nrNode := 1;
  while nrNode <= nodes do
    for i in [1..nrIterations] do
      # create random graphs and save them
      random_graph := CreateRandomMSTGraph(nrNode, probability);
      Kruskals(random_graph, probability);
    od;
    nrNode := nrNode + step;
  od;

end;