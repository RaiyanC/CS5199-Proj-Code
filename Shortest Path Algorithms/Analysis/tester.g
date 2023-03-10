Runtests := function(alg, nodes, probability, nrIterations, step)
  local algPath, analysisPath, headers, i, random_graph, nrNode, idx;

  # read in necessary files
  Read("../test_creating_edgeweighted_digraph.g");
  Read("../Shortest Path Algorithms/sp_graph_creator.g");
  algPath := Concatenation("../Shortest Path Algorithms/Analysis/", 
             Concatenation(String(alg), ".g"));

  Read(algPath);

  analysisPath := Concatenation("../Shortest Path Algorithms/Analysis/", 
                  Concatenation(String(probability),
                  Concatenation("/",
                  Concatenation(String(alg), ".csv"))));
            
  headers := "Vertices,Edges,StartTime,EndTime\n";
  PrintTo(analysisPath, headers);
  
  nrNode := 1;
  while nrNode <= nodes do
    for i in [1..nrIterations] do
      # create random graphs and save them
      random_graph := CreateRandomSPGraph(nrNode, probability);
      if String(alg) = "d" then
        Dijksttra(random_graph.random_graph, random_graph.start, probability);
      fi;
      if String(alg) = "bmf" then
        Bellman(random_graph.random_graph, random_graph.start, probability);
      fi;
      if String(alg) = "flw" then
        Floyd(random_graph.random_graph, probability);
      fi;
    od;
    nrNode := nrNode + step;
  od;

end;