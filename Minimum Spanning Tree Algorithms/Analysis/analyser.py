import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
import argparse
from collections import defaultdict
import csv

class Plotter():
  def __init__(self) -> None:
    self.headers = ["Vertices", "Probability", "AvgTime"]
    self.df = pd.DataFrame(columns=self.headers)
    self.probabilities = []

  def add_data(self, probability, vertex_to_avgs):
    self.probabilities.append(probability)
    self.df = pd.concat([self.df, pd.DataFrame([[k, probability, v] for k, v in vertex_to_avgs.items()], columns=self.headers)], ignore_index=True)
    

  # def add_data_for_algorithms(self, algorithm, probability, vertex_to_avgs):
  #   pass

  def plot(self):
    # df = pd.DataFrame(vertex_to_avgs.items(), columns=['Vertices', 'AvgTime'])
    # sns.lineplot(data=df, x='Vertices', y='AvgTime')
    # plt.show()
    algorithm = "Prims"
    graph = sns.relplot(data=self.df, x=self.headers[0], y=self.headers[2], hue=self.headers[1], kind="line")
    title = f"Graph of vertices vs average time taken for {self.probabilities} edge probability for {algorithm}"
    graph.set(xlabel='Vertices', ylabel='Avg Time (ms)', title=title)
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

  args = args.parse_args()

  plotter = Plotter()
  for i in range(len(args.path)):
    data = Data()
    probability = float(args.path[i].split("/")[1])
    with open(args.path[i]) as csv_file:
      csv_reader = csv.reader(csv_file, delimiter=',')
      next(csv_reader)
      for row in csv_reader:
        vertices, edges, st, et = row
        data.add_entry(Entry(int(vertices), int(edges), int(st), int(et)))

    data.calculate_average()
    plotter.add_data(probability, data.vertex_to_avgs)

  print(plotter.df)
  plotter.plot()