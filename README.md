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

````julia
using ITensorPkgSkeleton: ITensorPkgSkeleton
````

This step might be required to circumvent issues with
the version of git installed by `Git.jl`.

````julia
ITensorPkgSkeleton.use_system_git!()
````

If `path` isn't specified, it defaults to `~/.julia/dev`.

````julia
ITensorPkgSkeleton.generate("NewPkg"; path=mktempdir())
1 + 1
````

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

