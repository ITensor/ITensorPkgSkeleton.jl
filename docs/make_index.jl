using Literate: Literate
using ITensorPkgSkeleton: ITensorPkgSkeleton

function ccq_logo(content)
  # Prepending an extra `..` to the path is required to circumvent:
  # https://github.com/JuliaDocs/Documenter.jl/issues/921

  # <img src="../assets/CCQ.png" width="10%" alt="Flatiron Center for Computational Quantum Physics logo.">

  include_ccq_logo = """
    ```@raw html
    <img src="../assets/CCQ.png">
    ```
    """
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
