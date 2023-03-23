getEuclidianDistance := function(x1, y1, x2, y2)
  local a, b, c;

  a := x2 - x1;
  b := y2 - y1;
  c := a^2 + b^2;

  return Sqrt(Float(c));
end;

CreateRandomEuclidianGraph := function(n, p, xRange, yRange, isNegative, negativeProbability)
  local randomSCGraph, digraph, digraphVertices, nrVertices, outs, weights, randomX1, randomY1,
  randomX2, randomY2, d, u,v, outNeighbours;

  digraph := RandomDigraph(IsStronglyConnectedDigraph, n, p);
  
  digraphVertices := DigraphVertices(digraph);
  nrVertices := Size(digraphVertices);
  outs := OutNeighbors(digraph);

  weights := [];
  for u in digraphVertices do
    weights[u] := [];
    outNeighbours := outs[u];
    for v in outNeighbours do
      randomX1 := Random([1..xRange]);
      randomY1 := Random([1..yRange]);

      randomX2 := Random([1..xRange]);
      randomY2 := Random([1..yRange]);

      d := getEuclidianDistance(randomX1, randomY1, randomX2, randomY2);
      Add(weights[u], d);
    od;
  od;
  
  # return [digraph, weights];
  return rec(random_graph := EdgeWeightedDigraph(digraph, weights), start:=1, destination:=n);
end;