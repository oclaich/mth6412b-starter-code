import Base.show

abstract type AbstractConnexe{T} end

mutable struct Connexe <: AbstractConnexe{T}

    nodes::Vector{Node{T}}
    parents::Vector{Node{T}}
end

