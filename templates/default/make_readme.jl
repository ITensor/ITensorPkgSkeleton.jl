using Literate: Literate
using {PKGNAME}: {PKGNAME}

Literate.markdown(
  joinpath(pkgdir({PKGNAME}), "examples", "README.jl"),
  joinpath(pkgdir({PKGNAME}));
  flavor=Literate.CommonMarkFlavor(),
  name="README",
)
