include("./ffNetworkMNIST.jl");

# parse arguments that use environment variables to
#  specify unique run
outputPath, maxEpochs = ARGS;
maxEpochs = parse(Int, maxEpochs);

# perform processing and save results
main(outputPath, maxEpochs);
