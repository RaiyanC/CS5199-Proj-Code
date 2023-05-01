push := function(capacityMatrix, flowMatrix, excess, u, v)
    local send;

    send := Minimum(excess[u], capacityMatrix[u][v] - flowMatrix[u][v]);
    flowMatrix[u][v] := flowMatrix[u][v] + send;
    flowMatrix[v][u] := flowMatrix[v][u] - send;
    excess[u] := excess[u] - send;
    excess[v] := excess[v] + send;

    # if capacityMatrix[u][v] - flowMatrix[u][v] > 0 then
    #     return 1;
    # fi;

end;

relabel := function(capacityMatrix, flowMatrix, height, u)
    local minHeight, v;

    minHeight := infinity;
    for v in [1..Size(capacityMatrix)] do
        if capacityMatrix[u][v] - flowMatrix[u][v] > 0 then
            minHeight := Minimum(minHeight, height[v]);
        fi;
    od;
    height[u] := minHeight + 1;
end;

discharge := function(capacityMatrix, flowMatrix, excess, seen, height, u)
    local v, flag;

    while excess[u] > 0 do
        if seen[u] < Size(capacityMatrix) then
            v := seen[u];
            if capacityMatrix[u][v] - flowMatrix[u][v] > 0 and height[u] > height[v] then
                flag := push(capacityMatrix, flowMatrix, excess, u, v);
                if flag = 1 then
                    return 1;
                fi;
            else
                seen[u] := seen[u] + 1;
            fi;
        else
            relabel(capacityMatrix, flowMatrix, height, u);
            seen[u] := 0;
        fi;
    od;
end;    

PushRelabel := function(digraph, source, sink)
    local weights, capacityMatrix, digraphVertices, nrVertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, outNeighbours, w, mst, 
    visited, i, j, k, queue, cost, node, neighbour, total, distances, parents, flowMatrix, seen,
    excess, height, p, oldHeight, flag, nodeList;

    weights := EdgeWeights(digraph);

    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);

    outs := OutNeighbors(digraph);
    ins := InNeighbors(digraph);

    capacityMatrix := EmptyPlist(nrVertices);
    flowMatrix := EmptyPlist(nrVertices);
    seen := EmptyPlist(nrVertices); # neighbours since last relabel
    nodeList := [];
    excess := EmptyPlist(nrVertices);
    height := EmptyPlist(nrVertices);

    # fill adj and max flow with zeroes
    for u in digraphVertices do
        capacityMatrix[u] := EmptyPlist(nrVertices);
        flowMatrix[u] := EmptyPlist(nrVertices);
        seen[u] := 0;
        height[u] := 0;
        excess[u] := 0;

        if u <> source and u <> sink then
            Add(nodeList, u);
        fi;

        for v in digraphVertices do
            capacityMatrix[u][v] := 0;
            flowMatrix[u][v] := 0;
        od;
    od;

    for u in digraphVertices do
        outNeighbours := outs[u];
        for idx in [1..Size(outNeighbours)] do
            v := outNeighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            capacityMatrix[u][v] := w;
            # flowMatrix[u][v] := 0;
            # flowMatrix[v][u] := 0;
            # if edge already exists
            # if capacityMatrix[u][v][1] <> 0 then
            #     Add(capacityMatrix[u][v], w); 
            #     Add(flowMatrix[u][v], 0); 
            #     Add(flowMatrix[v][u], 0);
            # else 
            #     capacityMatrix[u][v][1] := w;
            # fi;
        od;
    od;

    height[source] := nrVertices;
    excess[source] := infinity;

    Print(capacityMatrix, "\n");

    for v in [1 .. nrVertices] do
        # for e in [1..Size(flowMatrix[u][v])] do
            if capacityMatrix[source][v] > 0 then
                push(capacityMatrix, flowMatrix, excess, source, v);
            fi;
        # od;
    od;
    # Print(nodeList, "\n");
    p := 1;
    while p < Length(nodeList) do
        u := nodeList[p];
        oldHeight := height[u];
        flag := 0;
        flag := discharge(capacityMatrix, flowMatrix, excess, seen, height, u);
        if height[u] > oldHeight then
            Add(nodeList, Remove(nodeList, p), 1);
            p := 0;
        else
            p := p + 1;
            if flag = 1 then
                break;
            fi;
        fi;
    od;

    # Print(flowMatrix, "\n");

    Print("height ", height, "\n");
    Print("excess ", excess, "\n");
    return Sum(flowMatrix[sink]);


    # for u in digraphVertices do
    #     outNeighbours := outs[u];
    #     for idx in [1..Size(outNeighbours)] do
    #         v := outNeighbours[idx]; # the out neighbour
    #         w := weights[u][idx]; # the weight to the out neighbour

    #         # if edge already exists
    #         if capacityMatrix[u][v][1] <> 0 then
    #             Add(capacityMatrix[u][v], w); 
    #             Add(flowMatrix[u][v], 0); 
    #             Add(flowMatrix[v][u], 0);
    #         else 
    #             capacityMatrix[u][v][1] := w;
    #         fi;
    #     od;
    # od;


end;