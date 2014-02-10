function [ classified_class ] = MAP(means, range1, range2, std_devs, priors)

classified_class = zeros(length(range1), length(range2));

dist_from_means = zeros(1, size(means, 1));

for i=1:length(range1)
    for j=1:length(range2)
        for k=1:size(means, 1)
            d = [range1(i) range2(j)] - means(k,:);
            dist_from_means(k) = d/std_devs(:,:,k)*d' - log(det(std_devs(:,:,k))) + 2* log(priors(k));
        end 
        [val,idx] = min(dist_from_means);
        classified_class(i,j) = idx;
    end
end


end

