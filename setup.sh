 #! /bin/sh

# copy files from digraphs here to gap installation

# add weights.gd to init.g
# sed -i '65iReadPackage("digraphs", "gap/weights.gd");' /home/mrc7/.gap/pkg/digraphs-1.6.1/init.g 

# copy init.g and read.g
cp ./Digraphs/init.g ./Digraphs/read.g ~/.gap/pkg/digraphs-1.6.1

# copy doc.g, weights.gd and weights.gi
cp ./Digraphs/gap/doc.g ./Digraphs/gap/weights.gd ./Digraphs/gap/weights.gi ~/.gap/pkg/digraphs-1.6.1/gap

# copy weights.xml
cp ./Digraphs/doc/weights.xml ./Digraphs/doc/z-chap5.xml ~/.gap/pkg/digraphs-1.6.1/doc

