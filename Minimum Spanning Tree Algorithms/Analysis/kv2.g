# https://www.programiz.com/dsa/kruskal-algorithm
Kruskalsv2 := function(digraph, probability)
    local weights, numberOfVertices, edgeList, u, 
    outNeigbours, idx, v, w, mst, i, e, parent, rank, total, node, x, y,
    analysisPath, headers, nrEdges, startTime, endTime, data, nrVertices;

    weights := EdgeWeights(digraph);

    # create a list of edges containining u-v
    # w: the weight of the edge
    # u: the start vertex
    # v: the finishing vertex of that edge
    numberOfVertices := DigraphNrVertices(digraph);
    edgeList := [];
    for u in DigraphVertices(digraph) do
        outNeigbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(outNeigbours)] do
            v := outNeigbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            Add(edgeList, [w, u, v]);
        od;
    od;

    # ANALYSIS: HERE START TIME

    nrEdges := Size(DigraphEdges(digraph));
    startTime := Runtimes().user_time;
    nrVertices := numberOfVertices;


    mst := HashMap();
    i := 1;
    e := 1;

    # sort edge weights by their weight
    StableSortBy(edgeList, x -> x[1]);

    parent := [];
    rank := [];

    for v in [1..numberOfVertices] do
        Add(parent, v);
        Add(rank, 1);
    od;

    total := 0;
    while e < (numberOfVertices) do
        node := edgeList[i];
        w := node[1];
        u := node[2];
        v := node[3];
        
        i := i + 1;

        x := find(parent, u);
        y := find(parent, v);

        # if cycle doesn't exist
        if x <> y then
            e := e + 1;
            total := total + w;

            if not u in mst then
                mst[u] := [];
            fi;

            Add(mst[u], v);

            union(parent, rank, x, y);
        fi;
od;

# ANALYSIS: HERE STOP TIME
    endTime := Runtimes().user_time;

    analysisPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/",
                    Concatenation(String(probability), "/kv2.csv"));


    data := Concatenation(String(nrVertices), 
    Concatenation(",", 
    Concatenation(String(nrEdges), 
    Concatenation(",",
    Concatenation(String(startTime),
    Concatenation(",",
    Concatenation(String(endTime), "\n")))))));

    AppendTo(analysisPath, data);

return [total, mst];
end;



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

