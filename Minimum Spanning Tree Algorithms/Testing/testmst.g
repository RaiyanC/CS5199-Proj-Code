TestMSTAlgorithms := function(n, p)
    local i, rd, pr, k, b;
    Print("Running tests on minimum spanning tree algorithms... \n");

    # Read("../Minimum Spanning Tree Algorithms/prims.g");
    for i in [1..n] do
        rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, i,p); 
        Print("running.. ", i, " vertices (", Size(DigraphEdges(rd)) ," edges) ..");
        k := DigraphEdgeWeightedMinimumSpanningTree(rd);;
        pr := Prims(rd);;
        b := Boruvka(rd);;
        if pr.total <> k.total and pr.mst <> k.mst and pr.total <> b.total and pr.mst <> b.mst then
            Print("Output from Prims\n", pr);
            Print("Output from Kruskals\n", k);
            Print("Output from Boruvka\n", b);
            ErrorNoReturn("test with ", i, " vertices failed");
        fi;
        Print("passed!\n");
    od;
    Print("-- ALL TEST CASES PASSED --\n");
    return true;
end;