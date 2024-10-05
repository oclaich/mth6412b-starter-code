import Base.show
include("connexe.jl")

"""Fonction pour check si deux noeuds sont dans la même composante connexe. Elle va renvoyer l'indice de la composante connexe dans laquelle se trouvent les noeuds au sein d'une liste de composantes connexes. """
function check_comp_connexe(comp_connexes::Vector{CompConnexe{T}},node1::Node{T},node2::Node{T}) where {T}
    c1=0
    c2=0
    l1=0
    l2=0
    k=1
    """ On parcourt les composantes connexes de la liste. """
    while (k<=length(comp_connexes)-1)
        comp=comp_connexes[k]
        """ On parcourt les éléments de la composante connexe concernée. """
        for l in 1:length(comp)
            element=comp[l]
            """ Si on repère un des noeuds qui nous intéresse, on met à jour les indices."""
            if element.node==node1
                c1=k
                l1=l
            elseif element.node==node2
                c2=k
                l2=l
            end
        end
        k=k+1
    end
    return c1,c2,l1,l2
end 

""" Algorithme de Kruskal, qui doit renvoyer uniquement l'ensemble des arêtes et le poids total de l'arbre de recouvrement minimal. """

function  kruskal(filename::String) where {T}
    graph=Graph(read_stsp(filename))
    """ Initialisation des listes et du poids total """
    used_edges = Edge[]
    comp_connexes=CompConnexe[]
    total_weight = 0
    """ On crée toutes les composantes connexes contenant uniquement un noeud, et on les ajoute à notre liste comp_connexes"""
    for i in 1:nb_nodes(graph)
        comp=CompConnexe()
        element=ConnexeElement(graph.nodes[i])
        push!(comp,element)
        push!(comp_connexes,comp)
    end
    """ Tri des arêtes."""
    sort!(graph.edges)
    """ Parcours des arêtes."""
    for j in 1:nb_edges(graph)
        edge=graph.edges[j]
        n1,n2=edge.node1,edge.node2
        c1,c2,l1,l2 = check_comp_connexe(comp_connexes,n1,n2)
        """ On regarde si les noeuds de l'arête concernée appartiennent à la même composante connexe."""
        """ Si ce n'est pas le cas, on va ajouter l'arête à la liste, et fusionner les deux composantes connexes. """
        """ Le noeud 1 devient le parent du noeud 2 dans la nouvelle composante connexe. """
        """ Le poids total est mis à jour. """
        if c1!=c2
            push!(used_edges,edge)
            total_weight += edge.weight
            comp_connexes[c2][l2].parent=n1
            """ Fusion des deux composantes connexes, en ajoutant à la première le pop de la deuxième, qui finit par devenir vide. """
            for k in 1:length(comp_connexes[c2])
                push!(comp_connexes[c1],pop!(comp_connexes[c2]))
            end
        end
    end
    return (used_edges,total_weight)

end