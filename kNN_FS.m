
function Y = kNN(x, y, k, varargin)
Y = zeros(length(x), length(y),2);

    for i=1:length(varargin)
        thisClass = cell2mat(varargin(i));
        for j=1:length(x)
            xDist = repmat(x(j),size(thisClass, 1),1);
            xDist = xDist - thisClass(:,1);
            xDist = xDist.^2;
            for n=1:length(y)
                yDist = repmat(y(n), size(thisClass, 1),1);
                yDist = yDist - thisClass(:,2);
                yDist = yDist.^2;

                euclidean = zeros(size(thisClass, 1),2);
                euclidean = [(xDist + yDist) (1:size(thisClass,1))'];
                %(1:size(thisClass,1))'
                euclidean = sortrows(euclidean,1);

                counter = [0,0];
                for m=1:k
                    thisSample = euclidean(m,2);
                    counter = counter + [thisClass(thisSample, 1) thisClass(thisSample,2)];
                end
                
                distance = counter./k;
                distance = [x(j) y(n)] - distance;
                distance = distance.^2;
                distance = sum(distance);
                
                if i==1
                    Y(j,n,1) = distance;
                    Y(j,n,2) = i;
                elseif (i > 1 && distance < Y(j,n,1))
                    Y(j,n,1) = distance;
                    Y(j,n,2) = i;
                end
            end
        end
    end
Y = Y(:,:,2);


