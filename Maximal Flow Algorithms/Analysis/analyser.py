import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
import argparse
from collections import defaultdict
import csv

class Plotter():
  def __init__(self, comparison) -> None:
    self.comparison = comparison
    self.headers = ["Vertices", "Probability", "AvgTime"] if not comparison else ["Vertices", "Probability", "AvgTime", "Algorithm"]
    self.df = pd.DataFrame(columns=self.headers)
    self.probabilities = set()
    self.algorithms_analysed = set()
    self.algorithms = {
      "p": "Prim's Algorithm",
      "k": "Kruskal's Algorithm",
      "d": "Dijkstra's Algorithm",
      "bmf": "Bellman Ford Algorithm",
      "flw": "Floyd Warshall Algorithm",
      "ek": "Edmond Karp Algorithm",
      "dc": "Dinic's Algorithm",
      "kg": "Karger's Algorithm",
      "kgs": "KargerSteiner Algorithm"
    }
  

  def add_data(self, algorithm, probability, vertex_to_avgs):
    self.algorithms_analysed.add(self.algorithms[algorithm])
    self.probabilities.add(probability)
    self.df = pd.concat([self.df, pd.DataFrame([[k, probability, v] for k, v in vertex_to_avgs.items()], columns=self.headers)], ignore_index=True)
    

  def add_data_for_algorithms(self, algorithm, probability, vertex_to_avgs):
    full_alg = self.algorithms[algorithm]
    self.algorithms_analysed.add(full_alg)
    self.probabilities.add(probability)
    self.df = pd.concat([self.df, pd.DataFrame([[k, probability, v, full_alg] for k, v in vertex_to_avgs.items()], columns=self.headers)], ignore_index=True)

  def plot(self, save):
    probabilities = list(sorted(self.probabilities))
    if self.comparison:
      title = f"Comparison of {list(self.algorithms_analysed)} for vertices vs average time taken for {probabilities} edge probability"
      graph = sns.relplot(data=self.df, x=self.headers[0], y=self.headers[2], hue=self.headers[3], kind="line")
    else:
      title = f"Graph of vertices vs average time taken for {probabilities} edge probability for {list(self.algorithms_analysed)}"
      graph = sns.relplot(data=self.df, x=self.headers[0], y=self.headers[2], hue=self.headers[1], kind="line")
      
    
    # graph.set(xlabel='Vertices', ylabel='Avg Time (ms)', title=title)
    # graph.set(xlabel='Vertices', ylabel='Avg Time (ms)')
    graph.set(xlabel='Vertices', ylabel='Avg Time (ms)', xlim=0, ylim=0)
    if save:
      plt.savefig(f"./Graphs/{title}.jpg", bbox_inches='tight')
    plt.show()


class Data():
  def __init__(self) -> None:
    self.vertex_to_entry_dict = defaultdict(list) # vertex: [entry1, entry3, entry3]
    self.vertex_to_avgs = {} # vertex: avg_time for each probability for each algorithm

  def add_entry(self, entry):
    self.vertex_to_entry_dict[entry.vertices].append(entry)

  def calculate_average(self): 
    for k, v in self.vertex_to_entry_dict.items():
      size = len(v)
      tot = 0
      for entry in v:
        diff = entry.et - entry.st
        tot += diff
      
      avg = tot / size
      self.vertex_to_avgs[k] = avg


class Entry():
  def __init__(self, vertices, edges, st, et) -> None:
    self.vertices = vertices
    self.edges = edges
    self.st = st
    self.et = et
  
  def __repr__(self) -> str:
    return f"{self.vertices},{self.edges},{self.st},{self.et}\n"

      
if __name__ == "__main__":
  args = argparse.ArgumentParser()
  args.add_argument('-p', '--path', nargs='+', required=True, help="Path of CSV files to plot")
  args.add_argument('-s', '--save', action='store_true', help='Save graph with title')
  args.add_argument('-c', '--compare', action='store_true', help='If multiple algorithms are being compared (provide True or False)')
  args = args.parse_args()

  plotter = Plotter(args.compare)
  for i in range(len(args.path)):
    data = Data()
    probability = float(args.path[i].split("/")[1])
    algorithm = args.path[i].split("/")[-1].split(".")[0]
    with open(args.path[i]) as csv_file:
      csv_reader = csv.reader(csv_file, delimiter=',')
      next(csv_reader) # read headers
      for row in csv_reader:
        vertices, edges, st, et = row
        data.add_entry(Entry(int(vertices), int(edges), int(st), int(et)))

    data.calculate_average()
    if args.compare:
      plotter.add_data_for_algorithms(algorithm, probability, data.vertex_to_avgs)
    else:
      plotter.add_data(algorithm, probability, data.vertex_to_avgs)

  print(plotter.df)
  plotter.plot(args.save)