# Build internal unit registry with default settings
module VesselUnitsRegistry
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
