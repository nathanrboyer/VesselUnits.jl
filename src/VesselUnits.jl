"""
    Package VesselUnits v$(pkgversion(VesselUnits))

Customized version of FlexUnits.jl for pressure vessel development.
"""
module VesselUnits

# Export names from this package
export inch, mm, lb, kg, lbf, °F, °C, psi, ksi, MPa, kPa, bar, atm  # Units
export STEEL_DENSITY                                                # Constants
export cylinder_volume, shell_volume, percent_error                 # Functions

# Load and reexport names from FlexUnits.jl and the internal custom unit registry
using Reexport
@reexport using FlexUnits
include("registry.jl")
@reexport using .VesselUnitsRegistry

# Define selected units
const inch = u"in"   # Imperial Length (`in` is already a Julia function)
const mm = u"mm"     # Metric Length
const lb = u"lb"     # Imperial Mass
const kg = u"kg"     # Metric Mass
const lbf = u"lbf"   # Imperial Force
const Newton = u"N"  # Metric Force (`N` is too common a variable name to take here)
const °F = u"°F"     # Imperial Temperature
const Ra = u"Ra"     # Alternate Imperial Temperature
const °C = u"°C"     # Metric Temperature
const psi = u"psi"   # Imperial Pressure
const ksi = u"ksi"   # Alternate Imperial Pressure
const MPa = u"MPa"   # Metric Pressure
const kPa = u"kPa"   # Alternate Metric Pressure
const bar = u"bar"   # Alternate Metric Pressure
const atm = u"atm"   # Alternate Metric Pressure

# Define selected constants
const STEEL_DENSITY = 0.28lb/inch^3

# Define selected functions
include("functions.jl")

# Set preferred units for simplification and turn on automatic simplification when package is loaded
function __init__()
    set_preferred_unit(inch)
    set_preferred_unit(lb)
    set_preferred_unit(lbf)
    set_preferred_unit(Ra)  # Using °F would cause errors for temperature differences. See https://github.com/Deduction42/FlexUnits.jl/issues/117#issuecomment-5901423556
    set_preferred_unit(ksi)
    set_preferred_unit(u"inch^3")
    set_preferred_unit(u"lb/inch^3")

    display_simplified_units(true)
end

end  # module
