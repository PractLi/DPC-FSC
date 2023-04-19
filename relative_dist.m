function [relativeDist, iind] = relative_dist(density, fuzzy_distance)
    num = length(density);
    relativeDist = -1 * ones(num, 1);
    iind = -1 * ones(num, 1);
    for i = 1: num
        ind = find(density > density(i));
        if isempty(ind)
            [relativeDist(i), iind(i)] = max(fuzzy_distance(i, :));
        else
            [relativeDist(i), id] = min(fuzzy_distance(i, ind));
            iind(i) = ind(id);
        end
    end
end

