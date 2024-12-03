@eval module $(gensym())
using {PKGNAME}: {PKGNAME}
using Test: @testset

@testset "{PKGNAME}.jl" begin
  filenames = filter(joinpath(pkgdir({PKGNAME}), "examples")) do f
    endswith(".jl")(f)
  end
  @testset "Test $filename" for filename in filenames
    include(filename)
  end
end
end
