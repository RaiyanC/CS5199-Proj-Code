import seaborn
import pandas
import matplotlib.pyplot as plt
import argparse

def read(path):
  csv = pandas.read_csv(path)
  print(csv)
  res = seaborn.scatterplot(x="Vertices", data=csv)
  plt.show()




if __name__ == "__main__":
  args = argparse.ArgumentParser()
  args.add_argument('-p', '--path', required=True, help="path of csv")
  args = args.parse_args()


  read(args.path)


