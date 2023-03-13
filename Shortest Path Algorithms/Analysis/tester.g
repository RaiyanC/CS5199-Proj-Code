Runtests := function(alg, nodes, probability, nrIterations, step)
  local algPath, analysisPath, headers, i, random_graph, nrNode, idx;

  # read in necessary files
  Read("../test_creating_edgeweighted_digraph.g");
  Read("../Shortest Path Algorithms/sp_graph_creator.g");
  if alg <> "all" then
  algPath := Concatenation("../Shortest Path Algorithms/Analysis/", 
             Concatenation(String(alg), ".g"));
  fi;
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
        Dijkstra(random_graph.random_graph, random_graph.start, probability);
      fi;
      if String(alg) = "bmf" then
        Bellman(random_graph.random_graph, random_graph.start, probability);
      fi;
      if String(alg) = "flw" then
        Floyd(random_graph.random_graph, probability);
      fi;
      if String(alg) = "all" then 
        Read("../Shortest Path Algorithms/Analysis/d.g");
        Read("../Shortest Path Algorithms/Analysis/bmf.g");
        Read("../Shortest Path Algorithms/Analysis/flw.g");
        Dijkstra(random_graph.random_graph, random_graph.start, probability);
        Bellman(random_graph.random_graph, random_graph.start, probability);
        Floyd(random_graph.random_graph, probability);
      fi;

    od;
    nrNode := nrNode + step;
  od;

end;