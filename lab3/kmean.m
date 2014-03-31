function Y = kmeans(data, k, limit)
% KMEANS k-means clustering
    
    % get size of data mat
    n = size(data, 2);

    % generate initial random prototypes
    p = initialPrototype(data, k);
    newp = zeros(size(p,1), size(p,2));
    
    isRunning = 1;
    count = 1;
    
    while isRunning == 1
        output = MED(data, p);
        for i=1:k
            mask = output == i*ones(1,n);
            index = find(mask);
            cluster = data(:,index);
            newp(:,i) = Centroid(cluster);
            i
        end
        
        if newp ~= p
            p = newp;
        elseif newp == p
            isRunning = 0;
        end
        count = count + 1;
        
        if count >= limit
            isRunning = 0;
        end
    end
    
    Y = p;
end

