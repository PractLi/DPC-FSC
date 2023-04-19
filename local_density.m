function density = local_density(b, a, nb_dists)
nb_dists = nb_dists.^2;
density = b^(a-1)*gamma(a)* sum(1 - gamcdf(nb_dists, a, b), 2);
end