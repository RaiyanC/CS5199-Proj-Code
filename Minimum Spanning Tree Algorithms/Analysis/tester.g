Runtests := function(alg, nodes, probability, nrIterations, step)
  local algs, a, algPath, analysisPath, headers, i, random_graph, nrNode, idx;

  # read in necessary files
  # Read("../test_creating_edgeweighted_digraph.g");
  Read("../Minimum Spanning Tree Algorithms/mst_graph_creator.g");
  algPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/", 
             Concatenation(String(alg), ".g"));

  Read(algPath);

  algs := ["pv1", "b", "kv2"];
  analysisPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/",
                      Concatenation(String(probability), "/"));
  headers := "Vertices,Edges,StartTime,EndTime\n";
  if alg = "all" then
    for a in algs do
      analysisPath := Concatenation(analysisPath,
                      Concatenation(String(a), ".csv"));

      PrintTo(analysisPath, headers);
    od;
  elif alg = "pv1" then
    analysisPath := Concatenation(analysisPath, "pv1.csv");
    PrintTo(analysisPath, headers);
  elif alg = "b" then
    analysisPath := Concatenation(analysisPath, "b.csv");
    PrintTo(analysisPath, headers);
  elif alg = "kv2" then
    analysisPath := Concatenation(analysisPath, "kv2.csv");
    PrintTo(analysisPath, headers);
  fi;
  
  nrNode := 1;
  while nrNode <= nodes do
    for i in [1..nrIterations] do
      # create random graphs and save them
      random_graph := RandomUniqueEdgeWeightedDigraph(IsConnectedDigraph,nrNode, probability);


      Prims(random_graph, probability);
      Boruvka(random_graph, probability);
      Kruskalsv2(random_graph, probability);
    od;
    nrNode := nrNode + step;
  od;

end;