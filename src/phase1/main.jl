include("graph.jl")
include("node.jl")
include("edge.jl")
include("read_stsp.jl")


function main(filename::String)
    header = read_header(filename)
    graph_nodes = read_nodes(filename)
    graph_edges = read_edges(filename)
    name =  header["NAME"]
    graph = Graph(name, graph_nodes, graph_edges)

    show(graph)
end
