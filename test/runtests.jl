using VesselUnits
using Test

@testset "VesselUnits.jl" begin
    # Test names are exported
    @test isdefined(@__MODULE__, :inch)  # constants
    @test isdefined(@__MODULE__, Symbol("@u_str"))  # macros
    @test isdefined(@__MODULE__, :ustrip)  # functions

    # Test conversions are accurate
    @test 25.4mm == 1inch
    @test 1lbf / 1inch^2 == 1psi
    @test 5lb / 2inch^3 == 2.5u"lb/inch^3"
    @test 0°F == 459.67u"Ra"
    @test 0°C ≈ 32°F
    @test round(ustrip(MPa, 30_000psi), digits=4) === 206.8427

    #Test simplifications are as expected
    @test string(3lbf / 1inch^2) == "0.003 ksi"
    @test string(STEEL_DENSITY * 1inch^3) == "0.28 lb"
    @test string(5lb / 2inch^3) == "2.5 lb/inch^3"
    @test string(300MPa) == "43.51132131906277 ksi"
    @test string(25.4mm) == "1.0 inch"
end
