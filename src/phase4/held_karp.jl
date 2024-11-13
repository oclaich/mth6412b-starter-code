export held_karp

include("../phase3/prim.jl")
include("../phase1/graph.jl")

function held_karp(graph::Graph{T,S},départ::Node{T}) where {T,S}

    n = length(graph.Nodes)
    k = 0
    pi = Dict(node => 0.0 for node in graph.Nodes)
    W = -Inf
    critere = 1e-3
    max_iters = 1000

    while k < max_iters
        graph_ajusté = Graph{T,S}()
        for edge in graph.Edges
            poids_ajusté = edge.data + pi[edge.node1] + pi[edge.node2]
            new_edge = Edge("new edge $k",poids_ajusté, edge.node1,edge.node2)
            add_edge!(graph_ajusté,new_edge)
        end

        subgraph=Graph{T,S}()
        for node in graph.Nodes
            if node != départ
                add_node!(subgraph,node)
            end
        end

        for edge in graph_ajusté.Edges
            if edge.node1 != départ && edge.node2 != départ
                add_edge!(subgraph,edge)
            end
        end
        
        mst = prim(subgraph,départ)[1]

        aretes_départ=filter(e -> e.node1 == départ || e.node2 == départ, graph_ajusté.Edges)
        add_edge!(mst, sort(aretes_départ, by=e -> e.data)[1])
        add_edge!(mst, sort(aretes_départ, by=e -> e.data)[2])

        L_Tpik = sum(edge.data for edge in mst.Edges)
        w_pik = L_Tpik - 2*sum(pi[node] for node in graph.Nodes)

        W = max(W, w_pik)

        d_k = Dict(node => 0 for node in graph.Nodes)

        for edge in mst.Edges
            d_k[edge.node1] +=1
            d_k[edge.node2] +=1
        end

        v_k = Dict(node => d_k[node]-2 for node in graph.Nodes)

        if all(value == 0 for value in values(v_k)) || sqrt(sum(value^2 for value in values(v_k))) < critere
            println("Convergence atteinte au bout de $k itérations")
            break
        end

        t_k = 1.0/(k+1)

        for node in graph.Nodes
            pi[node] += t_k*v_k[node]
        end
        k+=1
    end

    return W
end