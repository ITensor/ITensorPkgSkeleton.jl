using ITensorPkgSkeleton
using Documenter

DocMeta.setdocmeta!(
  ITensorPkgSkeleton, :DocTestSetup, :(using ITensorPkgSkeleton); recursive=true
)

makedocs(;
  modules=[ITensorPkgSkeleton],
  authors="ITensor developers <support@itensor.org> and contributors",
  sitename="ITensorPkgSkeleton.jl",
  format=Documenter.HTML(;
    canonical="https://ITensor.github.io/ITensorPkgSkeleton.jl",
    edit_link="main",
    assets=String[],
  ),
  pages=["Home" => "index.md"],
)

deploydocs(;
  repo="github.com/ITensor/ITensorPkgSkeleton.jl", devbranch="main", push_preview=true
)
