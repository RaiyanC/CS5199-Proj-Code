TestMFAlgorithms := function(n, p)
    local i, rd, ek, d;
    Print("Running tests on maximum flow algorithms algorithms... \n");

    # Read("../Minimum Spanning Tree Algorithms/prims.g");
    for i in [2..n] do
        rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, i,p); 
        Print("running.. ", i, " vertices (", Size(DigraphEdges(rd)) ," edges) ..");
        ek := Edmondkarp(rd, 1, i);;
        d := DigraphMaximumFlow(rd, 1, i);;
        if ek.maxFlow <> d.maxFlow then
            Print("Output from Edmond-Karp\n", ek);
            Print("Output from Dinic\n", d);
            ErrorNoReturn("test with ", i, " vertices failed");
        fi;
        Print("passed!\n");
    od;
    Print("-- ALL TEST CASES PASSED --\n");
    return true;
end;