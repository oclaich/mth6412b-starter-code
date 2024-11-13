
include("../phase1/main.jl")
include("prim.jl")



# Création du graphe à partir bayg29.tsp

G=create_graph("C:\\Users\\octav\\OneDrive - ISAE-SUPAERO\\Bureau\\MTH6412B\\instances\\instances\\stsp\\gr48.tsp")

#Test sur le fichier bayg29.tsp

#Kruskal avec heuristique
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")


show(A)

println("the total cost is ",B)


#prim

C,D=prim(G)

println("the minimun spanning tree are composed of:")

show(C)

println("the total cost is ",D)