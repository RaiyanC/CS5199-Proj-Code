Runtests := function(alg, nodes, probability, nrIterations, step)
  local algs, a, algPath, analysisPath, headers, i, random_graph, idx, nrNode, idx;

  algs := ["ek", "dc", "pr"];
  analysisPath := Concatenation("../Maximal Flow Algorithms/Analysis/",
                  Concatenation(String(probability), "/"));
  headers := "Vertices,Edges,StartTime,EndTime\n";
  if alg = "all" then
    for a in algs do
      analysisPath := Concatenation(analysisPath,
                      Concatenation(String(a), ".csv"));

      PrintTo(analysisPath, headers);
    od;
  elif alg = "dc" then
    analysisPath := Concatenation(analysisPath, "dc.csv");
    PrintTo(analysisPath, headers);
  elif alg = "ek" then
    analysisPath := Concatenation(analysisPath, "ek.csv");
    PrintTo(analysisPath, headers);
  elif alg = "pr" then
    analysisPath := Concatenation(analysisPath, "pr.csv");
    PrintTo(analysisPath, headers);
  fi;

  nrNode := 2;
  while nrNode <= nodes do
    for i in [1..nrIterations] do
      # create random graphs and save them
      random_graph := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph,nrNode, probability);
      if alg = "all" then
        Dinic(random_graph, 1, nrNode, probability);
        Edmondkarp(random_graph, 1, nrNode probability);
        PushRelabel(random_graph, 1, nrNode, probability);
      elif alg = "dc" then
        Dinic(random_graph, 1, nrNode, probability);
      elif alg = "ek" then
        Edmondkarp(random_graph, 1, nrNode probability);
      elif alg = "pr" then
        PushRelabel(random_graph, 1, nrNode, probability);
      fi;
    od;
    nrNode := nrNode + step;
  od;

end;