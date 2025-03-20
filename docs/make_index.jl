using Literate: Literate
using ITensorPkgSkeleton: ITensorPkgSkeleton

function ccq_logo(content)
  include_ccq_logo = "![Flatiron Center for Computational Quantum Physics logo.](assets/CCQ.png)"
  content = replace(content, "{CCQ_LOGO}" => include_ccq_logo)
  return content
end

Literate.markdown(
  joinpath(pkgdir(ITensorPkgSkeleton), "examples", "README.jl"),
  joinpath(pkgdir(ITensorPkgSkeleton), "docs", "src");
  flavor=Literate.DocumenterFlavor(),
  name="index",
  postprocess=ccq_logo,
)
