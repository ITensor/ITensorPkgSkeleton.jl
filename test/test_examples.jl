@eval module $(gensym())
using ITensorPkgSkeleton: ITensorPkgSkeleton
using Test: @test, @testset

@testset "examples" begin
  include(joinpath(pkgdir(ITensorPkgSkeleton), "examples", "README.jl"))
end
end
