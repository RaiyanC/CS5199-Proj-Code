# https://bradfieldcs.com/algos/graphs/prims-spanning-tree-algorithm/
Prims := function(digraph, weights)
local adj_list, v, e, w, mst, visited, i, queue, cost, from, to, node, neighbour, next_vertex, total;

 
# Create an adjacancy list for the edges with their associated weight
adj_list := HashMap();
for v in DigraphVertices(digraph) do
    w := 1;
    adj_list[v] := HashMap();
    for e in OutNeighbors(digraph)[v] do
        adj_list[v][e] := weights[v][w];
        w := w + 1;
    od;
od;


mst := HashMap();
visited := HashSet();
AddSet(visited, 1);

queue := BinaryHeap({x, y} -> x[1] > y[1]);

# Add neighbours of first vertex to heap
w := 1;
for e in OutNeighbors(digraph)[1] do
    Push(queue, [weights[1][w], 1, e]);
    w := w + 1;
od;

total := 0;
while not IsEmpty(queue) do
    node := Pop(queue);
    cost := node[1];
    from := node[2];
    to := node[3];

    if not to in visited then
        AddSet(visited, to);

        if not from in mst then
            mst[from] := [];
        fi;


        Add(mst[from], to);
        total := total + cost;

        for neighbour in KeyValueIterator(adj_list[to]) do
            next_vertex := neighbour[1];
            cost := neighbour[2];

            if not next_vertex in visited then
                Push(queue, [cost, to, next_vertex]);
            fi;
        od;
    fi;
od;

return [total, mst];
end;