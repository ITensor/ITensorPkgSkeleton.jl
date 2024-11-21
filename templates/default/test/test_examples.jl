@eval module $(gensym())
using {PKGNAME}: {PKGNAME}
using Test: @test, @testset

@testset "examples" begin
  include(joinpath(pkgdir({PKGNAME}), "examples", "README.jl"))
end
end
