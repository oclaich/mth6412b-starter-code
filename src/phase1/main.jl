include("graph.jl")
include("node.jl")
include("edge.jl")
include("read_stsp.jl")


function main(filename::String)
    graph_nodes, graph_edges = read_stsp(filename)
    name = "My graph"
    graph = Graph(name, graph_nodes, graph_edges)
    return(graph)
end
