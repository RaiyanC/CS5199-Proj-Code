This README shows how to run the files in this project.

Clone https://github.com/RaiyanC/Digraphs to be able to use all the algorithms implemented.

You will need GAP and these packages PackageManger, Digraphs, Profiling
- GAP: https://www.gap-system.org/Download/

In the GAP terminal load the PackageManager (https://gap-packages.github.io/PackageManager/doc/chap1_mj.html) and then install the following.

```
InstallPackage("digraphs");
InstallPackage("profiling");
```

# Important
All the edge weighted algorithms are implemented in Digraphs/GAP/weights.gi file so you only need to clone https://github.com/RaiyanC/Digraphs or the Digraphs folder in my submission into GAP/pkg/. See the user manual in the report on how to use these functions. You may need to ```LoadPackage("digraphs");``` and ```CompilePackage("digraphs");```  after cloning / copying my Digraphs folder into GAP/pkg/.

Within the Digraphs package, the majority of this package is not my code except for these changes:
- doc/z-chap5.xml: I added the section under Edge Weights which contains the header for the documentation I wrote.
- gap/doc.g: Adding weights.xml to the list of DIGRAPHS_DocXMLFiles.
- init.g: Adding weights.gd to the packages to be read in.
- Read.g: Adding weights.gi to the packages to be read in.
- tst/testinstall.tst: Added a very basic test to test creation of EdgeWeightedDigraph and some other functions.
- doc/weights.xml: This file is entirely written by me and contains documentation for the all the functions.
- gap/weights.gd: Added headers for functions implemented in weights.gi. Also written entirely by myself.
- gap/weights.gi: Implemented EdgeWeightedDigraph as well as all the implementations for edge weighted digraph functions. Also implemented by me.
- tst/standard/weights.tst: Added tests for all the functions implemented in weights.gi.


# File Structure
- Digraphs/: this is the digraphs package that I have been working with.
- ExampleDots/: These are the dot files created for the report to demonstrate visualisation.
- MaximalFlowAlgorithms/: This contains the files used for prototyping and analysing the maximal flow algorithms.
- MinimumSpanningTreeAlgorithms/: This contains the files used for prototyping and analysing the minimum spanning tree algorithms.
- PDFS/: This just contains the Ethics Assessment form.
- Profiles/: This contains all the code profiles that I did.
- ShortestPathAlgorithms/: This contains the files used for prototyping and analysing the shortest path algorithms.


- CITATION.cff: This is for citing the github repository.
- setup.sh: This was used to automatically move the changed files from Digraphs/ to the GAP installation
- UNIT-TESTS-EWD: This was where I was started writing the unit test for Edge Weighted Digraphs.

# Minimum Spanning Trees
Enter into the GAP terminal and to run each algorithm, run the following:

- boruvka.g
```
Read("../Minimum Spanning Tree Algorithms/boruvka.g");
Boruvka(<digraph>);
```
- kruskals.g
```
Read("../Minimum Spanning Tree Algorithms/kruskals.g");
Kruskals(<digraph>);
```
- prims.g
```
Read("../Minimum Spanning Tree Algorithms/prims.g");
Prims(<digraph>);
```
- mst_graph_creator.g
```
Read("../Minimum Spanning Tree Algorithms/mst_graph_creator.g");
CreateRandomMSTGraph(<filter>, <n>, <p>);  #Example:CreateRandomMSTGraph(IsStronglyConnectedDigraph, 100, 0.01);
```

## Testing
- testmst.g

First read in the algorithms for Boruvka and Prims as above and then run
```
Read("../Minimum Spanning Tree Algorithms/Testing/testmst.g");
TestMSTAlgorithms(<n>, <p>); #Example:TestMSTAlgorithms(200, 0.01);
```


## Analysis
- tester.g
```
Read("../Minimum Spanning Tree Algorithms/Analysis/tester.g");
Runtests(<alg>, <number of max nodes>, <probability>, <number of iterations>, <step>) #Example:Runtests("all", 100, 0.01, 5, 10);
```
where \<alg\> may be one of:
- "all", "p", "b", "kv2"

number of max nodes is how many nodes you would like to test up to

probability is the edge probability

number of iterations is the number of repeats we want

step is the difference between each set of iterations

This will start writing the data for the algorithms to "./Minimum Spanning Tree Algorithms/Analysis/\<probability\>/\<alg\>.csv

- analyser.py [-p: required] [-c: default false] [-s: default false]

Once we have csv data, we can run this to plot the data

If we only want to plot the data and not save or compare
```
python3 analyser.py -p <paths to csvs>
```
Example
```
python3 analyser.py -p "./1/p.csv" "./0.5/p.csv" "./0.25/p.csv" "./0.125/p.csv" "./0.01/p.csv"
```
If we want to plot and save the plot to file
```
python3 analyser.py -p <paths to csvs> -s
```
Example
```
python3 analyser.py -p "./1/p.csv" "./0.5/p.csv" "./0.25/p.csv" "./0.125/p.csv" "./0.01/p.csv" -s
```
If we want to compare two or more algorithms
```
python3 analyser.py -p <paths to csvs> <paths to other csvs> -c
```
Example
```
python3 analyser.py -p "./1/p.csv" "./0.5/p.csv" "./0.25/p.csv" "./0.125/p.csv" "./0.01/p.csv" "./1/kv2.csv" "./0.5/kv2.csv" "./0.25/kv2.csv" "./0.125/kv2.csv" "./0.01/kv2.csv" -c
```
If we want to compare two or more algorithms and save plot to file
```
python3 analyser.py -p <paths to csvs> <paths to other csvs> -c -s
```
Example
```
python3 analyser.py -p "./1/p.csv" "./0.5/p.csv" "./0.25/p.csv" "./0.125/p.csv" "./0.01/p.csv" "./1/kv2.csv" "./0.5/kv2.csv" "./0.25/kv2.csv" "./0.125/kv2.csv" "./0.01/kv2.csv" -c -s
```
- mst-python.py
This file creates data for the Scipy implementations
```
python3 mst-python.py [-n: required] <n> [-p: required] <p> [-w: default false]
```
where n is number of nodes, p is the edge probability and w is if we want to write the data or not
Example
```
python3 python3 mst-python.py -n 100 -p 0.01 -w
```

# Shortest Path Algorithms
Enter into the GAP terminal and to run each algorithm, run the following:

All other files that are not shown how to run were simply test files.

- dijkstra.g
```
Read("../Shortest Path Algorithms/dijkstra.g");
Dijkstra(<digraph>, <start>);
```
- bellmanford.g
```
Read("../Shortest Path Algorithms/bellmanford.g");
Bellman(<digraph>, <start>);
```
- floydwarshall.g
```
Read("../Shortest Path Algorithms/floydwarshall.g");
Floyd(<digraph>);
```
- johnson.g
```
Read("../Shortest Path Algorithms/johnson.g");
Johnson(<digraph>);
```

## Testing
- shortestpath.g

First read in the required algorithms as above and then run
```
Read("../Shortest Path Algorithms/Testing/shortestpath.g");
TestShortestPathAlgorithms(<n>, <p>); #Example:TestShortestPathAlgorithms(200, 0.01);
```
- shortestpaths.g
```
Read("../Shortest Path Algorithms/Testing/shortestpath.g");
TestShortestPathsAlgorithms(<n>, <p>); #Example:TestShortestPathsAlgorithms(200, 0.01);
```

## Analysis
- tester.g
```
Read("../Shortest Path Algorithms/Analysis/tester.g");
Runtests(<alg>, <number of max nodes>, <probability>, <number of iterations>, <step>) #Example:Runtests("all", 100, 0.01, 5, 10);
```
where \<alg\> may be one of:
- "all", "sp" (shortest path: "d" and "bmfv2"), "sps" (shortest paths: "flw" and "j"), "d", "bmfv2", "flw", "j"

number of max nodes is how many nodes you would like to test up to

probability is the edge probability

number of iterations is the number of repeats we want

step is the difference between each set of iterations

This will start writing the data for the algorithms to "./Shortest Path Algorithms/Analysis/\<probability\>/\<alg\>.csv

- analyser.py [-p: required] [-c: default false] [-s: default false]

Once we have csv data, we can run this to plot the data

If we only want to plot the data and not save or compare
```
python3 analyser.py -p <paths to csvs>
```
Example
```
python3 analyser.py -p "./1/d.csv" "./0.5/d.csv" "./0.25/d.csv" "./0.125/d.csv" "./0.01/d.csv"
```
If we want to plot and save the plot to file
```
python3 analyser.py -p <paths to csvs> -s
```
Example
```
python3 analyser.py -p "./1/d.csv" "./0.5/d.csv" "./0.25/d.csv" "./0.125/d.csv" "./0.01/d.csv" -s
```
If we want to compare two or more algorithms
```
python3 analyser.py -p <paths to csvs> <paths to other csvs> -c
```
Example
```
python3 analyser.py -p "./1/d.csv" "./0.5/d.csv" "./0.25/d.csv" "./0.125/d.csv" "./0.01/d.csv" "./1/bmfv2.csv" "./0.5/bmfv2.csv" "./0.25/bmfv2.csv" "./0.125/bmfv2.csv" "./0.01/bmfv2.csv" -c
```
If we want to compare two or more algorithms and save plot to file
```
python3 analyser.py -p <paths to csvs> <paths to other csvs> -c -s
```
Example
```
python3 analyser.py -p "./1/d.csv" "./0.5/d.csv" "./0.25/d.csv" "./0.125/d.csv" "./0.01/d.csv" "./1/bmfv2.csv" "./0.5/bmfv2.csv" "./0.25/bmfv2.csv" "./0.125/bmfv2.csv" "./0.01/bmfv2.csv" -c -s
```


# Maximal Flow Algorithms
Enter into the GAP terminal and to run each algorithm, run the following:

All other files that are not shown how to run were simply test files.

- edmondkarp.g
```
Read("../Maximal Flow Algorithms/edmondkarp.g");
Dijkstra(<digraph>, <start>);
```
- dinic.g
```
Read("../Maximal Flow Algorithms/dinic.g");
Edmondkarp(<digraph>, <start>, <destination>);
```
- floydwarshall.g
```
Read("../Shortest Path Algorithms/floydwarshall.g");
Dinic(<digraph>, <start>, <end>);
```
- kargers.g
```
Read("../Maximal Flow Algorithms/kargers.g");
Karger(<digraph>);
```
- kargersteiner.g
```
Read("../Maximal Flow Algorithms/kargersteiner.g");
KargerSteiner(<digraph>);
```

## Testing
- testmf.g

First read in the required algorithms as above and then run
```
Read("../Shortest Path Algorithms/Testing/testmf.g");
TestMFAlgorithms(<n>, <p>); #Example:TestMFAlgorithms(200, 0.01);
```
- testmincut.g
```
Read("../Shortest Path Algorithms/Testing/testmincut.g");
TestTestMinCutAlgorithmsMFAlgorithms(<n>, <p>); #Example:TestMinCutAlgorithms(200, 0.01);
```

## Analysis
- tester.g
```
Read("../Maximal Flow Algorithms/Analysis/tester.g");
Runtests(<alg>, <number of max nodes>, <probability>, <number of iterations>, <step>) #Example:Runtests("all", 100, 0.01, 5, 10);
```
where \<alg\> may be one of:
- "all", "dc", "ek", "pr"

number of max nodes is how many nodes you would like to test up to

probability is the edge probability

number of iterations is the number of repeats we want

step is the difference between each set of iterations

This will start writing the data for the algorithms to "./Shortest Path Algorithms/Analysis/\<probability\>/\<alg\>.csv

- analyser.py [-p: required] [-c: default false] [-s: default false]

Once we have csv data, we can run this to plot the data

If we only want to plot the data and not save or compare
```
python3 analyser.py -p <paths to csvs>
```
Example
```
python3 analyser.py -p "./1/dc.csv" "./0.5/dc.csv" "./0.25/dc.csv" "./0.125/dc.csv" "./0.01/dc.csv"
```
If we want to plot and save the plot to file
```
python3 analyser.py -p <paths to csvs> -s
```
Example
```
python3 analyser.py -p "./1/dc.csv" "./0.5/dc.csv" "./0.25/dc.csv" "./0.125/dc.csv" "./0.01/dc.csv" -s
```
If we want to compare two or more algorithms
```
python3 analyser.py -p <paths to csvs> <paths to other csvs> -c
```
Example
```
python3 analyser.py -p "./1/dc.csv" "./0.5/dc.csv" "./0.25/dc.csv" "./0.125/dc.csv" "./0.01/dc.csv" "./1/ek.csv" "./0.5/ek.csv" "./0.25/ek.csv" "./0.125/ek.csv" "./0.01/ek.csv" -c
```
If we want to compare two or more algorithms and save plot to file
```
python3 analyser.py -p <paths to csvs> <paths to other csvs> -c -s
```
Example
```
python3 analyser.py -p "./1/dc.csv" "./0.5/dc.csv" "./0.25/dc.csv" "./0.125/dc.csv" "./0.01/dc.csv" "./1/ek.csv" "./0.5/ek.csv" "./0.25/ek.csv" "./0.125/ek.csv" "./0.01/ek.csv" -c -s
```
