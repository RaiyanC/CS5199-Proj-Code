find := function(parent, i)
    if parent[i] = i then
        return i;
    fi;

    return find(parent, parent[i]);
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

# https://www.programiz.com/dsa/kruskal-algorithm
Kruskals := function(digraph)
    local weights, numberOfVertices, edgeList, u, 
    outNeigbours, idx, v, w, mst, mstWeights, i, e, 
    parent, rank, total, node, x, y;

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

    mst := [];
    mstWeights := [];
    i := 1;
    e := 1;

    # sort edge weights by their weight
    StableSortBy(edgeList, x -> x[1]);

    parent := [];
    rank := [];

    for v in [1..numberOfVertices] do
        Add(parent, v);
        Add(rank, 1);
        Add(mst, []);
        Add(mstWeights, []);
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

            Add(mst[u], v);
            Add(mstWeights[u], w);

            union(parent, rank, x, y);
        fi;
od;

return rec(total:=total, mst:=EdgeWeightedDigraph(mst, mstWeights));
end;
