using Serialization, Plots

function plotMonteCarlo(resultsPath)
    p = plot();
    for i in 1:10
        inputPath = resultsPath * "/$(i)/"
        loss = deserialize(inputPath * "/lossArray.jls");
        plot!(p, loss);
    end
    plot!(p, title="Loss vs Epoch for initializations of NN", yaxis=:log, legend=false);
    savefig(p, resultsPath * "/loss.png");
end
