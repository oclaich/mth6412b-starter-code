using Test

include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase1/read_stsp.jl")

""" Exemple de graphe du cours"""

""" Création des noeuds """

node1=Node("A",1)
node2=Node("B",1)
node3=Node("C",1)
node4=Node("D",1)
node5=Node("E",1)
node6=Node("F",1)
node7=Node("G",1)
node8=Node("H",1)
node9=Node("I",1)

nodes=Node[node1,node2,node3,node4,node5,node6,node7,node8,node9]

""" Création des arêtes """

edge1=Edge(node1,node2,4)
edge2=Edge(node2,node3,8)
edge3=Edge(node3,node4,7)
edge4=Edge(node4,node5,9)
edge5=Edge(node5,node6,10)
edge6=Edge(node6,node7,2)
edge7=Edge(node7,node8,1)
edge8=Edge(node8,node9,7)
edge9=Edge(node8,node1,8)
edge10=Edge(node8,node2,11)
edge11=Edge(node9,node3,2)
edge12=Edge(node9,node7,6)
edge13=Edge(node3,node6,4)
edge14=Edge(node4,node6,14)

edges = Edge[edge1,edge2,edge3,edge4,edge5,edge6,edge7,edge8,edge9,edge10,edge11,edge12,edge13,edge14]

""" Création du graphe """

graph=Graph("Test graph",nodes,edges)

@testset "Tests sur les structures de graphe." begin
    @test node1.name == "A"
    @test edge2.weight == 8
    @test edge5.node1 == node5
    @test edge12.node2 == node7

    @test (graph.edges[1]).node1 == node1
    @test nb_nodes(graph) == 9
    @test nb_edges(graph) == 14
end

""" Tests à faire sur l'algorithme de Kruskal :
    - Créer des composantes connexes (2) simples et les mettre dans une liste
    - Appliquer la fonction check_comp_connexe à cette liste avec deux noeuds, et regarder si on a bien ce qu'on veut en sortie
    - Faire un test sur l'algorithme de Kruskal appliqué au graph créé précedemment, qui doit renvoyer 37 comme poids."""
@testset "Tests sur l'algorithme de Kruskal." begin
    element1=ConnexeElement("element1",node1,node1)
    element2=ConnexeElement("element2",node2,node2)
    element3=ConnexeElement("element2",node2,node3)
    comp1=CompConnexe()
    comp2=CompConnexe()
    push!(comp1,element1)
    push!(comp2,element2)
    push!(comp2,element3)
    comp_connexes=CompConnexe[]
    push!(comp_connexes,comp1)
    push!(comp_connexes,comp2)
    c1,c2,l1,l2=check_comp_connexe(comp_connexes,node1,node3)
    @test c1 == 1
    @test c2 == 2
    @test l1 == 1
    @test l2 == 2

    used_edges, weight = kruskal(graph)
    @test weight == 37

end