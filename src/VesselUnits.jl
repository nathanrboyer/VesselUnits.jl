"""
    Package VesselUnits v$(pkgversion(VesselUnits))

Customized version of FlexUnits.jl for pressure vessel development.
"""
module VesselUnits

# Export names from this package
export inch, mm, lb, kg, lbf, °F, °C, psi, ksi, kPa, MPa, bar, atm
export STEEL_DENSITY

# Load dependencies
using Reexport
@reexport using Unitful
Unitful.register(VesselUnits)

# Define new units
@unit kip "kip" Kip 1000*u"lbf" false
@unit ksi "ksi" KSI 1*u"kip"/(1*u"inch^2") false
@unit mph "mph" MPH 1*u"mi"/(1*u"hr") false

# Define selected units in namespace
const inch = u"inch" # Imperial Length
const mm = u"mm"     # Metric Length
const lb = u"lb"     # Imperial Mass
const kg = u"kg"     # Metric Mass
const lbf = u"lbf"   # Imperial Force
# N is too common    # Metric Force
const °F = u"°F"     # Imperial Temperature
const °C = u"°C"     # Metric Temperature
const psi = u"psi"   # Imperial Pressure
const ksi = u"ksi"   # Alternate Imperial Pressure
const MPa = u"MPa"   # Metric Pressure
const kPa = u"kPa"   # Alternate Metric Pressure
const bar = u"bar"   # Alternate Metric Pressure
const atm = u"atm"   # Alternate Metric Pressure

# Define important constants in namespace
const STEEL_DENSITY = 0.28lb/inch^3

# Set preferred units for simplification
Unitful.preferunits(u"inch")
Unitful.preferunits(u"lb")
Unitful.preferunits(u"Ra")

# Derived Dimensions
@derived_dimension Area Unitful.𝐋^2
@derived_dimension Volume Unitful.𝐋^3
@derived_dimension Density Unitful.𝐋*Unitful.𝐌*Unitful.𝐓^-2*Unitful.𝐋^-3
@derived_dimension Force Unitful.𝐋*Unitful.𝐌*Unitful.𝐓^-2
@derived_dimension Moment Unitful.𝐋^2*Unitful.𝐌*Unitful.𝐓^-2
@derived_dimension Stress Unitful.𝐋*Unitful.𝐌*Unitful.𝐓^-2/Unitful.𝐋^2

# Promotion Rules
Unitful.promote_unit(::S, ::T) where {S<:VesselUnits.AreaUnits, T<:VesselUnits.AreaUnits} = u"inch^2"
Unitful.promote_unit(::S, ::T) where {S<:VesselUnits.VolumeUnits, T<:VesselUnits.VolumeUnits} = u"inch^3"
Unitful.promote_unit(::S, ::T) where {S<:VesselUnits.DensityUnits, T<:VesselUnits.DensityUnits} = u"lb/inch^3"
Unitful.promote_unit(::S, ::T) where {S<:VesselUnits.ForceUnits, T<:VesselUnits.ForceUnits} = u"lbf"
Unitful.promote_unit(::S, ::T) where {S<:VesselUnits.MomentUnits, T<:VesselUnits.MomentUnits} = u"lbf*ft"
Unitful.promote_unit(::S, ::T) where {S<:VesselUnits.StressUnits, T<:VesselUnits.StressUnits} = u"ksi"
const localpromotion = copy(Unitful.promotion)
function __init__()
    Unitful.register(VesselUnits)
    merge!(Unitful.promotion, localpromotion)
end

end  # module
