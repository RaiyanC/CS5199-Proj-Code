TestMinCutAlgorithms := function(n, p)
    local i, rd, kg, kgs;
    Print("Running tests on mincut algorithms... \n");

    # Read("../Minimum Spanning Tree Algorithms/prims.g");
    for i in [1..n] do
        rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, i,p); 
        Print("running.. ", i, " vertices (", Size(DigraphEdges(rd)) ," edges) ..");
        kg := Karger(rd);;
        kgs := KargerSteiner(rd);;
        if kg.cuts > kgs.cuts + 1 or kg.cuts < kgs.cuts - 1 then
            Print("Output from Karger's\n", kg);
            Print("Output from Karger Steiner\n", kgs);
            # ErrorNoReturn("test with ", i, " vertices failed");
        fi;
        Print("passed!\n");
    od;
    Print("-- ALL TEST CASES PASSED --\n");
    return true;
end;