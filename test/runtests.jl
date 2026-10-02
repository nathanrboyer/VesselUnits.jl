using VesselUnits
using Test

@testset "VesselUnits.jl" begin
    @test isdefined(@__MODULE__, :inch)
    @test (25.4mm |> inch) ≈ 1inch

    #Test simplification
    @test string(3lbf / 1inch^2) == "0.003 ksi"
    @test string(STEEL_DENSITY * 1inch^3) == "0.28 lb"
end
