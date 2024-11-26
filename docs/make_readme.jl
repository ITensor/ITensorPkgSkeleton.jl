using Literate: Literate
using ITensorPkgSkeleton: ITensorPkgSkeleton

Literate.markdown(
  joinpath(pkgdir(ITensorPkgSkeleton), "examples", "README.jl"),
  joinpath(pkgdir(ITensorPkgSkeleton));
  flavor=Literate.CommonMarkFlavor(),
  name="README",
)
