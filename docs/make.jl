using ITensorPkgSkeleton: ITensorPkgSkeleton
using Documenter: Documenter, DocMeta, deploydocs, makedocs

DocMeta.setdocmeta!(
    ITensorPkgSkeleton, :DocTestSetup, :(using ITensorPkgSkeleton); recursive = true
)

include("make_index.jl")

makedocs(;
    modules = [ITensorPkgSkeleton],
    authors = "ITensor developers <support@itensor.org> and contributors",
    sitename = "ITensorPkgSkeleton.jl",
    format = Documenter.HTML(;
        canonical = "https://itensor.github.io/ITensorPkgSkeleton.jl",
        edit_link = "main",
        assets = ["assets/favicon.ico", "assets/extras.css"],
    ),
    pages = ["Home" => "index.md", "Reference" => "reference.md"],
)

deploydocs(;
    repo = "github.com/ITensor/ITensorPkgSkeleton.jl", devbranch = "main", push_preview = true
)
