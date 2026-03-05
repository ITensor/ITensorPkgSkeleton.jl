module ITensorPkgSkeleton

# Declare `ITensorPkgSkeleton.generate` as public in a
# backwards-compatible way.
# See: https://discourse.julialang.org/t/is-compat-jl-worth-it-for-the-public-keyword/119041
if VERSION >= v"1.11.0-DEV.469"
    eval(
        Meta.parse(
            "public all_templates, default_templates, generate, runtests"
        )
    )
end

using DocStringExtensions: SIGNATURES
using Git: git
using Git_jll: Git_jll
using LibGit2: LibGit2
using PkgSkeleton: PkgSkeleton
using Preferences: Preferences
using Suppressor: @suppress
using Test: @testset

# Configure `Git.jl`/`Git_jll.jl` to
# use the local installation of git.
# Need to Preferences.jl to set the preferences.
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
    cd(path) do
        original_branch_name = readchomp(`$(git()) branch --show-current`)
        run(`$(git()) branch -m $original_branch_name $branch_name`)
        return nothing
    end
    return nothing
end

function set_remote_url(path, pkgname, ghuser)
    url = "git@github.com:$ghuser/$pkgname.jl.git"
    cd(joinpath(path, pkgname)) do
        try
            @suppress begin
                run(`$(git()) ls-remote -h "$url" HEAD $("&>") /dev/null`)
                run(`$(git()) add origin $url`)
            end
        catch
        end
        return nothing
    end
    return nothing
end

# https://pkgdocs.julialang.org/v1/api/#Pkg.develop
function default_path()
    return joinpath(DEPOT_PATH[1], "dev")
end

default_ghuser() = "ITensor"
default_username() = "ITensor developers"
default_useremail() = "support@itensor.org"

function default_user_replacements()
    return (
        ghuser = default_ghuser(), username = default_username(),
        useremail = default_useremail(),
    )
end

#=
This processes inputs like:
```julia
ITensorPkgSkeleton.generate("NewPkg"; downstreampkgs=["ITensors"])
```
=#
function format_downstreampkgs(user_replacements)
    pkgs =
        haskey(user_replacements, :downstreampkgs) ? user_replacements.downstreampkgs : []
    if isempty(pkgs)
        downstreampkgs = "          - \"__none__\""
    else
        downstreampkgs = join(["          - \"$(pkg)\"" for pkg in pkgs], "\n")
    end
    return merge(user_replacements, (; downstreampkgs))
end

function _istestfile(path::AbstractString)
    fn = basename(path)
    return endswith(fn, ".jl") && startswith(basename(fn), "test_") &&
        !contains(fn, "setup")
end

function _isexamplefile(path::AbstractString)
    fn = basename(path)
    return endswith(fn, ".jl") && !endswith(fn, "_notest.jl") && !contains(fn, "setup")
end

function _group(; args = ARGS, env = ENV)
    pat = r"(?:--group=)(\w+)"
    arg_id = findfirst(contains(pat), args)
    return uppercase(
        if isnothing(arg_id)
            arg = get(env, "GROUP", "ALL")
            arg == "" ? "ALL" : arg
        else
            only(match(pat, args[arg_id]).captures)
        end
    )
end

function _run_isolated_testfile(
        path::AbstractString;
        label::AbstractString = basename(path)
    )
    mod = Module(gensym(:SafeTestset))
    Core.eval(mod, :(using Test))
    # Module(...) does not define one-argument include(path), so nested includes in
    # test files would fail without adding this method.
    Core.eval(mod, :(include(path) = Base.include($mod, path)))
    return Core.eval(
        mod,
        quote
            @testset $label begin
                include($path)
            end
        end
    )
end

"""
    runtests(; testdir::AbstractString, args = ARGS, env = ENV)

Discover and run test files named `test_*.jl` under `testdir` as isolated testsets.

Subdirectories of `testdir` are treated as test groups and can be filtered with
`--group=...` or `ENV["GROUP"]`.

Files with `"setup"` in the name are skipped.
Files ending with `_notest.jl` in the `examples/` directory are also skipped.
"""
function runtests(; testdir::AbstractString, args = ARGS, env = ENV)
    group = _group(; args, env)
    @time begin
        for testgroup in filter(isdir, readdir(testdir; join = true))
            if group == "ALL" || group == uppercase(basename(testgroup))
                for filename in filter(_istestfile, readdir(testgroup; join = true))
                    _run_isolated_testfile(filename; label = basename(filename))
                end
            end
        end

        for file in filter(_istestfile, readdir(testdir; join = true))
            (basename(file) == "runtests.jl") && continue
            _run_isolated_testfile(file; label = basename(file))
        end

        examplepath = joinpath(testdir, "..", "examples")
        if isdir(examplepath)
            for (root, _, files) in walkdir(examplepath)
                contains(chopprefix(root, testdir), "setup") && continue
                for file in filter(_isexamplefile, files)
                    filename = joinpath(root, file)
                    redirect_stdout(devnull) do
                        return _run_isolated_testfile(filename; label = file)
                    end
                end
            end
        end
    end
    return nothing
