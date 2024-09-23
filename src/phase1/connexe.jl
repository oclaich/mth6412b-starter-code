import Base.show

abstract type AbstractCompConnexe{T} end

mutable struct CompConnexe{T} <: AbstractCompConnexe{T}
    name::String
    parent::Node{T}
    child::Node{T}
end

"""Renvoie le nom de la composante connexe."""
name(comp::AbstractCompConnexe) = comp.name

""" Fonction pour changer le parent d'un noeud. """

function change_parent(comp::AbstractCompConnexe,node::Node{T})
    comp.parent = node
    
end


