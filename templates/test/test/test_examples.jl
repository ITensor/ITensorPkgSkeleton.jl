@eval module $(gensym())
using {PKGNAME}: {PKGNAME}
using Suppressor: @suppress
using Test: @testset

@testset "{PKGNAME}.jl" begin
  filenames = filter(readdir(joinpath(pkgdir({PKGNAME}), "examples"))) do f
    endswith(".jl")(f)
  end
  @testset "Test $filename" for filename in filenames
    @suppress include(filename)
  end
end
end
