function prob = getSigmoidContactProbability(x, a, b)

    prob = 1./(1+exp(a*x' + b));
    prob(prob > 0.5) = 1;
    prob(prob < 0.5) = 0;

end