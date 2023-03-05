import seaborn
import pandas
import matplotlib.pyplot as plt
import argparse
from collections import defaultdict
import csv


class Data():
  def __init__(self, entry) -> None:
    self.vertex_to_entry_dict = defaultdict(list) # vertex: [entry1, entry3, entry3]
    self.vertex_to_avgs = {} # vertex: avg_time

  def add_entry(self, entry):
    self.vertex_to_entry_dict[entry.vertex].append(entry)
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


class Entry():
  def __init__(self, vertices, edges, st, et) -> None:
    self.vertices = vertices
    self.edges = edges
    self.st = st
    self.et = et

  

def read(path):
  with open(path) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
        else:
            
    print(f'Processed {line_count} lines.')



if __name__ == "__main__":
  args = argparse.ArgumentParser()
  args.add_argument('-p', '--path', required=True, help="path of csv")
  args = args.parse_args()


  read(args.path)