end

const TEMPLATE_EXT = ".template"
const TEMPLATE_ROOT = joinpath(pkgdir(ITensorPkgSkeleton), "template")
const TEMPLATE_PATHS = Dict(
    "benchmark" => ["benchmark"],
    "docs" => ["docs", "README.md"],
    "examples" => ["examples"],
    "github" => [".github"],
    "gitignore" => [".gitignore"],
    "license" => ["LICENSE"],
    "precommit" => [".pre-commit-config.yaml"],
    "project" => ["Project.toml"],
    "src" => ["src"],
    "test" => ["test"]
)
function strip_template_ext(path)
    return endswith(path, TEMPLATE_EXT) ? path[1:(end - length(TEMPLATE_EXT))] : path
end

function copy_template_path!(src, template_dir, dest_dir)
    if isdir(src)
        for (root, dirs, files) in walkdir(src)
            for dir in dirs
                mkpath(joinpath(dest_dir, relpath(joinpath(root, dir), template_dir)))
            end
            for file in files
                src_file = joinpath(root, file)
                rel = strip_template_ext(relpath(src_file, template_dir))
                dest_file = joinpath(dest_dir, rel)
                mkpath(dirname(dest_file))
                cp(src_file, dest_file)
            end
        end
    elseif isfile(src)
        rel = strip_template_ext(relpath(src, template_dir))
        dest_file = joinpath(dest_dir, rel)
        mkpath(dirname(dest_file))
        cp(src, dest_file)
    end
    return nothing
end

function prepare_template(template_dir)
    tmp_dir = mktempdir()
    copy_template_path!(template_dir, template_dir, tmp_dir)
    return tmp_dir
end

function prepare_default_templates(templates)
    tmp_dir = mktempdir()
    for template in templates
        paths = get(TEMPLATE_PATHS, template, nothing)
        isnothing(paths) &&
            throw(
            ArgumentError(
                "Unknown template \"$template\". Options: $(collect(keys(TEMPLATE_PATHS)))"
            )
        )
        for path in paths
            src = joinpath(TEMPLATE_ROOT, "$path$TEMPLATE_EXT")
            if !isfile(src)
                src = joinpath(TEMPLATE_ROOT, path)
            end
            copy_template_path!(src, TEMPLATE_ROOT, tmp_dir)
        end
    end
    return tmp_dir
end

function prepare_templates(templates)
    templates_abs = filter(isabspath, templates)
    templates_default = setdiff(templates, templates_abs)
    prepared = String[]
    if !isempty(templates_default)
        push!(prepared, prepare_default_templates(String.(templates_default)))
    end
    append!(prepared, prepare_template.(templates_abs))
    return prepared
end

function is_git_repo(path)
    return try
        LibGit2.GitRepo(path)
        return true
    catch
        return false
    end
end

"""
$(SIGNATURES)

All available templates when constructing a package. Includes the following templates: `$(all_templates())`
"""
all_templates() = collect(keys(TEMPLATE_PATHS))

"""
$(SIGNATURES)

Default templates when constructing a package. Includes the following templates: `$(default_templates())`
"""
default_templates() = all_templates()

function to_pkgskeleton(user_replacements)
    return Dict(uppercase.(string.(keys(user_replacements))) .=> values(user_replacements))
end

function pkg_registration_message(; pkgname, path)
    return """
    The package "$pkgname" has been generated at "$path".

    To register the package in the [ITensor registry](https://github.com/ITensor/ITensorRegistry), first add
    the registry if you haven't already with:
    ```julia
    julia> using Pkg: Pkg

    julia> Pkg.Registry.add(url = "https://github.com/ITensor/ITensorRegistry")
    ```
    or:
    ```julia
    julia> Pkg.Registry.add(url = "git@github.com:ITensor/ITensorRegistry.git")
    ```
    if you want to use SSH credentials, which can make it so you don't have to enter your Github ursername and password when registering packages.

    Then, use `LocalRegistry.jl` to register the package. First, you should add `LocalRegistry.jl` in your global environment. Then, activate the package and call:
    ```julia
    using LocalRegistry: LocalRegistry
    LocalRegistry.register()
    ```
    """
