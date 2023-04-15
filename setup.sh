 #! /bin/sh

# copy files from digraphs here to gap installation

# add weights.gd to init.g
# sed -i '65iReadPackage("digraphs", "gap/weights.gd");' /home/mrc7/.gap/pkg/digraphs-1.6.1/init.g 

# copy init.g and read.g
cp ./Digraphs/init.g ./Digraphs/read.g ~/.gap/pkg/digraphs-1.6.2

# copy doc.g, display.gd, display.gi, digraph.gd, digraph.gi, weights.gd and weights.gi
cp ./Digraphs/gap/doc.g ./Digraphs/gap/display.gd ./Digraphs/gap/display.gi ./Digraphs/gap/weights.gd ./Digraphs/gap/weights.gi ./Digraphs/gap/digraph.gd ./Digraphs/gap/digraph.gi ~/.gap/pkg/digraphs-1.6.2/gap

# copy display weights.xml
cp ./Digraphs/doc/weights.xml ./Digraphs/doc/z-chap5.xml ~/.gap/pkg/digraphs-1.6.2/doc

# copy digraphs.tst weights.tst
cp ./Digraphs/tst/standard/digraph.tst ./Digraphs/tst/standard/weights.tst ~/.gap/pkg/digraphs-1.6.2/tst/standard

# copy testinstall.tst
cp ./Digraphs/tst/testinstall.tst ~/.gap/pkg/digraphs-1.6.2/tst


