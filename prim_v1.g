# https://www.programiz.com/dsa/prim-algorithm
Prims := function(digraph, weights)
local number_of_vertices, curr_vertex, selected, min, x, y, i, j, adj_matrix, v, e, w, mst, total;

number_of_vertices := DigraphNrVertices(digraph);
selected := [];

# Create 2D array filled with zeros - this is the adjacancy matrix
adj_matrix := [];
for i in [1..number_of_vertices] do
    Add(adj_matrix, []);
    for j in [1..number_of_vertices] do
        Add(adj_matrix[i], 0);
    od;
od;


# Fill the 2D array with weights of the edge
for v in DigraphVertices(digraph) do
    w := 1;
    for e in OutNeighbors(digraph)[v] do
        adj_matrix[v][e] := weights[v][w];
        w := w + 1;
    od;
od; 

# Fill selected with false as we haven't explored any vertices yet
for i in [1..number_of_vertices] do
    Add(selected, false);
od;

selected[1] := true; # start at node 1

mst := HashMap();
curr_vertex := 0;
total := 0;
while curr_vertex < number_of_vertices - 1 do
    min := infinity;
    x := 0;
    y := 0;
    
    for i in [1..number_of_vertices] do
        if selected[i] = true then 
            for j in [1..number_of_vertices] do
                if selected[j] = false and adj_matrix[i][j] <> 0 then
                    if min > adj_matrix[i][j] then
                        min := adj_matrix[i][j];
                        x := i;
                        y := j;
                    fi;
                fi;
            od;
        fi;
    od;
    if not x in mst then
        mst[x] := [];
    fi;

    Add(mst[x], y);
    total := total + adj_matrix[x][y];

    selected[y] := true;
    curr_vertex := curr_vertex + 1;
od;


return [total, mst];
end;


