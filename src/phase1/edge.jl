import Base.show
include("node.jl")

abstract type AbstractEdge{T} end

mutable struct Edge{T} <: AbstractEdge{T}
    node1::Node{T}
    node2::Node{T}
    weight::Float64
end

show_node1(edge::AbstractEdge) = edge.node1

show_node2(edge::AbstractEdge) = edge.node2

show_weight(edge::AbstractEdge) = edge.weight

function show(edge::AbstractEdge)
    println("Edge between ", show_node1(edge), " and ", show_node2(edge), ", weight = ", show_weight(edge))
end
