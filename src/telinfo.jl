using HDF5

Base.@kwdef mutable struct TelInfo <: Info
    antenna_positions::Array{Float64,2} = Array{Float64,2}(undef, 3, 0)
    antenna_position_frame::Union{String,Nothing} = nothing
    antenna_names::Vector{String} = Vector{String}(undef, 0)
    antenna_numbers::Vector{Int} = Vector{Int}(undef, 0)
    antenna_diameters::Vector{Float64} = Vector{Float64}(undef, 0)
    latitude::Float64 = NaN
    longitude::Float64 = NaN
    altitude::Float64 = NaN
    telescope_name::String = "Unknown"
end # mutable struct TelInfo

function to_hdf5(group::HDF5.Group, info::TelInfo)
    invoke(to_hdf5, Tuple{HDF5.Group, Info}, group, info;
           antenna_frame=(layout=HDF5.H5D_COMPACT,),
           latitude=(layout=HDF5.H5D_COMPACT,),
           longitude=(layout=HDF5.H5D_COMPACT,),
           altitude=(layout=HDF5.H5D_COMPACT,),
           telescope_name=(layout=HDF5.H5D_COMPACT,)
          )
end
