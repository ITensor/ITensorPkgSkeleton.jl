@eval module $(gensym())
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
    for dir in pkgdirs
      @test isdir(joinpath(path, "NewPkg", dir))
    end
  end
  @testset "generate with downstream tests" begin
    for templates in (["downstream"], ["default", "downstream"])
      for DOWNSTREAMPKGS in (
        ("DownstreamPkg",), (repo="DownstreamPkg",), (user="ITensor", repo="DownstreamPkg")
      )
        path = mktempdir()
        templates = ["default", "downstream"]
        ITensorPkgSkeleton.generate(
          "NewPkg"; path, templates, user_replacements=(; DOWNSTREAMPKGS)
        )
        @test isdir(joinpath(path, "NewPkg"))
        @test isdir(joinpath(path, "NewPkg", ".github", "workflows"))
        @test isfile(joinpath(path, "NewPkg", ".github", "workflows", "Downstream.yml"))
        @test open(
          joinpath(path, "NewPkg", ".github", "workflows", "Downstream.yml"), "r"
        ) do io
          return contains(read(io, String), "- {user: ITensor, repo: DownstreamPkg.jl}")
        end
        for dir in pkgdirs
          @test isdir(joinpath(path, "NewPkg", dir)) == ("default" in templates)
        end
      end
    end
  end
end
end
