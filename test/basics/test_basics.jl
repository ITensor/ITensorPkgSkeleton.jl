using ITensorPkgSkeleton: ITensorPkgSkeleton
using Test: @test, @testset

@testset "ITensorPkgSkeleton" begin
  pkgdirs = [
    ".github",
    ".github/ISSUE_TEMPLATE",
    ".github/workflows",
    "benchmark",
    "docs",
    "examples",
    "src",
    "test",
  ]
  @testset "generate" begin
    path = mktempdir()
    ITensorPkgSkeleton.generate("NewPkg"; path)
    @test isdir(joinpath(path, "NewPkg"))
    @test isfile(joinpath(path, "NewPkg", "Project.toml"))
    for dir in pkgdirs
      @test isdir(joinpath(path, "NewPkg", dir))
    end
    @test !isfile(joinpath(path, "NewPkg", ".github", "workflows", "Downstream.yml"))
  end
  @testset "generate with downstream tests" begin
    for templates in (ITensorPkgSkeleton.default_templates(), [])
      for downstreampkgs in (["DownstreamPkg"], [(user="ITensor", repo="DownstreamPkg")])
        path = mktempdir()
        ITensorPkgSkeleton.generate("NewPkg"; path, templates, downstreampkgs)
        @test isdir(joinpath(path, "NewPkg"))
        @test isdir(joinpath(path, "NewPkg", ".github", "workflows"))
        @test isfile(joinpath(path, "NewPkg", ".github", "workflows", "Downstream.yml"))
        @test open(
          joinpath(path, "NewPkg", ".github", "workflows", "Downstream.yml"), "r"
        ) do io
          return contains(read(io, String), "- \"ITensor/DownstreamPkg.jl\"")
        end
        for dir in setdiff(pkgdirs, [".github", ".github/workflows"])
          @test isdir(joinpath(path, "NewPkg", dir)) == !isempty(templates)
        end
      end
    end
  end
end
