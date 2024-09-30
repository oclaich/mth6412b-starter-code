import Base.show
include("graph.jl")
include("edge.jl")
include("node.jl")

abstract type AbstractConnexeElement{T} end

mutable struct ConnexeElement{T} <: AbstractConnexeElement{T}
    name::String
    parent::Node{T}
    child::Node{T}
end

abstract type AbstractCompConnexe{T} end

mutable struct CompConnexe{T} <: AbstractCompConnexe{T}
    comp::Vector{ConnexeElement}
end

"""Renvoie le nom de la composante connexe."""
name(comp::AbstractCompConnexe) = comp.name

"""Renvoie la taille de la composante connexxe"""
length(comp::AbstractCompConnexe) = length(comp)

"""Constructeur d'un élément de composante connexe"""
function ConnexeElement(node::Node{T}) where {T}
    name = node.name
    parent = node
    child = node
    ConnexeElement(name,parent,child)
end

"""Constructeur d'une composante connexe"""
function CompConnexe()
    comp=ConnexeElement[]
    CompConnexe(comp)
end

"""Changer le parent d'un élément de composante connexe"""
function change_parent(element::ConnexeElement{T},parent::Node{T}) where {T}
    element.parent=parent
end

