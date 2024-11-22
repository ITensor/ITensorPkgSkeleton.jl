```@meta
EditURL = "../../examples/README.jl"
```

# {PKGNAME}.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ITensor.github.io/{PKGNAME}.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ITensor.github.io/{PKGNAME}.jl/dev/)
[![Build Status](https://github.com/ITensor/{PKGNAME}.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ITensor/{PKGNAME}.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/ITensor/{PKGNAME}.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ITensor/{PKGNAME}.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

## Installation instructions

```@repl
using Pkg: Pkg
Pkg.add("https://github.com/ITensor/{PKGNAME}.jl")
```

## Examples

````@example index
using {PKGNAME}: {PKGNAME}
````

Show examples of using {PKGNAME}.jl

You can generate this README with:
```@example
using Literate: Literate
using {PKGNAME}: {PKGNAME}
Literate.markdown(
  joinpath(pkgdir({PKGNAME}), "examples", "README.jl"),
  joinpath(pkgdir({PKGNAME}), "docs", "src");
  flavor=Literate.DocumenterFlavor(),
  name="index",
)
```

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

