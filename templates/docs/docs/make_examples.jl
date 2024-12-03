using Literate: Literate
using {PKGNAME}: {PKGNAME}

Literate.markdown(
  joinpath(pkgdir({PKGNAME}), "examples", "example_docs.jl"),
  joinpath(pkgdir({PKGNAME}), "docs", "src");
  flavor=Literate.DocumenterFlavor(),
  name="examples",
)
