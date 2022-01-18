using HDF5

Base.@kwdef mutable struct CalInfo <: Info
    refant::Union{AbstractString,Nothing} = nothing
    cal_K::AbstractArray{Float32,2} = Array{Float32,2}(undef, 0, 0)
    cal_B::AbstractArray{ComplexF32,3} = Array{ComplexF32,3}(undef, 0, 0, 0)
    cal_G::AbstractArray{ComplexF32,2} = Array{ComplexF32,2}(undef, 0, 0)
    cal_all::AbstractArray{ComplexF32,3} = Array{ComplexF32,3}(undef, 0, 0, 0)
end # mutable struct CalInfo

function to_hdf5(group::HDF5.Group, info::CalInfo; chunks=size(info.cal_B))
    invoke(to_hdf5, Tuple{HDF5.Group, Info}, group, info;
           cal_K=(chunks=chunks[1:2],),
           cal_B=(chunks=chunks,),
           cal_G=(chunks=chunks[1:2],),
           cal_all=(chunks=chunks,)
          )
end
