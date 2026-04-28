# # ITensorPkgSkeleton.jl
#
# [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://itensor.github.io/ITensorPkgSkeleton.jl/stable/)
# [![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://itensor.github.io/ITensorPkgSkeleton.jl/dev/)
# [![Build Status](https://github.com/ITensor/ITensorPkgSkeleton.jl/actions/workflows/Tests.yml/badge.svg?branch=main)](https://github.com/ITensor/ITensorPkgSkeleton.jl/actions/workflows/Tests.yml?query=branch%3Amain)
# [![Coverage](https://codecov.io/gh/ITensor/ITensorPkgSkeleton.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ITensor/ITensorPkgSkeleton.jl)
# [![Code Style](https://img.shields.io/badge/code_style-ITensor-purple)](https://github.com/ITensor/ITensorFormatter.jl)
# [![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

# ## Support
#
# {CCQ_LOGO}
#
# ITensorPkgSkeleton.jl is supported by the Flatiron Institute, a division of the Simons Foundation.

# ## Installation instructions

# This package resides in the `ITensor/ITensorRegistry` local registry.
# In order to install, simply add that registry through your package manager.
# This step is only required once.
#=
```julia
julia> using Pkg: Pkg

julia> Pkg.Registry.add(url = "https://github.com/ITensor/ITensorRegistry")
```
=#
# or:
#=
```julia
julia> Pkg.Registry.add(url = "git@github.com:ITensor/ITensorRegistry.git")
```
=#
# if you want to use SSH credentials, which can make it so you don't have to enter your GitHub username and password when registering packages.

# Then, the package can be added as usual through the package manager:

#=
```julia
julia> Pkg.add("ITensorPkgSkeleton")
```
=#

# ## Examples

using ITensorPkgSkeleton: ITensorPkgSkeleton
ITensorPkgSkeleton.generate("MyPackage")
# Examples go here.

# ## Workflow templates
#
# The `template/.github/workflows/` directory is the source of truth for the GitHub Actions
# workflows shared across the ITensor ecosystem (`Tests.yml`, `FormatCheck.yml`, `TagBot.yml`,
# `CompatHelper.yml`, etc.). Most of them simply call into reusable workflows in
# [ITensorActions](https://github.com/ITensor/ITensorActions); see that repository's README
# for details on each.
#
# `TagBot.yml` carries a marker `env: REGISTRY_TAGBOT_ACTION: "JuliaRegistries/TagBot"`
# that looks unused but is required: the General registry's trigger workflow only treats
# TagBot as enabled when the literal string `JuliaRegistries/TagBot` appears in a file
# under `.github/workflows/`, and the reusable-workflow caller would otherwise not
# contain it. The same string would work as a YAML comment, but
# [ITensorFormatter](https://github.com/ITensor/ITensorFormatter.jl) (`itpkgfmt`) strips
# YAML comments via [YAML.jl](https://github.com/JuliaData/YAML.jl)'s writer (tracked
# upstream at [YAML.jl#245](https://github.com/JuliaData/YAML.jl/issues/245)), so the
# marker has to live in a structural element. See
# [ITensorActions's TagBot docs](https://github.com/ITensor/ITensorActions#why-the-env-marker)
# for the full explanation. Do not remove this `env:` block.