end

"""
$(SIGNATURES)

!!! warning

    This function might overwrite existing code if you specify a path to a package that already exists, use with caution! See [`PkgSkeleton.jl`](https://github.com/tpapp/PkgSkeleton.jl) for more details. If you are updating an existing package, make sure you save everything you want to keep (for example, commit all of your changes if it is a git repository).

Generate a package template for a package, by default in the ITensor organization, or update an existing package. This is a wrapper around [`PkgSkeleton.generate`](https://github.com/tpapp/PkgSkeleton.jl) but with extra functionality, custom templates used in the ITensor organization, and defaults biased towards creating a package in the ITensor organization.

# Examples

```julia
julia> using ITensorPkgSkeleton: ITensorPkgSkeleton;

julia> ITensorPkgSkeleton.generate("NewPkg"; path = mktempdir());

julia> ITensorPkgSkeleton.generate("NewPkg"; path = mktempdir());

julia> ITensorPkgSkeleton.generate(
           "NewPkg";
           path = mktempdir(),
           templates = ITensorPkgSkeleton.default_templates()
       );

julia> ITensorPkgSkeleton.generate("NewPkg"; path = mktempdir(), templates = ["github"]);

julia> ITensorPkgSkeleton.generate(
           "NewPkg"; path = mktempdir(), templates = ["src", "github"]
       );

julia> ITensorPkgSkeleton.generate(
           "NewPkg"; path = mktempdir(), ignore_templates = ["src", "github"]
       );

julia> ITensorPkgSkeleton.generate("NewPkg"; path = mktempdir(), ghuser = "MyOrg");

julia> ITensorPkgSkeleton.generate(
           "NewPkg"; path = mktempdir(), downstreampkgs = ["ITensors", "ITensorMPS"]
       );

```

# Arguments

  - `pkgname::AbstractString`: Name of the package (without the `.jl` extension). Replaces `{PKGNAME}` in the template.

# Keywords

  - `path::AbstractString`: Path where the package will be generated. Defaults to the [development directory](https://pkgdocs.julialang.org/v1/api/#Pkg.develop), i.e. `$(default_path())`.
  - `templates`: A list of templates to use. Select a subset of `ITensorPkgSkeleton.all_templates() = $(all_templates())`. Defaults to `ITensorPkgSkeleton.default_templates() = $(default_templates())`.
  - `ignore_templates`: A list of templates to ignore. This is the same as setting `templates=setdiff(templates, ignore_templates)`.    # Process downstream package information.
  - `downstreampkgs`: Specify the downstream packages that depend on this package. This populates the `IntegrationTest.yml` matrix in the `github` template. If empty, the workflow defaults to `__none__`.
  - `uuid`: Replaces `{UUID}` in the template. Defaults to the existing UUID in the `Project.toml` if the path points to an existing package, otherwise generates one randomly with `UUIDs.uuid4()`.
  - `year`: Replaces `{YEAR}` in the template. Year the package/repository was created. Defaults to the current year.    # Check if there are downstream tests.
"""
function generate(
        pkgname; path = default_path(), templates = default_templates(),
        ignore_templates = [], user_replacements...
    )
    pkgpath = joinpath(path, pkgname)
    user_replacements = merge(default_user_replacements(), user_replacements)
    # Process downstream package information.
    user_replacements = format_downstreampkgs(user_replacements)
    templates = setdiff(templates, ignore_templates)
    templates = prepare_templates(templates)
    is_new_repo = !is_git_repo(pkgpath)
    branch_name = default_branch_name()
    user_replacements_pkgskeleton = to_pkgskeleton(user_replacements)
    @suppress PkgSkeleton.generate(
        pkgpath; templates, user_replacements = user_replacements_pkgskeleton
    )
    if is_new_repo
        # Change the default branch if this is a new repository.
        change_branch_name(pkgpath, branch_name)
        set_remote_url(path, pkgname, user_replacements.ghuser)
    end
    if is_new_repo
        println(pkg_registration_message(; pkgname, path))
    end
    return nothing
end

end
