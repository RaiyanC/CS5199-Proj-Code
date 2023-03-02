CreateRandomSPGraph := function(number_of_vertices, probability)
    local random_graph, weights, used_weights, digraph_vertices,
    number_of_edges, random_weights, out_neighbours, u, idx, random_weight_idx, 
    adjacencyList, vertices, startVertex, tree, x, i, j;

    adjacencyList := EmptyPlist(n);

    vertices := [1 .. n];

    for i in vertices do
        Add(adjacencyList, []);
    od;

    # Starting from a random vertex, we first create a tree to guarantee
    # connectivity
    startVertex := Remove(vertices, Random(vertices));
    tree := [startVertex];

    # While there are n-1 remaining vertices to be added to the tree
    for x in [1 .. n - 1] do
        # Create an edge from a random vertex in the tree, to a random vertex
        # outside of it
        i := Random(tree);
        j := Remove(vertices, Random([1 .. Length(vertices)]));
        Add(tree, j);
        Add(adjacencyList[i], j);
    od;

    # Once the tree has been created, we fill out the rest of the graph with
    # random edges according to p
    adjacencyList := DIGRAPHS_FillOutGraph(n, p, adjacencyList);
   

    # random_graph := RandomDigraph(IsConnectedDigraph, number_of_vertices, probability); # random connected digraph
    random_graph :=  DigraphNC(adjacencyList);
    digraph_vertices := DigraphVertices(random_graph); 
    number_of_edges := DigraphNrEdges(random_graph) + 1; 

    
    random_weights := Shuffle([1..number_of_edges]);
    weights := [];
    random_weight_idx := 1;


    # Create random weights for each edge. weights are unique [1..number of edges]
    for u in digraph_vertices do
        out_neighbours := OutNeighbors(random_graph)[u];
        Add(weights, []);
        for idx in [1..Size(out_neighbours)] do
            weights[u][idx] := random_weights[random_weight_idx];
            random_weight_idx := random_weight_idx + 1;        
        od;
    od;

    return rec(random_graph:=random_graph, weights:=weights, start:=1, destination:=number_of_vertices);
end;