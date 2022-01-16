using HDF5

Base.Base.@kwdef mutable struct DelayInfo <: Info
    delays::Array{Float64,3} = Array{Float64,3}(undef, 0, 0, 0)
    rates::Array{Float64,3} = Array{Float64,3}(undef, 0, 0, 0)
    time_array::Vector{Float64} = Vector{Float64}(undef, 0)
end # mutable struct DelayInfo

#=
function to_hdf5(group::HDF5.Group, info::DelayInfo)
    invoke(to_hdf5, Tuple{HDF5.Group, Info}, group, info)
end
=#
