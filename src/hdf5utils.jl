using HDF5

"""
    get_group(h5::Union{HDF5.File,HDF5.Group}, name) -> HDF5.Group

Returns an `HDF5.Group` object for `name` in `h5`.  If `name` does not exist in
`h5`, a group named `name` will be created.  If `name` exists in `h5`, but it is
not as group, an error will be thrown.
"""
function get_group(h5::Union{HDF5.File,HDF5.Group}, name)::HDF5.Group
    haskey(h5, name) ? h5[name] : create_group(h5, name)
end

"""
    write_dataset(h5::Union{HDF5.File,HDF5.Group}, name, data; opts=())

Write `data` to dataset `name` in `h5`.  If `name` does not already exist it
will be created with any kwargs that are given in `opts`
"""
function write_dataset(h5::Union{HDF5.File,HDF5.Group}, name::AbstractString, data;
                     opts=()
                    )
    created = false
    if !haskey(h5, name)
        create_dataset(h5, name, data; opts...)
        created = true
    end
    write(h5[name], data)

    created
end

"""
    isstoreworthy(x)::Bool

Determines whether `x` is worthy of being strored in a BeamformerRecipe file.
"""
function isstoreworthy(x)
    @warn "unsupprted type $(typeof(x)) is not storeworthy" _module=nothing _file=nothing
    false
end
isstoreworthy(x::Nothing) = false
isstoreworthy(x::AbstractString) = length(x) > 0
isstoreworthy(x::AbstractFloat) = !isnan(x)
# The only integer scalar fields in BeamformerRecipe files are positive integers
isstoreworthy(x::Integer) = x > 0
isstoreworthy(x::AbstractArray) = sizeof(x) > 0

"""
    groupname(info::Info) -> String

Name of HDF5 group that holds datasets for `typeof(info)` structs.
"""
function groupname(info::Info)
    datasetpath = "$(lowercase(string(typeof(prop))))"
    if datasetpath[1:18] == "beamformerrecipes."
        datasetpath = datasetpath[19:end]
    end
    datasetpath = "/$(datasetpath)"
end

"""
    to_hdf5(group::HDF5.Group, info::Info; allopts...)

Store the data in `info` in the HDF5 datasets within `group`.  When splatted,
`allopts` should be pairs mapping symbols of `info` field names to NamedTuples
of HDF5 dataset creation options.
"""
function to_hdf5(group::HDF5.Group, info::Info; allopts...)
    if HDF5.name(group) != groupname(info)
        @warn "adding $typeof(info) to group $groupname(info)"
    end
    for name in propertynames(info)
        data = getproperty(info, name)
        isstoreworthy(data) || continue
        write_dataset(group, string(name), data; opts=get(allopts, name, ()))
    end
end

function to_hdf5(h5::HDF5.File, info::Info)
    group = get_group(h5, groupname(info))
    to_hdf5(group, info)
end

function to_hdf5(::HDF5.File, ::Nothing)
end
