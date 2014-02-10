function [ classified_class ] = MED(means, range1, range2)

%going to output matrix of classified points 
%then can just draw contour easily
means
classified_class = zeros(length(range1), length(range2));

dist_from_means = zeros(1, size(means, 1));

for i=1:length(range1)
    for j=1:length(range2)
        for k=1:size(means, 1)
            dist_range1 = means(k,1) - range1(i);
            dist_range2 = means(k,2) - range2(j);
            dist_from_means(k) = sqrt(dist_range1^2 + dist_range2^2);
        end
        [val,idx] = min(dist_from_means);
        classified_class(i,j) = idx;
    end
end

