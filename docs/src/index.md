```@meta
EditURL = "../../examples/README.jl"
```

# ITensorPkgSkeleton.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ITensor.github.io/ITensorPkgSkeleton.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ITensor.github.io/ITensorPkgSkeleton.jl/dev/)
[![Build Status](https://github.com/ITensor/ITensorPkgSkeleton.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ITensor/ITensorPkgSkeleton.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/ITensor/ITensorPkgSkeleton.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ITensor/ITensorPkgSkeleton.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

## Installation instructions

```julia
julia> using Pkg: Pkg

julia> Pkg.add("https://github.com/ITensor/ITensorPkgSkeleton.jl")
```

## Examples

````@example index
using ITensorPkgSkeleton: ITensorPkgSkeleton
````

This step might be required to circumvent issues with
the version of git installed by `Git.jl`.

````@example index
ITensorPkgSkeleton.use_system_git!()
````

If `path` isn't specified, it defaults to `~/.julia/dev`.

````@example index
ITensorPkgSkeleton.generate("NewPkg"; path=tempdir())
````

You can generate this README with:
```julia
using Literate: Literate
using ITensorPkgSkeleton: ITensorPkgSkeleton
Literate.markdown(
  joinpath(pkgdir(ITensorPkgSkeleton), "examples", "README.jl"),
  joinpath(pkgdir(ITensorPkgSkeleton), "docs", "src");
  flavor=Literate.DocumenterFlavor(),
  name="index",
)
```

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

