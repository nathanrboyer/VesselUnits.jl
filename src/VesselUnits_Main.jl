"""
    Package VesselUnits v$(pkgversion(VesselUnits))

Customized version of FlexUnits.jl for pressure vessel development.
"""
module VesselUnits

# Export names from this package
export inch, mm, lb, kg, lbf, °F, °C, psi, MPa, kPa, bar, atm
export STEEL_DENSITY
export simplify, set_preferred_unit
export @D_str, @U_str, @q_str, @u_str, @ud_str, qparse, register_unit, uparse

# Build custom unit registry
include("UnitRegistry.jl")
using .UnitRegistry
using FlexUnits: display_simplified_units

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
const MPa = u"MPa"   # Metric Pressure
const kPa = u"kPa"   # Alternate Metric Pressure
const bar = u"bar"   # Alternate Metric Pressure
const atm = u"atm"   # Alternate Metric Pressure

# Define important constants in namespace
const STEEL_DENSITY = 0.28lb/inch^3;

# Always convert to simple preferred units
display_simplified_units(true)

end  # module
