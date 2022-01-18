using HDF5

Base.Base.@kwdef mutable struct BeamInfo <: Info
    ras::AbstractVector{Float64} = Vector{Float64}(undef, 0)
    decs::AbstractVector{Float64} = Vector{Float64}(undef, 0)
    src_names::AbstractVector{String} = Vector{String}(undef, 0)
end # mutable struct BeamInfo

#=
function to_hdf5(group::HDF5.Group, info::BeamInfo)
    invoke(to_hdf5, Tuple{HDF5.Group, Info}, group, info)
end
=#
