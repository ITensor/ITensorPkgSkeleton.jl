@eval module $(gensym())
using {PKGNAME}: {PKGNAME}
using Test: @test, @testset

@testset "{PKGNAME}" begin
  # Tests go here.
end
end
