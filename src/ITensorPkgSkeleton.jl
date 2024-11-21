module ITensorPkgSkeleton

using Git: git
using Git_jll: Git_jll
using PkgSkeleton: PkgSkeleton
using Preferences: Preferences

# Configure `Git.jl`/`Git_jll.jl` to
# use the local installation of git.
using Preferences: Preferences
function use_system_git!()
  git_path = try
    readchomp(`which git`)
  catch
    nothing
  end
  if !isnothing(git_path)
    Preferences.set_preferences!("Git_jll", "git_path" => git_path)
  end
end

# Get the default branch name.
# This might be an alternative but it doesn't work for some reason:
# ```julia
# using LibGit2: LibGit2
# LibGit2.get(AbstractString, LibGit2.GitConfig(), "init.defaultBranch")
# ```
function default_branch_name()
  return try
    readchomp(`$(git()) config --get init.defaultBranch`)
  catch
    "main"
  end
end

function change_branch_name(path, branch_name)
  original_dir = pwd()
  cd(path)
  original_branch_name = readchomp(`$(git()) branch --show-current`)
  run(`$(git()) branch -m $original_branch_name $branch_name`)
  cd(original_dir)
  return nothing
end

function default_path()
  # TODO: Use something like `joinpath(first(DEPOT_PATH), "dev", pkg_name)`
  # to make it more general.
  return joinpath(homedir(), ".julia", "dev")
end

function generate(pkg_name; path=default_path())
  pkg_path = joinpath(path, pkg_name)
  # TODO: Turn this into a keyword argument.
  template_dir = joinpath(pkgdir(ITensorPkgSkeleton), "templates", "default")

  branch_name = default_branch_name()
  ## TODO: Allow customization of these, currently
  ## they are hardcoded in the template.
  user_replacements = Dict([
    "GHUSER" => "ITensor",
    "USERNAME" => "ITensor developers",
    "USEREMAIL" => "support@itensor.org",
  ])
  PkgSkeleton.generate(pkg_path; templates=[template_dir], user_replacements)

  # Change the default branch.
  change_branch_name(pkg_path, branch_name)
  return nothing
end

end
