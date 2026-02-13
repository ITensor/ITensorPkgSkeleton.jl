using Aqua: Aqua
using {PKGNAME}: {PKGNAME}
using Test: @testset

@testset "Code quality (Aqua.jl)" begin
    Aqua.test_all({PKGNAME})
end
