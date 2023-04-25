TestMaxFlowAlgorithms := function(n, p)
    local i, rd, ek, d, dest;
    Print("Running tests on maximum flow algorithms... \n");
    for i in [2..n] do
        rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph,i,p); 
        dest := Size(DigraphVertices(rd));
        Print("running.. ", i, " vertices (", Size(DigraphEdges(rd)) ," edges) ..");
        ek := Edmondkarp(rd, 1, dest);;
        d := DigraphMaximumFlow(rd, 1, dest);;
        if ek.maxFlow <> d.maxFlow then
            Print("Output from EdmondKarp\n", ek);
            Print("Output from Dinic\n", d);
            ErrorNoReturn("test with ", i, " vertices failed");
        fi;
        Print("passed!\n");
    od;
    Print("-- ALL TEST CASES PASSED --\n");
    return true;
end;