import seaborn
import pandas
import matplotlib.pyplot as plt
import argparse
from collections import defaultdict
import csv


class Data():
  def __init__(self) -> None:
    self.vertex_to_entry_dict = defaultdict(list) # vertex: [entry1, entry3, entry3]
    self.vertex_to_avgs = {} # vertex: avg_time

  def add_entry(self, entry):
    self.vertex_to_entry_dict[entry.vertices].append(entry)
    # self.update_average(entry)

  def calculate_average(self): 
    for k, v in self.vertex_to_entry_dict.items():
      size = len(v)
      tot = 0
      for entry in v:
        diff = entry.et - entry.st
        tot += diff
      
      avg = tot / size
      self.vertex_to_avgs[k] = avg

  def plot(self):
    x, y = zip(*sorted(data.vertex_to_avgs.items()))
    plt.plot(x, y)
    plt.show()


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

  data = Data()
  with open(args.path[0]) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    next(csv_reader)
    for row in csv_reader:
      vertices, edges, st, et = row
      e = Entry(int(vertices), int(edges), int(st), int(et))
      data.add_entry(e)

  data.calculate_average()
  data.plot()


