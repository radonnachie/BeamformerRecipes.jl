module BeamformerRecipes

export BeamformerRecipe
export DimInfo
export TelInfo
export ObsInfo
export CalInfo
export BeamInfo
export DelayInfo
export to_hdf5

abstract type Info end

include("diminfo.jl")
include("telinfo.jl")
include("obsinfo.jl")
include("calinfo.jl")
include("beaminfo.jl")
include("delayinfo.jl")

Base.Base.@kwdef mutable struct BeamformerRecipe
    diminfo::Union{DimInfo, Nothing} = nothing
    telinfo::Union{TelInfo, Nothing} = nothing
    obsinfo::Union{ObsInfo, Nothing} = nothing
    calinfo::Union{CalInfo, Nothing} = nothing
    beaminfo::Union{BeamInfo, Nothing} = nothing
    delayinfo::Union{DelayInfo, Nothing} = nothing
end # mutable struct BeamformerRecipe

include("hdf5utils.jl")

function to_hdf5(h5::HDF5.File, recipe::BeamformerRecipe)
    for name in propertynames(recipe)
        to_hdf5(h5, getproperty(recipe, name))
    end
end

function to_hdf5(h5name::AbstractString, recipe::BeamformerRecipe)
    # "cw" = read-write, create file if not existing, preserve existing contents
    h5open(h5name, "cw") do h5
        to_hdf5(h5, recipe)
    end
end

end # module BeamformerRecipes
