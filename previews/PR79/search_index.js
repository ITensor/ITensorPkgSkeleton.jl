var documenterSearchIndex = {"docs":
[{"location":"reference/#Reference","page":"Reference","title":"Reference","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"Modules = [ITensorPkgSkeleton]","category":"page"},{"location":"reference/#ITensorPkgSkeleton.all_templates-Tuple{}","page":"Reference","title":"ITensorPkgSkeleton.all_templates","text":"all_templates()\n\n\nAll available templates when constructing a package. Includes the following templates: [\"benchmark\", \"docs\", \"downstreampkgs\", \"examples\", \"formatter\", \"github\", \"gitignore\", \"license\", \"precommit\", \"project\", \"src\", \"test\"]\n\n\n\n\n\n","category":"method"},{"location":"reference/#ITensorPkgSkeleton.default_templates-Tuple{}","page":"Reference","title":"ITensorPkgSkeleton.default_templates","text":"default_templates()\n\n\nDefault templates when constructing a package. Includes the following templates: [\"benchmark\", \"docs\", \"downstreampkgs\", \"examples\", \"formatter\", \"github\", \"gitignore\", \"license\", \"precommit\", \"project\", \"src\", \"test\"]\n\n\n\n\n\n","category":"method"},{"location":"reference/#ITensorPkgSkeleton.generate-Tuple{Any}","page":"Reference","title":"ITensorPkgSkeleton.generate","text":"generate(\n    pkgname;\n    path,\n    templates,\n    ignore_templates,\n    user_replacements...\n)\n\n\nwarning: Warning\nThis function might overwrite existing code if you specify a path to a package that already exists, use with caution! See PkgSkeleton.jl for more details. If you are updating an existing package, make sure you save everything you want to keep (for example, commit all of your changes if it is a git repository).\n\nGenerate a package template for a package, by default in the ITensor organization, or update an existing package. This is a wrapper around PkgSkeleton.generate but with extra functionality, custom templates used in the ITensor organization, and defaults biased towards creating a package in the ITensor organization.\n\nExamples\n\njulia> using ITensorPkgSkeleton: ITensorPkgSkeleton;\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir());\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir());\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), templates=ITensorPkgSkeleton.default_templates());\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), templates=[\"github\"]);\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), templates=[\"src\", \"github\"]);\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), ignore_templates=[\"src\", \"github\"]);\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), ghuser=\"MyOrg\");\n\njulia> ITensorPkgSkeleton.generate(\"NewPkg\"; path=mktempdir(), downstreampkgs=[\"ITensors\", \"ITensorMPS\"]);\n\nArguments\n\npkgname::AbstractString: Name of the package (without the .jl extension). Replaces {PKGNAME} in the template.\n\nKeywords\n\npath::AbstractString: Path where the package will be generated. Defaults to the development directory, i.e. /home/runner/.julia/dev.\ntemplates: A list of templates to use. Select a subset of ITensorPkgSkeleton.all_templates() = [\"benchmark\", \"docs\", \"downstreampkgs\", \"examples\", \"formatter\", \"github\", \"gitignore\", \"license\", \"precommit\", \"project\", \"src\", \"test\"]. Defaults to ITensorPkgSkeleton.default_templates() = [\"benchmark\", \"docs\", \"downstreampkgs\", \"examples\", \"formatter\", \"github\", \"gitignore\", \"license\", \"precommit\", \"project\", \"src\", \"test\"].\nignore_templates: A list of templates to ignore. This is the same as setting templates=setdiff(templates, ignore_templates).\ndownstreampkgs: Specify the downstream packages that depend on this package. Setting this will create a workflow where the downstream tests will be run alongside the tests for this package in Github Actions to ensure that changes to your package don't break the specified downstream packages. Defaults to an empty list.\nuuid: Replaces {UUID} in the template. Defaults to the existing UUID in the Project.toml if the path points to an existing package, otherwise generates one randomly with UUIDs.uuid4().\nyear: Replaces {YEAR} in the template. Year the package/repository was created. Defaults to the current year.\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"EditURL = \"../../examples/README.jl\"","category":"page"},{"location":"#ITensorPkgSkeleton.jl","page":"Home","title":"ITensorPkgSkeleton.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Stable) (Image: Dev) (Image: Build Status) (Image: Coverage) (Image: Code Style: Blue) (Image: Aqua)","category":"page"},{"location":"#Support","page":"Home","title":"Support","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"<img class=\"display-light-only\" src=\"assets/CCQ.png\" width=\"20%\" alt=\"Flatiron Center for Computational Quantum Physics logo.\"/>\n<img class=\"display-dark-only\" src=\"assets/CCQ-dark.png\" width=\"20%\" alt=\"Flatiron Center for Computational Quantum Physics logo.\"/>","category":"page"},{"location":"","page":"Home","title":"Home","text":"ITensorPkgSkeleton.jl is supported by the Flatiron Institute, a division of the Simons Foundation.","category":"page"},{"location":"#Installation-instructions","page":"Home","title":"Installation instructions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This package resides in the ITensor/ITensorRegistry local registry. In order to install, simply add that registry through your package manager. This step is only required once.","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using Pkg: Pkg\n\njulia> Pkg.Registry.add(url=\"https://github.com/ITensor/ITensorRegistry\")","category":"page"},{"location":"","page":"Home","title":"Home","text":"or:","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> Pkg.Registry.add(url=\"git@github.com:ITensor/ITensorRegistry.git\")","category":"page"},{"location":"","page":"Home","title":"Home","text":"if you want to use SSH credentials, which can make it so you don't have to enter your Github ursername and password when registering packages.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Then, the package can be added as usual through the package manager:","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> Pkg.add(\"ITensorPkgSkeleton\")","category":"page"},{"location":"#Examples","page":"Home","title":"Examples","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using ITensorPkgSkeleton: ITensorPkgSkeleton\nITensorPkgSkeleton.generate(\"MyPackage\")","category":"page"},{"location":"","page":"Home","title":"Home","text":"Examples go here.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"This page was generated using Literate.jl.","category":"page"}]
}
