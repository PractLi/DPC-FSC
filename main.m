clc;clear;close all;
%% prepare input data
filename = readtable('datasets/synthetic/S2.xlsx');
dataRaw = table2array(filename(:, 1:end-1));
tlabels = table2array(filename(:, end));
data = normalize(dataRaw, 'range');
numoflabels = length(unique(tlabels));
[num, nfeatures] = size(dataRaw);

%% compute KNN
k = round(0.1*num);
[nb_indexes, nb_dists] = knnsearch(data, data, 'K', k+1);
nb_indexes(:, 1) = [];
nb_dists(:, 1) = [];

%% compute pairwise distance and the upper bound of b
pairwise_distance = pdist2(data, data, 'euclidean');
maxdist = max(pairwise_distance, [], 'all');

%% compute b using the principle of maximum density
a = 0.5;
lossfunc = @(b) -sum(local_density(b, a, nb_dists));
options = optimset('Display','off');
b = fminbnd(lossfunc,0,maxdist*1.5,options);

%% compute the local density, the fuzzy semantci distance and the relative semantic distance
density = local_density(b, a, nb_dists);
fuzzy_distance = fuzzy_dist(pairwise_distance, b);
[relativeSemanticDist, iind] = relative_dist(density, fuzzy_distance);

%% compute pseudo label based on DPC clustering strategy
[dpeaksindex, plabels] = clustering(relativeSemanticDist, density, iind, numoflabels);

ARI = rand_index(tlabels, plabels, 'adjusted');

figure(1);
hold on;
scatter(data(:, 1), data(:, 2), 'filled')
scatter(data(dpeaksindex, 1), data(dpeaksindex, 2), 'red', 'd', 'filled');
hold off;

figure(2);
hold on;
scatter(density, relativeSemanticDist, 'filled');
scatter(density(dpeaksindex), relativeSemanticDist(dpeaksindex), '^', 'filled');
hold off;

figure(3);
hold on;
gscatter(data(:, 1), data(:, 2), plabels);
scatter(data(dpeaksindex, 1), data(dpeaksindex, 2), 50, 'k^', 'filled');
hold off;