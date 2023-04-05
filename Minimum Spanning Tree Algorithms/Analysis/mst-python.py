from scipy.sparse import csr_matrix
from scipy.sparse.csgraph import minimum_spanning_tree
from scipy.sparse.csgraph import connected_components
from scipy.sparse import random
from scipy import stats
from numpy.random import default_rng
import argparse
import time
from timeit import default_timer as timer
import cProfile
import csv

def run_analysis(n, p, writing):  
    csv_path = f"./{p}/mst-py.csv"
    header = ["Vertices","Edges","StartTime","EndTime"]
    edges = -1
    mode = "w" if writing else "a"
    rep = 1
    incr = 1
    with open(csv_path, mode) as f:
        if writing:
            writer = csv.writer(f)
            writer.writerow(header)

        n, p = int(n), float(p)
        rng = default_rng()
        rvs = stats.poisson(25, loc=10).rvs

        for i in range(1, n + 1, incr):
            for _ in range(rep):
                S = random(i, i, density=p, random_state=rng, data_rvs=rvs)
                graph = csr_matrix(S.A.astype(int))
                start_time = round(timer()*1000)
                mst(graph) # run mst algorithm
                end_time = round(timer()*1000)
                data = [i, edges, start_time, end_time]

                if writing:
                    writer.writerow(data)
            



def mst(graph):
    minimum_spanning_tree(graph).toarray().astype(int)

if __name__ == "__main__":
    args = argparse.ArgumentParser()
    args.add_argument('-n', '--nvertices', required=True, help="Number of vertices")
    args.add_argument('-p', '--probability', required=True, help="Density probability")
    args.add_argument('-c', '--cprofile', action='store_true', help="Run profiling")
    args.add_argument('-w', '--write', action='store_true', help="Write to CSV")
    args = args.parse_args()
    
    run_analysis(args.nvertices, args.probability, args.write)
    # cProfile.run('MST()')
