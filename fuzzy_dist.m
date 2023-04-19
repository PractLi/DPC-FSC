function fuzzy_distance = fuzzy_dist(pairwise_distance, b)
    mu = exp(-(pairwise_distance.^2)./b);
    fuzzy_distance = pdist2(mu, mu, 'minkowski', 2);
end