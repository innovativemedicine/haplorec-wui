Dependency Graph
****************

The dependency graph is displayed for each job and on the create page.

How the graph layout is created
===============================

Calculating the level of each node (Column Level)
+++++++++++++++++++++++++++++++++++++++++++++++++

The level of a node is the length of the shortest path from that node to a node with no dependents.

The path length is equal to the number of arrows/ line connectors.

This implies nodes with no dependents have level zero.

For example in the graph bellow the variant node has these paths to level zero nodes

    - (Variant -> Haplotypes -> Novel Haplotypes) length 2
    - (Variant -> Haplotypes -> Genotypes -> Genotype Drug Recommendation) length 3
    - (Variant -> Haplotypes -> Genotypes -> Phenotypes -> Phenotype Drug Recommendation) length 4

Therefore the node variant has level 2.

The code for calculating the column level can be found here in the levels function:

.. toctree::
    Dependency

Calculating the Row Level of each node
++++++++++++++++++++++++++++++++++++++

The following is used to calculate the row levels of each column's nodes:

1. The nodes that do not depend on any other nodes in the column are found and assigned unique groups by alphabetical order

2. For these nodes, numberNodes is applied to them which assigns vertical numbers to all the dependants using Depth first search

.. figure:: pictures/dfs.png
   :align: center

3. numberNodes also assigns the starting node's group level to all the dependant nodes

4. The nodes are then sorted into groups and then sorted by vertical number 
5. The groups are joined into one list
6. The list is then converted to a map, which maps Dependency to rowLevel

The code for calculating the row levels can be found here in the rowLvls function:

.. toctree::
    Dependency


Positioning of the Nodes
++++++++++++++++++++++++

The nodes of the graph are displayed in an m-by-n grid.

.. figure::  pictures/graphGrid.png
   :align:   center
 

n **=** number of columns **=** var numlevels **=** (maximum node level) + 1 

m **=** number of rows **=** the maximum number of nodes in a level

column number of node = (n - 1) - node's level 

(column width) :sub:`i` **=** maximum node width in column i

(row height) :sub:`j` **=** maximum node height in row j

horizontal space between columns =

.. figure::  pictures/eq1.png
   :align:   center

vertical space between rows =

.. figure::  pictures/eq2.png
   :align:   center

Issues you may encounter
++++++++++++++++++++++++

Although the nodes are placed by their column level and row level, an issue arises when two nodes depend on one starting node in the same column.

For example if both Genotypes and Phenotypes are dependant of Haplotypes the Graph will apper like so. The line connecting Haplotypes and Phenotypes goes 
straight through Genotypes instead of going around it. jsPlumb Library may have curved lines that will go around the nodes.

.. figure:: pictures/messedGraph.png
    :align: center

Another issue is if a node's column level is less than its dependant's, meaning its column number is greater than its dependant's column number.


For example the dependencies A,B,C, and D with dependants[A]=[B,D], dependants[B]=[C], dependants[C]=[D], dependants[D]=[] 
will have columnLevels [D:0,A:1,C:1,B:2].
This means B will appear on the left of A, even though B depends on A.

What the dependency graph does with input files
===============================================
...

