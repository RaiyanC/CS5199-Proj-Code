# # Test function to calculate the sum of elements in a list
# # test := function(l)
# # local sum, ele;
# # sum := 0;
# # for ele in l do 
# #     sum := sum + 1;
# # od;
# # return sum;
# # end;

# # local sum, ele;
# # sum := 0;
# # while sum <> 5 do
# #     sum := sum + 1;
# # od;
# # return sum;
# # end;

# # DigraphWithEdgeWeights := function(digraph, weights)

# # local d, n, test;

# # test := DigraphNrVertices(digraph);
# # Print(test);

# # if test = 2 then
# #     ErrorNoReturn("too many vertices");
# # fi;
# # # for d in digraph do
# # #     for n in d do
# # #         Print(n);
# # #     od;
# # # od;
# # Print("\n");
# # return true;
# # end;

# # Prims := function(digraph, weights)

# # # check lengths of graph and weights are equal
# # local n, m, o, p, i, j, k, d, source;

# # source := 1;
# # # priority_queue := BinaryHeap();

# # for d in DigraphVertices(digraph) do
# #     Print(d, "\n");
# # od;

# # # n := DigraphNrVertices(digraph);
# # # m := DigraphNrEdges(digraph);

# # # Print("nr vertices ", n);
# # # Print("\n");
# # # Print("nr edges ", m);

# # # for d in digraph do
# # #     Print(d);
# # # od;

# # # for i in weights do
# # #     for j in i do
# # #         Print("Weight ",j, "\n");
# # #     od;
# # # od;
# # Print("\n");
# # return true;
# # end;

# # select_min_vertex := function(value, setMST)


# # end;

# # Prims started with adj list
# # Prims := function(digraph, weights)
# # # Print("Digraph ", DotDigraph(digraph), "\n");
# # local adj_list, v, e, w, mst;


# # Print("Weights ", weights, "\n");

# # # Create an adjacancy list for the edges with their associated weight
# # adj_list := HashMap();
# # for v in DigraphVertices(digraph) do
# #     w := 1;
# #     adj_list[v] := [];
# #     for e in OutNeighbors(digraph)[v] do
# #         Print("Vertex: ", v, " neighbour: ", e, " weight: ", weights[v][w],"\n");
# #         Add(adj_list[v], [e, weights[v][w]]);
# #         w := w + 1;
# #     od;
# # od;

# # Print("Adj list: ", adj_list, "\n");
# # mst := [];

# # return mst;
# # end;


# # prims attempt with adj matrix- slow O(V^2) time complexity. improve using fibonacci heap? also
# # can do with adj list better for sparse graphs, this is better for dense graphs.
# Prims := function(digraph, weights)
# local nr_vertices, edge, selected, min, x, y, i, j, graph, v, e, w, mst, total;

# nr_vertices := DigraphNrVertices(digraph);
# selected := [];

# # create 2D array filled with zeros
# graph := [];
# for i in [1..nr_vertices] do
#     Add(graph, []);
#     for j in [1..nr_vertices] do
#         Add(graph[i], 0);
#     od;
# od;


# # fill 2D array with relevant weights
# for v in DigraphVertices(digraph) do
#     w := 1;
#     for e in OutNeighbors(digraph)[v] do
#         graph[v][e] := weights[v][w];
#         w := w + 1;
#     od;
# od; 

# # fill selected with false
# for i in [1..nr_vertices] do
#     Add(selected, false);
# od;

# selected[1] := true;

# mst := [];
# edge := 0;
# total := 0;
# while edge < nr_vertices - 1 do
#     min := infinity;
#     x := 0;
#     y := 0;
    
#     for i in [1..nr_vertices] do
#         if selected[i] = true then 
#             for j in [1..nr_vertices] do
#                 if selected[j] = false and graph[i][j] <> 0 then
#                     if min > graph[i][j] then
#                         min := graph[i][j];
#                         x := i;
#                         y := j;
#                     fi;
#                 fi;
#             od;
#         fi;
#     od;
#     Add(mst, [x, y, graph[x][y]]);
#     total := total + graph[x][y];
#     # Print(x, " to ", y, ": ", graph[x][y], "\n");
#     selected[y] := true;
#     edge := edge + 1;
# od;


# return [total, mst];
# end;

