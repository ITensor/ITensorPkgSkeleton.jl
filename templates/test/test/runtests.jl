using SafeTestSets

# check for filtered groups
# either via `--group=ALL` or through ENV["GROUP"]
const pat = r"(?:--group=)(\w+)"
arg_id = findfirst(contains(pat), ARGS)
const GROUP = uppercase(
  if isnothing(arg_id)
    get(ENV, "GROUP", "ALL")
  else
    only(match(pat, ARGS[arg_id]).captures)
  end,
)

@time begin
  # tests in groups based on folder structure
  for testgroup in filter(isdir, readdir(@__DIR__))
    if GROUP == "ALL" || GROUP == uppercase(testgroup)
      for file in readdir(joinpath(@__DIR__, testgroup); join=true)
        @safetestset begin
          include(file)
        end
      end
    end
  end

  # single files in top folder
  for file in filter(isfile, readdir(@__DIR__))
    @safetestset begin
      include(file)
    end
  end
end
