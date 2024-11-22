using Literate: Literate
using ITensorPkgSkeleton: ITensorPkgSkeleton

Literate.markdown(
  joinpath(pkgdir(ITensorPkgSkeleton), "examples", "README.jl"),
  joinpath(pkgdir(ITensorPkgSkeleton), "docs", "src");
  flavor=Literate.DocumenterFlavor(),
  name="index",
)
