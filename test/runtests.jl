using ITensorPkgSkeleton
using Test
using Aqua

@testset "ITensorPkgSkeleton.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(ITensorPkgSkeleton)
    end
    # Write your tests here.
end
