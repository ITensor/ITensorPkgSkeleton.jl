var documenterSearchIndex = {"docs":
[{"location":"reference/#Reference","page":"Reference","title":"Reference","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"ITensorPkgSkeleton.generate\nITensorPkgSkeleton.default_templates\nITensorPkgSkeleton.all_templates","category":"page"},{"location":"reference/#ITensorPkgSkeleton.generate","page":"Reference","title":"ITensorPkgSkeleton.generate","text":"generate(\n    pkgname;\n    path,\n    templates,\n    ignore_templates,\n    user_replacements...\n)\n\n\nwarning: Warning\nThis function might overwrite existing code if you specify a path to a package that already exists, use with caution! See PkgSkeleton.jl for more details. If you are updating an existing package, make sure you save everything you want to keep (for example, commit all of your changes if it is a git repository).\n\nGenerate a package template for a package, by default in the ITensor organization, or update an existing package. This is a wrapper around PkgSkeleton.generate but with extra functionality, custom templates used in the ITensor organization, and defaults biased towards creating a package in the ITensor organization.\n\nExamples\n\njulia> using ITensorPkgSkeleton: ITensorPkgSkeleton;\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir());\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir());\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), templates=ITensorPkgSkeleton.default_templates());\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), templates=[\"github\"]);\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), templates=[\"src\", \"github\"]);\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), ignore_templates=[\"src\", \"github\"]);\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), ghuser=\"MyOrg\");\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), downstreampkgs=[\"ITensors\", \"ITensorMPS\"]);\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), downstreampkgs=[(user=\"ITensor\", repo=\"ITensors\")]);\n\nArguments\n\npkgname::AbstractString: Name of the package (without the .jl extension). Replaces {PKGNAME} in the template.\n\nKeywords\n\npath::AbstractString: Path where the package will be generated. Defaults to the development directory, i.e. /home/runner/.julia/dev.\ntemplates: A list of templates to use. Select a subset of ITensorPkgSkeleton.all_templates() = [\"benchmark\", \"docs\", \"downstreampkgs\", \"examples\", \"formatter\", \"github\", \"gitignore\", \"license\", \"precommit\", \"project\", \"readme\", \"src\", \"test\"]. Defaults to ITensorPkgSkeleton.default_templates() = [\"benchmark\", \"docs\", \"downstreampkgs\", \"examples\", \"formatter\", \"github\", \"gitignore\", \"license\", \"precommit\", \"project\", \"readme\", \"src\", \"test\"].\nignore_templates: A list of templates to ignore. This is the same as setting templates=setdiff(templates, ignore_templates).\ndownstreampkgs: Specify the downstream packages that depend on this package. Setting this will create a workflow where the downstream tests will be run alongside the tests for this package in Github Actions to ensure that changes to your package don't break the specified downstream packages. Specify it as a list of packages, for example [\"DownstreamPkg1\", \"DownstreamPkg2\"], which assumes the packages are in the ITensor organization. Alternatively, specify the organization with [(user=\"Org1\", repo=\"DownstreamPkg1\"), (user=\"Org2\", repo=\"DownstreamPkg2\")]; . Defaults to an empty list.\nuuid: Replaces {UUID} in the template. Defaults to the existing UUID in the Project.toml if the path points to an existing package, otherwise generates one randomly with UUIDs.uuid4().\nyear: Replaces {YEAR} in the template. Year the package/repository was created. Defaults to the current year.\n\n\n\n\n\n","category":"function"},{"location":"reference/#ITensorPkgSkeleton.default_templates","page":"Reference","title":"ITensorPkgSkeleton.default_templates","text":"default_templates()\n\n\nDefault templates when constructing a package. Includes the following templates: [\"benchmark\", \"docs\", \"downstreampkgs\", \"examples\", \"formatter\", \"github\", \"gitignore\", \"license\", \"precommit\", \"project\", \"readme\", \"src\", \"test\"]\n\n\n\n\n\n","category":"function"},{"location":"reference/#ITensorPkgSkeleton.all_templates","page":"Reference","title":"ITensorPkgSkeleton.all_templates","text":"all_templates()\n\n\nAll available templates when constructing a package. Includes the following templates: [\"benchmark\", \"docs\", \"downstreampkgs\", \"examples\", \"formatter\", \"github\", \"gitignore\", \"license\", \"precommit\", \"project\", \"readme\", \"src\", \"test\"]\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"EditURL = \"../../examples/README.jl\"","category":"page"},{"location":"#ITensorPkgSkeleton.jl","page":"Home","title":"ITensorPkgSkeleton.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Stable) (Image: Dev) (Image: Build Status) (Image: Coverage) (Image: Code Style: Blue) (Image: Aqua)","category":"page"},{"location":"#Installation-instructions","page":"Home","title":"Installation instructions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"julia> using Pkg: Pkg\n\njulia> Pkg.add(\"https://github.com/ITensor/ITensorPkgSkeleton.jl\")","category":"page"},{"location":"#Examples","page":"Home","title":"Examples","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using ITensorPkgSkeleton: ITensorPkgSkeleton","category":"page"},{"location":"","page":"Home","title":"Home","text":"This step might be required to circumvent issues with the version of git installed by Git.jl.","category":"page"},{"location":"","page":"Home","title":"Home","text":"ITensorPkgSkeleton.use_system_git!()","category":"page"},{"location":"","page":"Home","title":"Home","text":"If path isn't specified, it defaults to ~/.julia/dev.","category":"page"},{"location":"","page":"Home","title":"Home","text":"ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir())","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"This page was generated using Literate.jl.","category":"page"}]
}
