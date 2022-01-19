using HDF5

Base.Base.@kwdef mutable struct DelayInfo <: Info
    delays::AbstractArray{Float64,3} = Array{Float64,3}(undef, 0, 0, 0)
    rates::AbstractArray{Float64,3} = Array{Float64,3}(undef, 0, 0, 0)
    time_array::AbstractVector{Float64} = Vector{Float64}(undef, 0)
    jds::AbstractVector{Float64} = Vector{Float64}(undef, 0)
    dut1::Union{Float64,Nothing} = nothing
end # mutable struct DelayInfo

#=
function to_hdf5(group::HDF5.Group, info::DelayInfo)
    invoke(to_hdf5, Tuple{HDF5.Group, Info}, group, info)
end
=#
