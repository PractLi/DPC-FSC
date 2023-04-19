clc;clear;close all;
% filename = {'Aggregation', 'flame',  'Spiral', 'R15', 'S2', 'S3', 'S4',  'A3', 'D31'};
filename = readtable('datasets/synthetic/S2.xlsx');
dataRaw = table2array(filename(:, 1:end-1));
tlabels = table2array(filename(:, end));
data = normalize(dataRaw, 'range');
numoflabels = length(unique(tlabels));
[num, nfeatures] = size(dataRaw);
pairwise_distance = pdist2(data, data, 'euclidean');
maxdist = max(pairwise_distance, [], 'all');
k = round(0.1*num);
[nb_indexes, nb_dists] = knnsearch(data, data, 'K', k+1);
nb_indexes(:, 1) = [];
nb_dists(:, 1) = [];

a = 0.5;
lossfunc = @(b) -sum(local_density(b, a, nb_dists));
options = optimset('Display','off');
b = fminbnd(lossfunc,0,maxdist*1.5,options);

density = local_density(b, a, nb_dists);
fuzzy_distance = fuzzy_dist(pairwise_distance, b);

[dpeaksindex, relativeDist, plabels] = findpeaks(fuzzy_distance, density, num, numoflabels);
ARI = rand_index(tlabels, plabels, 'adjusted');

figure(1);
hold on;
scatter(data(:, 1), data(:, 2), 'filled')
scatter(data(dpeaksindex, 1), data(dpeaksindex, 2), 'red', 'd', 'filled');
hold off;

figure(2);
hold on;
scatter(density, relativeDist, 'filled');
scatter(density(dpeaksindex), relativeDist(dpeaksindex), '^', 'filled');
hold off;

figure(3);
hold on;
gscatter(data(:, 1), data(:, 2), plabels);
scatter(data(dpeaksindex, 1), data(dpeaksindex, 2), 50, 'k^', 'filled');
hold off;