module ITensorPkgSkeleton

using Git: git
using LibGit2: LibGit2
using PkgSkeleton: PkgSkeleton
using Preferences: Preferences

# Configure `Git.jl`/`Git_jll.jl` to
# use the local installation of git.
using Preferences: Preferences
# Need to load to set the preferences.
using Git_jll: Git_jll
function use_system_git!()
  git_path = try
    readchomp(`which git`)
  catch
    nothing
  end
  if !isnothing(git_path)
    Preferences.set_preferences!("Git_jll", "git_path" => git_path)
  end
  return nothing
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

default_templates() = ["default"]

default_user() = "ITensor"

function default_user_replacements()
  return (
    GHUSER=default_user(), USERNAME="ITensor developers", USEREMAIL="support@itensor.org"
  )
end

#=
This processes inputs like:
```julia
ITensorPkgSkeleton.generate("NewPkg"; user_replacements=(DOWNSTREAMPKGS=("ITensors",)))
ITensorPkgSkeleton.generate("NewPkg"; user_replacements=(DOWNSTREAMPKGS=(repo="ITensors",)))
ITensorPkgSkeleton.generate("NewPkg"; user_replacements=(DOWNSTREAMPKGS=(user="ITensor", repo="ITensors",)))
```
=#
function format_downstream_pkgs(user_replacements)
  if !haskey(user_replacements, :DOWNSTREAMPKGS)
    return user_replacements
  end
  DOWNSTREAMPKGS = ""
  for user_repo in user_replacements.DOWNSTREAMPKGS
    user, repo = if user_repo isa AbstractString
      # Only the repo was passed as a standalone value.
      default_user(), user_repo
    else
      # The user and repo were passed in a NamedTuple,
      # or just the repo was passed in a NamedTuple.
      get(user_repo, :user, default_user()), user_repo.repo
    end
    DOWNSTREAMPKGS *= "          - {user: $(user), repo: $(repo).jl}\n"
  end
  DOWNSTREAMPKGS = chop(DOWNSTREAMPKGS)
  return merge(user_replacements, (; DOWNSTREAMPKGS))
end

function set_default_template_path(template)
  isabspath(template) && return template
  return joinpath(pkgdir(ITensorPkgSkeleton), "templates", template)
end

function is_git_repo(path)
  return try LibGit2.GitRepo(path)
    return true
  catch
    return false
  end
end

function generate(
  pkg_name; path=default_path(), templates=default_templates(), user_replacements=(;)
)
  # Set default values.
  user_replacements = merge(default_user_replacements(), user_replacements)
  # Fill in default path if missing.
  templates = set_default_template_path.(templates)
  # Process downstream package information.
  user_replacements = format_downstream_pkgs(user_replacements)
  pkg_path = joinpath(path, pkg_name)
  is_new_repo = !is_git_repo(path)
  branch_name = default_branch_name()
  user_replacements_dict = Dict(keys(user_replacements) .=> values(user_replacements))
  PkgSkeleton.generate(pkg_path; templates, user_replacements=user_replacements_dict)
  if is_new_repo
    # Change the default branch if this is a new repository.
    change_branch_name(pkg_path, branch_name)
  end
  return nothing
end

end
