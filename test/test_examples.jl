@eval module $(gensym())
using ITensorPkgSkeleton: ITensorPkgSkeleton
using Test: @testset

@testset "ITensorPkgSkeleton.jl" begin
  filenames = filter(joinpath(pkgdir(ITensorPkgSkeleton), "examples")) do f
    endswith(".jl")(f)
  end
  @testset "Test $filename" for filename in filenames
    include(filename)
  end
end
end
