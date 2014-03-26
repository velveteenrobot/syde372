classdef EstimationTwo
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        function f = gaussianWindow2d(n, step, var)
      
            [x y] = meshgrid(round(-n/2):step:round(N/2));

            f = exp(-x.^2/(2*var)-y.^2/(2*var));
            f = func./sum(f(:)); % normalizes the function
        end
        
       function prob = gaussianProbability(class, p)
            
           class.invcovariance=inv(class.covariance);
            trans = (p - class.mean)*class.invcovariance*(p - class.mean)';
            
            expo = exp((-1/2)*(trans));
            prob = (1/(det(class.covariance)*sqrt(2*pi)))*expo;
       end
        
       	function cont1 = drawMLContour(step, cA, cB, cC)

			[xVals, yVals, testPts, cont] = EstimationTwo.createMatrix(step, cA, cB, cC);

			cont1 = EstimationTwo.maxLikeClass('k',xVals,yVals,testPts,cont,cA,cB,cC);
        end
        
       function [xVals, yVals, testPoints, zeroGrid] = createMatrix(stepSize, varargin)

            mixedVals = [];
            buffer = 5;
            for k = 1 : length(varargin)
                mixedVals = [mixedVals; varargin{k}.cluster];
            end
            
            %extracts min/max x and y from mixed data
            mins = min(mixedVals);
            maxs = max(mixedVals);
            
            xVals = mins(:,1)-buffer:stepSize:maxs(:,1)+buffer;
            yVals = mins(:,2)-buffer:stepSize:maxs(:,2)+buffer;
            
            [x,y] = meshgrid(xVals, yVals);
            c = cat(2,x',y');
            testPoints = reshape(c,[],2);
            
            zeroGrid = zeros(length(xVals),length(yVals));
        end

      function cont = maxLikeClass(colour, x, y, testPts, cont, c1, c2, c3) 

            xIndex = 1; yIndex = 1;
            numXs = length(x);
            
            for k = 1: length(testPts(:,1))
                pt = testPts(k,:);

                probabilityc1 = EstimationTwo.gaussianProbability(c1, pt);
                probabilityc2 = EstimationTwo.gaussianProbability(c2, pt);
                probabilityc3 = EstimationTwo.gaussianProbability(c3, pt);
                vals = [probabilityc1 probabilityc2 probabilityc3];
                [~, ind] = max(vals);

                cont(xIndex, yIndex) = ind;
                
                if(xIndex == numXs)
                    xIndex = 1;
                    yIndex = yIndex +1;
                else
                    xIndex = xIndex +1;
                end
            end
            
            [c, h] = contour(x, y, cont', 2, colour);
      end
        
      
		function [pdf, xVs,yVs] = parzenEstimation(stepSize, windowSize, windowVariance, varargin)

			[xVals, yVals, ~, ~] = EstimationTwo.createMatrix(stepSize, varargin{:});
			xmin = min(xVals); xmax = max(xVals); ymin = min(yVals); ymax = max(yVals);
			resVec = [stepSize xmin ymin xmax ymax];

			gaussWindow = fspecial('gaussian', [windowSize windowSize], sqrt(windowVariance));
			pdf = []; xVs = []; yVs = [];
			for k=1:length(varargin)
				[p,xVs,yVs] = parzen2(varargin{k}.cluster, resVec, gaussWindow);
				pdf = [pdf p(:)]; % add all points as a column
            end

        end
        
         function [index, cont2] = drawParzenML(colour, yVs, xVs, pdf)

            [~,index] = max(pdf, [], 2);

            cont2 = reshape(index, length(yVs), length(xVs));

          [c, h] = contour(xVs, yVs, cont2,2, colour);
        end

    end
    
end

