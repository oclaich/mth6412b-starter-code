import Base.show
include("connexe.jl")

function check_comp_connexe(comp_connexes::CompConnexe[]{T},node1::Node{T},node2::Node{T}) where {T}
    c1=0
    c2=0
    l1=0
    l2=0
    k=1
    while (k<=length(comp_connexes)-1)
        comp=comp_connexes[k]
        for l in 1:length(comp)
            element=comp[l]
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

function  kruskal(graph::Graph{T}) where {T}
    used_edges = Edge[]
    comp_connexes=CompConnexe[]
    for i in 1:nb_nodes(graph)
        comp=CompConnexe()
        element=ConnexeElement(graph.nodes[i])
        push!(comp,element)
        push!(comp_connexes,comp)
    end
    sort!(graph.edges)
    for j in 1:nb_edges(graph)
        edge=graph.edges[j]
        n1,n2=edge.node1,edge.node2
        c1,c2,l1,l2 = check_comp_connexe(comp_connexes,n1,n2)
        if c1!=c2
            push!(used_edges,edge)
            comp1=comp_connexes[c1]
            comp2=comp_connexes[c2]
            comp2[l2].parent=n1
            for k in 1:length(comp2)
                push!(comp1,pop!(comp2))
            end
        end
    end
    return (used_edges,comp_connexes)

end