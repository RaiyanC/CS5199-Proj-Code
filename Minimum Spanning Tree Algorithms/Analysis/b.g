find := function(parent, i)
    if parent[i] = i then
        return i;
    fi;

    parent[i] := find(parent, parent[i]);
    return parent[i];
end;


union := function(parent, rank, x, y)
    local xroot, yroot;

    xroot := find(parent, x);
    yroot := find(parent, y);

    if rank[xroot] < rank[yroot] then
        parent[xroot] := yroot;
    elif rank[xroot] > rank[yroot] then
        parent[yroot] := xroot;
    else
        parent[yroot] := xroot;
        rank[xroot] := rank[xroot] + 1;
    fi;
end;

Boruvka := function(digraph, probability)
    local parent, rank, cheapest, nrTrees, nrVertices, total, u, v, mst, mstWeights, weights,
    edgeList, e, x, y, outNeigbours, idx,w, analysisPath, headers, nrEdges, startTime, endTime, data;

    weights := EdgeWeights(digraph);

    nrVertices := DigraphNrVertices(digraph);

    parent := [];
    rank := [];
    mst := [];
    mstWeights := [];
    total := 0;
    nrTrees := nrVertices;
    cheapest := EmptyPlist(nrVertices);

    edgeList := [];
    for u in DigraphVertices(digraph) do
        outNeigbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(outNeigbours)] do
            v := outNeigbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            Add(edgeList, [w, u, v]);
        od;
    od;

    for v in [1..nrVertices] do
        Add(parent, v);
        Add(rank, 1);
        Add(mst, []);
        Add(mstWeights, []);
        cheapest[v] := fail;
    od;

    # ANALYSIS: HERE START TIME

    nrEdges := Size(DigraphEdges(digraph));
    startTime := Runtimes().user_time;


    while nrTrees > 1 do
        for e in edgeList do
            w := e[1];
            u := e[2];
            v := e[3];

            x := find(parent, u);
            y := find(parent, v);

            if x <> y then
                if cheapest[x] = fail or cheapest[x][1] > w then
                    cheapest[x] := [w,u,v];
                fi;

                if cheapest[y] = fail or cheapest[y][1] > w then
                    cheapest[y] := [w,u,v];
                fi;
            fi;
        od;

        for v in [1 .. nrVertices] do
            if cheapest[v] <> fail then
                w := cheapest[v][1];
                u := cheapest[v][2];
                v := cheapest[v][3];

                x := find(parent, u);
                y := find(parent, v);

                if x <> y then
                    total := total + w;
                    Add(mst[u], v);
                    Add(mstWeights[u], w);

                    union(parent, rank, x, y);
                    nrTrees := nrTrees - 1;
                fi;
            fi;
        od;

        cheapest := EmptyPlist(nrVertices);

        for v in [1..nrVertices] do
            cheapest[v] := fail;
        od;
    od;

    # ANALYSIS: HERE STOP TIME
    endTime := Runtimes().user_time;

    analysisPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/",
                    Concatenation(String(probability), "/b.csv"));


    data := Concatenation(String(nrVertices), 
    Concatenation(",", 
    Concatenation(String(nrEdges), 
    Concatenation(",",
    Concatenation(String(startTime),
    Concatenation(",",
    Concatenation(String(endTime), "\n")))))));

    AppendTo(analysisPath, data);

    return rec(total:=total, mst:=EdgeWeightedDigraph(mst, mstWeights));
end;