% {
%     kNN_FS
%     Function used to classify via a kNN algorithm
%     
%     output: Matrix Y
%     inputs :
%                 x: range of points in dimension 1
%                 y: range of points in dimension 2
%                 k: the k in knn -- constant of which we find the mean to use as a prototype
%                 varargin: list of arguments, contains all the classes we need to classify -- note this is a native argument for matlab. Everything after the k dimension goes into the varargin list.
% }



function Y = kNN(x, y, k, varargin)

Y = zeros(length(x), length(y),2); %create the output Y matrix, initialise it with zeros
    for i=1:length(varargin) %iterate through the classes
        thisClass = cell2mat(varargin(i)); % we need to combine the classes in the argument list into an 'array of matrices',then access the ith class
        for j=1:length(x) %iterate through the x range of values
            xDist = repmat(x(j),size(thisClass, 1),1); %the distance of the current x value in the x range
            xDist = xDist - thisClass(:,1); %subtract the 'x' direction distance to every value in the current class column (class position x values)
            xDist = xDist.^2; %square the difference to use in euclidean distance calculation
            for n=1:length(y) %for each x value we have to also iterate through all y values
                yDist = repmat(y(n), size(thisClass, 1),1); %distance of current y value in the y range
                yDist = yDist - thisClass(:,2); %subtract the 'y' direction distance to every value in the current class column (class position y values)
                yDist = yDist.^2; %squre the difference to use in euclidean distance calculation

                euclidean = zeros(size(thisClass, 1),2); % initiate the euclidean distance matrix with zeros
                euclidean = [(xDist + yDist) (1:size(thisClass,1))']; % add the squared x and y values to find the total euclidean distance
               
                euclidean = sortrows(euclidean,1); %sort the euclidean matrix rows so we can find the closest k distances

                counter = [0,0]; %initialise a 1x2 matrix that will hold the total distances summed up over k points
                for m=1:k
                    thisSample = euclidean(m,2); %pick out the current sample from the euclidean matrix
                    counter = counter + [thisClass(thisSample, 1) thisClass(thisSample,2)]; %sum up all the distances
                end
                
                distance = counter./k; %divide the sum of k distances by k to find the mean
                distance = [x(j) y(n)] - distance; % find the distance between the mean distance and the x and y distances for this iteration
                distance = distance.^2;
                distance = sum(distance); %sum up the distance matrix
                
                if i==1 %if this is the first pass, just fill in the Y matrix with the distances from that iteration
                    Y(j,n,1) = distance;
                    Y(j,n,2) = i;
                elseif (i > 1 && distance < Y(j,n,1)) %for every subsequent pass, if the calculated distance value is smaller then the Y value at the current indices, replace the values at those indices with the calculated distance.
                    Y(j,n,1) = distance;
                    Y(j,n,2) = i;
                end
            end
        end
    end
Y = Y(:,:,2); %we really only need the points and not the distances so clear everything else


