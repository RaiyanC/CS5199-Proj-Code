TestMSTAlgorithms := function(n, p)
    local i, rd, pr, k;
    Print("Running tests on minimum spanning tree algorithms... \n");

    # Read("../Minimum Spanning Tree Algorithms/prims.g");
    for i in [1..n] do
        rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, i,p); 
        Print("running.. ", i, " vertices (", Size(DigraphEdges(rd)) ," edges) ..");
        k := DigraphEdgeWeightedMinimumSpanningTree(rd);;
        pr := Prims(rd);;
        if pr.total <> k.total then
            Print("Output from Prims\n", pr);
            Print("Output from Kruskals\n", k);
            ErrorNoReturn("test with ", i, " vertices failed");
        fi;
        Print("passed!\n");
    od;
    Print("-- ALL TEST CASES PASSED --\n");
    return true;
end;