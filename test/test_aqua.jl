@eval module $(gensym())
using Aqua: Aqua
using ITensorPkgSkeleton: ITensorPkgSkeleton
using Test: @testset

@testset "Code quality (Aqua.jl)" begin
  Aqua.test_all(ITensorPkgSkeleton)
end
end
