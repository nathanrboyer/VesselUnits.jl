"""
    Package VesselUnits v$(pkgversion(VesselUnits))

Customized version of FlexUnits.jl for pressure vessel development.
"""
module VesselUnits

# Export names from this package
export inch, mm, lb, kg, lbf, °F, °C, psi, ksi, MPa, kPa, bar, atm
export STEEL_DENSITY

# Export names from FlexUnits
export simplify, set_preferred_unit

# Export names from InternalRegistry (Currently: @u_str, @ud_str, @q_str, @U_str, @D_str, uparse, qparse, register_unit)
export @u_str, @ud_str, @q_str, @U_str, @D_str, uparse, qparse, register_unit

# Load functions and module from FlexUnits.jl
using FlexUnits: FlexUnits, set_preferred_unit, display_simplified_units, simplify

# Build internal unit registry with default settings
module InternalRegistry
    using FlexUnits.RegistryTools

    # Define the unit registry as an empty dictionary
    const UNITS = PermanentDict{Symbol,Units{Dimensions{FixRat32},AffineTransform{Float64}}}()

    # Add default units and register new ones to UNITS dictionary
    registry_defaults!(UNITS)
    register_unit!(UNITS, "kip" => 1000 * UNITS[:lbf])
    register_unit!(UNITS, "ksi" => 1000 * UNITS[:psi])
    register_unit!(UNITS, "atm" => 101.325 * UNITS[:kPa])
    register_unit!(UNITS, "mph" => UNITS[:mi] / UNITS[:hr])

    # Set default preferred units
    const PREFERRED_UNITS = [UNITS[u] for u in [:F, :H, :T, :Ω, :V, :W, :J, :Pa, :N, :C, :L]]

    # Generate simplifiers and exports for defined units with included macros
    @generate_unit_simplifier(PREFERRED_UNITS)
    @generate_registry_exports(UNITS)
end

# Ensure the internal package is "used"
using .InternalRegistry

# Define selected units in namespace
const inch = u"inch" # Imperial Length
const mm = u"mm"     # Metric Length
const lb = u"lb"     # Imperial Mass
const kg = u"kg"     # Metric Mass
const lbf = u"lbf"   # Imperial Force
# N is too common    # Metric Force
const °F = u"°F"     # Imperial Temperature
const Ra = u"Ra"     # Alternate Imperial Temperature
const °C = u"°C"     # Metric Temperature
const psi = u"psi"   # Imperial Pressure
const ksi = u"ksi"   # Alternate Imperial Pressure
const MPa = u"MPa"   # Metric Pressure
const kPa = u"kPa"   # Alternate Metric Pressure
const bar = u"bar"   # Alternate Metric Pressure
const atm = u"atm"   # Alternate Metric Pressure

# Define selected constants in namespace
const STEEL_DENSITY = 0.28lb/inch^3;

# Set preferred units for simplification and turn on automatic simplification when package is loaded
function __init__()
    set_preferred_unit(inch)
    set_preferred_unit(lb)
    set_preferred_unit(lbf)
    set_preferred_unit(Ra)  # Using °F would cause errors for temperature differences. See https://github.com/Deduction42/FlexUnits.jl/issues/117#issuecomment-5901423556
    set_preferred_unit(ksi)
    set_preferred_unit(lb/inch^3)

    display_simplified_units(true)  # Always convert to simple preferred units
end

end  # module
