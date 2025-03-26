using {PKGNAME}: {PKGNAME}
using Documenter: Documenter, DocMeta, deploydocs, makedocs

DocMeta.setdocmeta!(
  {PKGNAME}, :DocTestSetup, :(using {PKGNAME}); recursive=true
)

include("make_index.jl")

makedocs(;
  modules=[{PKGNAME}],
  authors="ITensor developers <support@itensor.org> and contributors",
  sitename="{PKGNAME}.jl",
  format=Documenter.HTML(;
    canonical="https://ITensor.github.io/{PKGNAME}.jl",
    edit_link="main",
    assets=["assets/favicon.ico", "assets/extras.css"],
  ),
  pages=["Home" => "index.md", "Reference" => "reference.md"],
)

deploydocs(;
  repo="github.com/ITensor/{PKGNAME}.jl", devbranch="main", push_preview=true
)
