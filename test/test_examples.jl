@eval module $(gensym())
using ITensorPkgSkeleton: ITensorPkgSkeleton
using Suppressor: @suppress
using Test: @testset

@testset "ITensorPkgSkeleton.jl examples" begin
  examples_path = joinpath(pkgdir(ITensorPkgSkeleton), "examples")
  filenames = filter(readdir(examples_path; join=true)) do f
    endswith(".jl")(f)
  end
  @testset "Test $filename" for filename in filenames
    @suppress include(filename)
  end
end
end
