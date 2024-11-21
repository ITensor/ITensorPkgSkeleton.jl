@eval module $(gensym())
using ITensorPkgSkeleton: ITensorPkgSkeleton
using Test: @test, @testset

@testset "ITensorPkgSkeleton" begin
  path = tempdir()
  @test isnothing(ITensorPkgSkeleton.generate("NewPkg"; path))
  @test isdir(joinpath(path, "NewPkg"))
  @test isdir(joinpath(path, "NewPkg", ".github"))
  @test isdir(joinpath(path, "NewPkg", "benchmark"))
  @test isdir(joinpath(path, "NewPkg", "docs"))
  @test isdir(joinpath(path, "NewPkg", "src"))
  @test isdir(joinpath(path, "NewPkg", "test"))
end
end
