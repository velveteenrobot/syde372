function Y = MED(data, classes)
%MED MED classification
    
    nClasses = size(classes, 2);
    nPoints = size(data, 2);
    
    temp = zeros(nClasses, nPoints);
    
    for i=1:nClasses
        comp = repmat(classes(:,i), 1, nPoints);
        diff = (data - comp).^2;
        result = sum(diff,1);
        temp(i,:) = result;
    end
    
    [a b] = min(temp);
    Y = b;
end

