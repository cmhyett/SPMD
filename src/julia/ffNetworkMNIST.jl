# set up reproducible, stable environment
using Flux, MLDatasets, Statistics, Serialization;

function main(outputPath, maxEpochs)
    x_train, y_train = MNIST(split=:train)[:]
    x_test, y_test = MNIST(split=:test)[:]

    W,H,N = size(x_train);
    x_train = reshape(x_train, (W*H,N));
    #x_train = reshape(x_train, (W,H,1,N));
    y_train = Flux.onehotbatch(y_train, 0:9);

    W,H,N = size(x_test);
    x_test = reshape(x_test, (W*H,N));
    y_test = Flux.onehotbatch(y_test, 0:9);


    model = Chain(Dense(784, 128, relu),
                  Dense(128, 64, relu),
                  Dense(64, 10),
                  softmax);

    # model = Chain(Conv((3,3), 1=>1),
    #               AdaptiveMaxPool((14,14)),
    #               Conv((3,3), 1=>1),
    #               AdaptiveMaxPool((10,1)),
    #               softmax)

    loss(model, x, y) = mean(abs2.(model(x) .- y));

    data = [(x_train, y_train)];
    opt = Flux.setup(ADAM(), model);
    maxEpochs = 1000;
    lossArray = zeros(maxEpochs);

    for epoch in 1:maxEpochs
        for d in data
            lossArray[epoch],g = Flux.withgradient(loss, model, d...);
            println("loss = $(lossArray[epoch])");
            Flux.update!(opt, model, g[1]);
        end
    end

    serialize(lossArray, outputPath * "/lossArray.jls");
end
