
include("../phase1/main.jl")
include("kruskal.jl")




# Création du graphe à partir bayg29.tsp

G=create_graph("C:/Users/octav/OneDrive - ISAE-SUPAERO/Bureau/MTH6412B/instances/instances/stsp/gr21.tsp")

#Test sur le fichier bayg29.tsp
A,B=kruskal(G)

println("the minimun spanning tree are composed of:")
for a in A
    show(a)
end
println("the total cost is ",B)
