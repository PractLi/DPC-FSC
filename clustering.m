function [dpeaksindex, labels] = clustering(relativeDist, density, iind, numoflabels)
    num = length(density);
    labels = -1 * ones(num, 1);
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

