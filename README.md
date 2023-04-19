# DPC-FSC
The code for [DPC-FSC: An approach of fuzzy semantic cells to density peaks clustering](https://www.sciencedirect.com/science/article/abs/pii/S0020025522011616)



Tips:

1. The input data is in the form of a matrix, where each row represents one sample and each column represents the corresponding feature.

2. Need to compute the KNN ($k$-nearest neighbors) of each sample using a value of $k = 0.1 * N$, where $N$ is the total number of samples in the given dataset.

4. This method requires tuning the hyperparameter $a$, where $a$ is a value between 0 and 1. Empirically, a clearer generated decision graph usually corresponds to a better choice of the hyperparameter $a$.

