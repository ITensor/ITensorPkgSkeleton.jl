using {PKGNAME}: {PKGNAME}
using Documenter: Documenter

DocMeta.setdocmeta!({PKGNAME}, :DocTestSetup, :(using {PKGNAME}); recursive=true)

makedocs(;
  modules=[{PKGNAME}],
  authors="ITensor developers <support@itensor.org> and contributors",
  sitename="{PKGNAME}.jl",
  format=Documenter.HTML(;
    canonical="https://ITensor.github.io/{PKGNAME}.jl", edit_link="main", assets=String[]
  ),
  pages=["Home" => "index.md"],
)

deploydocs(; repo="github.com/ITensor/{PKGNAME}.jl", devbranch="main")
