Runtests := function(alg, nodes, probability, nrIterations, step)
  local algs, a, algPath, analysisPath, headers, i, random_graph, idx, nrNode, idx;

  algs := ["d", "bmfv2", "flw", "j"];
  analysisPath := Concatenation("../Shortest Path Algorithms/Analysis/",
                  Concatenation(String(probability), "/"));
  headers := "Vertices,Edges,StartTime,EndTime\n";
  if alg = "all" then
    for a in algs do
      analysisPath := Concatenation(analysisPath,
                      Concatenation(String(a), ".csv"));

      PrintTo(analysisPath, headers);
    od;
  elif alg = "sp" then
    for idx in [1 .. 2] do
      a := algs[idx];
      analysisPath := Concatenation(analysisPath,
                      Concatenation(String(a), ".csv"));

      PrintTo(analysisPath, headers);
    od;
  elif alg = "sps" then
    for idx in [3 .. 4] do
      a := algs[idx];
      analysisPath := Concatenation(analysisPath,
                      Concatenation(String(a), ".csv"));

      PrintTo(analysisPath, headers);
    od;
  elif alg = "d" then
    analysisPath := Concatenation(analysisPath, "d.csv");
    PrintTo(analysisPath, headers);
  elif alg = "bmfv2" then
    analysisPath := Concatenation(analysisPath, "bmfv2.csv");
    PrintTo(analysisPath, headers);
  elif alg = "flw" then
    analysisPath := Concatenation(analysisPath, "flw.csv");
    PrintTo(analysisPath, headers);
  elif alg = "j" then
    analysisPath := Concatenation(analysisPath, "j.csv");
    PrintTo(analysisPath, headers);
  fi;
  
  nrNode := 1;
  while nrNode <= nodes do
    for i in [1..nrIterations] do
      # create random graphs and save them
      random_graph := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph,nrNode, probability);
      if alg = "all" then
        Dijkstra(random_graph, 1, probability);
        Bellmanv2(random_graph, 1, probability);
        Floyd(random_graph, probability);
        Johnson(random_graph, probability);
      elif alg = "sp" then
        Dijkstra(random_graph, 1, probability);
        Bellmanv2(random_graph, 1, probability);
      elif alg = "sps" then
        Floyd(random_graph, probability);
        Johnson(random_graph, probability);
      elif alg = "d" then
        Dijkstra(random_graph, 1, probability);
      elif alg = "bmfv2" then
        Bellmanv2(random_graph, 1, probability);
      elif alg = "flw" then
        Floyd(random_graph, probability);
      elif alg = "j" then
        Johnson(random_graph, probability);
      fi;
    od;
    nrNode := nrNode + step;
  od;

end;