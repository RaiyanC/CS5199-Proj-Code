TestMFAlgorithms := function(n, p)
    local i, rd, dc, ek, nrVertices;
    Print("Running tests on max flow algorithms... \n");
    for i in [2..n] do
        rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph,i,p); 
        Print("running.. ", i, " vertices (", Size(DigraphEdges(rd)) ," edges) ..");
        nrVertices := Size(DigraphVertices(rd));
        dc := DigraphMaximumFlow(rd, 1, nrVertices);;
        ek := Edmondkarp(rd, 1, nrVertices);;
        if dc.maxFlow <> ek.maxFlow then
            Print("Output from Dinics\n", dc);
            Print("Output from Edmond Karp\n", ek);
            ErrorNoReturn("test with ", i, " vertices failed");
        fi;
        Print("passed!\n");
    od;
    Print("-- ALL TEST CASES PASSED --\n");
    return true;
end;