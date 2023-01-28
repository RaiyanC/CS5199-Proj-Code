# https://www.programiz.com/dsa/kruskal-algorithm
Kruskals := function(digraph, weights)
local mst, i, e, u, v, w, x, y, number_of_vertices, out_neighbours, idx, edge_list, parent, rank, node, total;

number_of_vertices := DigraphNrVertices(digraph);
edge_list := [];
for u in DigraphVertices(digraph) do
    out_neighbours := OutNeighbors(digraph)[u];
    for idx in [1..Size(out_neighbours)] do
        v := out_neighbours[idx]; # the out neighbour
        w := weights[u][idx]; # the weight to the out neighbour

        Add(edge_list, [w, u, v]);
        Add(edge_list, [w, v, u]);
    od;
od;

mst := HashMap();
i := 1;
e := 1;

StableSortBy(edge_list, x -> x[1]); # merge sort by ascending edge weight

parent := [];
rank := [];

for v in [1..number_of_vertices] do
    Add(parent, v);
    Add(rank, 1);
od;

total := 0;
while e < (number_of_vertices) do
    node := edge_list[i];
    w := node[1];
    u := node[2];
    v := node[3];
    
    i := i + 1;

    x := find(parent, u);
    y := find(parent, v);

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

return [total, mst];
end;



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

