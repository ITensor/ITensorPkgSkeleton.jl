using {PKGNAME}: {PKGNAME}
using Suppressor: @suppress
using Test: @testset
using SafeTestSets

@testset "{PKGNAME}.jl examples" begin
  examples_path = joinpath(pkgdir({PKGNAME}), "examples")
  filenames = filter(endswith(".jl"), readdir(examples_path; join=true))
  @safetestset "Test $filename" for filename in filenames
    @suppress include(filename)
  end
end
