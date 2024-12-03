@eval module $(gensym())
using {PKGNAME}: {PKGNAME}
using Suppressor: @suppress
using Test: @testset

@testset "{PKGNAME}.jl examples" begin
  examples_path = joinpath(pkgdir({PKGNAME}), "examples")
  filenames = filter(readdir(examples_path; join=true)) do f
    endswith(".jl")(f)
  end
  @testset "Test $filename" for filename in filenames
    @suppress include(filename)
  end
end
end
