# {PKGNAME}.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://itensor.github.io/{PKGNAME}.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://itensor.github.io/{PKGNAME}.jl/dev/)
[![Build Status](https://github.com/ITensor/{PKGNAME}.jl/actions/workflows/Tests.yml/badge.svg?branch=main)](https://github.com/ITensor/{PKGNAME}.jl/actions/workflows/Tests.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/ITensor/{PKGNAME}.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ITensor/{PKGNAME}.jl)
[![code style: runic](https://img.shields.io/badge/code_style-%E1%9A%B1%E1%9A%A2%E1%9A%BE%E1%9B%81%E1%9A%B2-black)](https://github.com/fredrikekre/Runic.jl)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

## Support

<picture>
  <source media="(prefers-color-scheme: dark)" width="20%" srcset="docs/src/assets/CCQ-dark.png">
  <img alt="Flatiron Center for Computational Quantum Physics logo." width="20%" src="docs/src/assets/CCQ.png">
</picture>


{PKGNAME}.jl is supported by the Flatiron Institute, a division of the Simons Foundation.

## Installation instructions

This package resides in the `ITensor/ITensorRegistry` local registry.
In order to install, simply add that registry through your package manager.
This step is only required once.
```julia
julia> using Pkg: Pkg

julia> Pkg.Registry.add(url = "https://github.com/ITensor/ITensorRegistry")
```
or:
```julia
julia> Pkg.Registry.add(url = "git@github.com:ITensor/ITensorRegistry.git")
```
if you want to use SSH credentials, which can make it so you don't have to enter your Github ursername and password when registering packages.

Then, the package can be added as usual through the package manager:

```julia
julia> Pkg.add("{PKGNAME}")
```

## Examples

````julia
using {PKGNAME}: {PKGNAME}
````

Examples go here.

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

