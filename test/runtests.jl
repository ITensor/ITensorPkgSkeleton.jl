using ITensorPkgSkeleton: ITensorPkgSkeleton

ITensorPkgSkeleton.runtests(;
    testdir = @__DIR__,
    runtests_file = @__FILE__,
    args = ARGS,
    env = ENV
)
