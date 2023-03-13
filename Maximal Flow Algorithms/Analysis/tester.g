Runtests := function(alg, nodes, probability, nrIterations, step)
  local algPath, analysisPath, headers, i, random_graph, nrNode, idx;

  # read in necessary files
  Read("../test_creating_edgeweighted_digraph.g");
  Read("../Maximal Flow Algorithms/mf_graph_creator.g");
  algPath := Concatenation("../Maximal Flow Algorithms/Analysis/", 
             Concatenation(String(alg), ".g"));

  Read(algPath);

  analysisPath := Concatenation("../Maximal Flow Algorithms/Analysis/", 
                  Concatenation(String(probability),
                  Concatenation("/",
                  Concatenation(String(alg), ".csv"))));
            
  headers := "Vertices,Edges,StartTime,EndTime\n";
  PrintTo(analysisPath, headers);
  
  nrNode := 2;
  while nrNode <= nodes do
    for i in [1..nrIterations] do
      # create random graphs and save them
      random_graph := CreateRandomMFGraph(nrNode, probability);
      if String(alg) = "ek" then
        Edmondkarp(random_graph.random_graph, random_graph.start, random_graph.destination, probability);
      fi;
      if String(alg) = "dc" then
        Dinic(random_graph.random_graph, random_graph.start,random_graph.destination, probability);
      fi;
    od;
    nrNode := nrNode + step;
  od;

end;