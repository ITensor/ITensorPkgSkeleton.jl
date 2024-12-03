@eval module $(gensym())
using ITensorPkgSkeleton: ITensorPkgSkeleton
using Suppressor: @suppress
using Test: @testset

@testset "ITensorPkgSkeleton.jl" begin
  filenames = filter(readdir(joinpath(pkgdir(ITensorPkgSkeleton), "examples"))) do f
    endswith(".jl")(f)
  end
  @testset "Test $filename" for filename in filenames
    @suppress include(filename)
  end
end
end
