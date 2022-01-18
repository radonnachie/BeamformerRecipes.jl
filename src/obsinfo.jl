using HDF5

Base.@kwdef mutable struct ObsInfo <: Info
    obsid::String = "unknown:unknown:YYmmddTHHMMSSZ"
    freq_array::AbstractVector{Float64} = Vector{Float64}(undef, 0)
    phase_center_ra::Float64 = NaN
    phase_center_dec::Float64 = NaN
    instrument_name::String = "Unknown"
end # mutable struct ObsInfo

function to_hdf5(group::HDF5.Group, info::ObsInfo)
    invoke(to_hdf5, Tuple{HDF5.Group, Info}, group, info;
           obsid=(layout=HDF5.H5D_COMPACT,),
           phase_center_ra=(layout=HDF5.H5D_COMPACT,),
           phase_center_dec=(layout=HDF5.H5D_COMPACT,),
           instrument_name=(layout=HDF5.H5D_COMPACT,)
          )
end
