function Y = initialPrototype(data, k)
%INITIALPROTOTYPE generates k initial prototypes for k-means clustering

    pIndecies = randsample(size(data, 2), k);
    Y = data(:,pIndecies);
end

