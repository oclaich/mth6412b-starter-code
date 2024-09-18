include("graph.jl")
include("node.jl")
include("edge.jl")
include("read_stsp.jl")


function main(filename::String)
    header = read_header(filename)
    graph_nodes, graph_edges = read_stsp(filename)
    name =  header["NAME"]
    graph = Graph(name, graph_nodes, graph_edges)

    println("Graph ",name, " created.")
end
