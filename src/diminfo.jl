using HDF5

Base.@kwdef mutable struct DimInfo <: Info
    nants::Int = 0
    npol::Int = 0
    nchan::Int = 0
    nbeams::Int = 0
    ntimes::Int = 0
end # mutable struct DimInfo

function to_hdf5(group::HDF5.Group, info::DimInfo)
    invoke(to_hdf5, Tuple{HDF5.Group, Info}, group, info;
           nants=(layout=HDF5.H5D_COMPACT,),
           npol=(layout=HDF5.H5D_COMPACT,),
           nchan=(layout=HDF5.H5D_COMPACT,),
           nbeams=(layout=HDF5.H5D_COMPACT,),
           ntimes=(layout=HDF5.H5D_COMPACT,)
          )
end
