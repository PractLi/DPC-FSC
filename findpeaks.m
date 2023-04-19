function [dpeaksindex, relativeDist, labels] = findpeaks(fuzzy_distance, density, num, numoflabels)
    relativeDist = -1 * ones(num, 1);
    labels = -1 * ones(num, 1);
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
    
    tao = relativeDist .* density;
    [~, dpeaksindex] = topkrows(tao, numoflabels);
    
    for i = 1: numoflabels
        labels(dpeaksindex(i)) = i;
    end
    
    [~, I] = sort(density, 'descend');
    for i = 1: num
        p = I(i);
        if ~ismember(p, dpeaksindex)
            labels(p) = labels(iind(p));
        end
    end
    
end

