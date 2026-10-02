module UnitRegistry

export set_preferred_unit, display_simplified_units, simplify

# Load dependencies
using FlexUnits.RegistryTools
using FlexUnits: set_preferred_unit, display_simplified_units, simplify

# Define the unit registry as an empty dictionary
const UNITS = PermanentDict{Symbol,Units{Dimensions{FixRat32},AffineTransform{Float64}}}()

# Add default units and register new ones to UNITS dictionary
registry_defaults!(UNITS)
register_unit!(UNITS, "kip" => 1000 * UNITS[:lbf])
register_unit!(UNITS, "ksi" => 1000 * UNITS[:psi])
register_unit!(UNITS, "atm" => 101.325 * UNITS[:kPa])
register_unit!(UNITS, "mph" => UNITS[:mi] / UNITS[:hr])

# Define default preferred units
const PREFERRED_UNITS = [UNITS[u] for u in [:F, :H, :T, :Ω, :V, :W, :J, :Pa, :N, :C, :L]]

# Generate simplifiers and exports for defined units with included macros
@generate_unit_simplifier(PREFERRED_UNITS)
@generate_registry_exports(UNITS)

# Set preferred units for simplification
set_preferred_unit(u"inch")
set_preferred_unit(u"lb")
set_preferred_unit(u"lbf")
set_preferred_unit(u"Ra")  # Too dangerous to leave on °F. Temperature differences will be wrong.
set_preferred_unit(u"psi")
set_preferred_unit(u"lb/inch^3")
set_preferred_unit(u"ft lb")

# Always convert to simple preferred units
display_simplified_units(true)

end  # module
