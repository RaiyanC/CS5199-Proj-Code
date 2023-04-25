TestShortestPathsAlgorithms := function(n, p)
    local i, rd, flw, j;
    Print("Running tests on shortest paths algorithms... \n");
    for i in [1..n] do
        rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph,i,p); 
        Print("running.. ", i, " vertices (", Size(DigraphEdges(rd)) ," edges) ..");
        flw := DIGRAPHS_Edge_Weighted_FloydWarshall(rd);;
        j := DIGRAPHS_Edge_Weighted_Johnson(rd);;
        if flw <> j then
            Print("Output from Floyd Warshall\n", d);
            Print("Output from Johnson\n", j);
            ErrorNoReturn("test with ", i, " vertices failed");
        fi;
        Print("passed!\n");
    od;
    Print("-- ALL TEST CASES PASSED --\n");
    return true;
end;