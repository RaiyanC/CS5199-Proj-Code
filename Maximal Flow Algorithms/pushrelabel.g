push := function(capacityMatrix, flowMatrix, excess, queue, u, v)
    local d;
    
    d := Minimum(excess[u], capacityMatrix[u][v] - flowMatrix[u][v]);
    flowMatrix[u][v] := flowMatrix[u][v] + d;
    flowMatrix[v][u] := flowMatrix[v][u] - d;
    excess[u] := excess[u] - d;
    excess[v] := excess[v] + d;

    if d = 1 and excess[v] = d then
        PlistDequePushBack(queue, v);
    fi;
end;

relabel := function(capacityMatrix, flowMatrix, height, u)
    local d, v;

    d := infinity;
    for v in [1..Size(capacityMatrix)] do
        if capacityMatrix[u][v] - flowMatrix[u][v] > 0 then
            d := Minimum(d, height[v]);
        fi;
    od;
    if d < infinity then
        height[u] := d + 1;
    fi;
    
end;

discharge := function(capacityMatrix, flowMatrix, excess, seen, height, queue, u)
    local v;
    
    while excess[u] > 0 do
        if seen[u] <= Size(capacityMatrix) then
            v := seen[u];
            if capacityMatrix[u][v] - flowMatrix[u][v] > 0 and height[u] > height[v] then
                push(capacityMatrix, flowMatrix, excess, queue, u, v);
            else
                seen[u] := seen[u] + 1;
            fi;
        else
            relabel(capacityMatrix, flowMatrix, height, u);
            seen[u] := 1;
        fi;
    od;
end;    

GetFlowInformation := function(flowMatrix, source)
    local parents, flows, u, v, e, nrVertices, edges, max_flow, _, i;

    nrVertices := Size(flowMatrix);

    parents := EmptyPlist(nrVertices);
    flows := EmptyPlist(nrVertices);
    max_flow := 0;

    # create empty 2D list for output
    for _ in [1..nrVertices] do
        Add(parents, []);
        Add(flows, []);
    od; 
    
    # initialise source values
    parents[source] := [];
    flows[source] := [];
    
    for u in [1..nrVertices] do
        for v in [1..nrVertices] do
            for e in [1..Size(flowMatrix[u][v])] do
                if Float(flowMatrix[u][v][e]) > Float(0) then
                    # add parents for each flow
                    for i in [1..Size(flowMatrix[u][v])] do
                        Add(parents[v], u);
                        Add(flows[v], flowMatrix[u][v][i]);
                        if u = source then
                            max_flow := max_flow + flowMatrix[u][v][i];
                        fi;
                    od;
                    break;
                fi;
            od;
            
        od;
    od;


    return [parents, flows, max_flow];
end;

PushRelabel := function(digraph, source, sink)
    local weights, capacityMatrix, digraphVertices, nrVertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, outNeighbours, w, mst, 
    visited, i, j, k, queue, cost, node, neighbour, total, distances, parents, flowMatrix, seen,
    excess, height, p, oldHeight, flag, flowInformation;

    weights := EdgeWeights(digraph);

    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);

    outs := OutNeighbors(digraph);
    ins := InNeighbors(digraph);

    capacityMatrix := EmptyPlist(nrVertices);
    flowMatrix := EmptyPlist(nrVertices);
    seen := EmptyPlist(nrVertices);
    height := EmptyPlist(nrVertices);
    excess := EmptyPlist(nrVertices);
    queue := PlistDeque();

    # fill adj and max flow with zeroes
    for u in digraphVertices do
        capacityMatrix[u] := EmptyPlist(nrVertices);
        flowMatrix[u] := EmptyPlist(nrVertices);
        seen[u] := 1;
        height[u] := 0;
        excess[u] := 0;

        if u <> source and u <> sink then
            PlistDequePushBack(queue, u);
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
        od;
    od;

    height[source] := nrVertices;
    excess[source] := infinity;

    for v in [1 .. nrVertices] do
        if v <> source then
            push(capacityMatrix, flowMatrix,excess, queue, source, v);
        fi;
    od;

    while not IsEmpty(queue) do
        u := PlistDequePopFront(queue);
        if u <> source and u <> sink then
            discharge(capacityMatrix, flowMatrix, excess, seen, height, queue, u);
        fi;
    od;


    flowInformation := GetFlowInformation(flowMatrix, source);
    return rec(
        parents:=flowInformation[1], 
    flows:=flowInformation[2],
    maxFlow:=flowInformation[3]
    );
    # return Sum(flowMatrix[source]);
end;