function Y = Centroid(data)
%CENTROID Summary of this function goes here

    Y = sum(data, 2).*(1/size(data, 2));

end

