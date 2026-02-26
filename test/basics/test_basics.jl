using ITensorPkgSkeleton: ITensorPkgSkeleton
using Test: @test, @testset

@testset "ITensorPkgSkeleton" begin
    pkgdirs = Dict(
        ".github" => "github",
        ".github/ISSUE_TEMPLATE" => "github",
        ".github/workflows" => "github",
        "benchmark" => "benchmark",
        "docs" => "docs",
        "examples" => "examples",
        "src" => "src",
        "test" => "test",
    )
    @testset "generate" begin
        path = mktempdir()
        ITensorPkgSkeleton.generate("NewPkg"; path)
        @test isdir(joinpath(path, "NewPkg"))
        @test isfile(joinpath(path, "NewPkg", "Project.toml"))
        for (dir, _) in pkgdirs
            @test isdir(joinpath(path, "NewPkg", dir))
        end
        @test isfile(joinpath(path, "NewPkg", ".github", "workflows", "IntegrationTest.yml"))
        @test open(
            joinpath(path, "NewPkg", ".github", "workflows", "IntegrationTest.yml"),
            "r"
        ) do io
            return contains(read(io, String), "- \"__none__\"")
        end
    end
    @testset "generate with downstream tests" begin
        for templates in (ITensorPkgSkeleton.default_templates(), [], ["github"])
            for downstreampkgs in (["DownstreamPkg"],)
                path = mktempdir()
                ITensorPkgSkeleton.generate("NewPkg"; path, templates, downstreampkgs)
                enabled_templates = Set{String}(String.(templates))
                has_github_template = templates == ITensorPkgSkeleton.default_templates() ||
                    "github" in templates
                @test isdir(joinpath(path, "NewPkg"))
                if has_github_template
                    @test isdir(joinpath(path, "NewPkg", ".github", "workflows"))
                    @test isfile(
                        joinpath(path, "NewPkg", ".github", "workflows", "IntegrationTest.yml")
                    )
                    @test open(
                        joinpath(path, "NewPkg", ".github", "workflows", "IntegrationTest.yml"),
                        "r"
                    ) do io
                        return contains(read(io, String), "- \"DownstreamPkg\"")
                    end
                else
                    @test !isdir(joinpath(path, "NewPkg", ".github"))
                end
                for (dir, template_name) in pkgdirs
                    expected = templates == ITensorPkgSkeleton.default_templates() ||
                        template_name in enabled_templates
                    @test isdir(joinpath(path, "NewPkg", dir)) == expected
                end
            end
        end
    end
end
