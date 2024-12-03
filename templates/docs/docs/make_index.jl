using Literate: Literate
using {PKGNAME}: {PKGNAME}

Literate.markdown(
  joinpath(pkgdir({PKGNAME}), "examples", "README.jl"),
  joinpath(pkgdir({PKGNAME}), "docs", "src");
  flavor=Literate.DocumenterFlavor(),
  name="index",
)
