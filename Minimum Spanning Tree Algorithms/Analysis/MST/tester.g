Runtests := function(alg, nodes, probability, nrIterations, step)
  local algPath, analysisPath, headers, i, random_graph, nrNode, idx, p;

  # read in necessary files
  # Read("../test_creating_edgeweighted_digraph.g");
  Read("../Minimum Spanning Tree Algorithms/mst_graph_creator.g");
  algPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/", 
             Concatenation(String(alg), ".g"));

  Read(algPath);

  analysisPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/MST/", 
                  Concatenation(String(nodes),
                  Concatenation("/",
                  Concatenation(String(alg), ".csv"))));
            
  headers := "Vertices,Edges,StartTime,EndTime\n";
  PrintTo(analysisPath, headers);
  
  p := 0.01;
  while p <= Float(probability) do
    # for i in [1 .. nrIterations] do
        # create random graphs and save them
    #   random_graph := CreateRandomMSTGraph(IsConnectedDigraph, nrNode, p);
    random_graph := RandomUniqueEdgeWeightedDigraph(IsConnectedDigraph,nodes, p);
    #   Boruvka2(random_graph, p);
    #   Prims2(random_graph, p);
      Kruskalsv22(random_graph, p);    
    # od;
    p := p + step;
  od;
end;