using VesselUnits
using Test

@testset "Exported Names" begin
    # Test names are exported
    @test isdefined(@__MODULE__, :inch)  # constants
    @test isdefined(@__MODULE__, Symbol("@u_str"))  # macros
    @test isdefined(@__MODULE__, :ustrip)  # functions
end

@testset "Accurate Conversions" begin
    @test 25.4mm == 1inch
    @test 1lbf / 1inch^2 == 1psi
    @test 5lb / 2inch^3 == 2.5u"lb/inch^3"
    @test 0°F == 459.67u"Ra"
    @test 0°C ≈ 32°F
    @test round(MPa, 30_000psi, digits=4) == 206.8427MPa
end

@testset "Simplification Printing" begin
    @test string(3lbf / 1inch^2) == "0.003 ksi"
    @test string(STEEL_DENSITY * 1inch^3) == "0.28 lb"
    @test string(5lb / 2inch^3) == "2.5 lb/inch^3"
    @test string(300MPa) == "43.51132131906277 ksi"
    @test string(25.4mm) == "1.0 inch"
end

@testset "Volume Functions" begin
    @test cylinder_volume(2, 2) ≈ 2pi
    @test shell_volume(4, 2, 2) ≈ 6pi
    @test STEEL_DENSITY * cylinder_volume(1inch, 4inch) ≈ 0.28pi * lb
end


@testset "Error Functions" begin
    @test percent_error(10inch, 11inch, :first) == 10u"%"
    @test percent_error(10inch, 11inch, :second, 4) == -9.0909u"%"
    @test percent_error(10inch, 11inch) == 9.524u"%"

    @test percent_error(100ksi, 101ksi, :min) == 1u"%"
    @test percent_error(100ksi, 101ksi, :max) == 0.99u"%"
    @test percent_error(99ksi, 101ksi, :avg) == 2u"%"

    @test percent_error(10, 11, :first) == 10u"%"
    @test percent_error(10, 11, :second, 4) == -9.0909u"%"
    @test percent_error(10, 11) == 9.524u"%"
end
