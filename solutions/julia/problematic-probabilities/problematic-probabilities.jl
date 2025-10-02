using Statistics

function rationalize(successes, trials)
    [a // b for (a, b) = zip(successes, trials)]
end

function probabilities(successes, trials)
    [a / b for (a, b) = zip(successes, trials)]
end

function checkmean(successes, trials)
    rat_mean = Statistics.mean(rationalize(successes, trials))
    float_mean = Statistics.mean(probabilities(successes, trials))
    float(rat_mean) == float_mean ? true : rat_mean
end

function checkprob(successes, trials)
    rat_prod = prod(rationalize(successes, trials))
    float_prod = prod(probabilities(successes, trials))
    float(rat_prod) == float_prod ? true : rat_prod
end

successes, trials = [2, 9, 4, 4, 5], [15, 11, 17, 19, 15];
checkprob(successes, trials)