classdef Confusion
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    
    methods (Static)
        function class = convertFeatureToClass(features)
            numberOfClasses= max(features(3,:));
            class=[];
            
            for k=1:numberOfClasses
                color=rand(1,3);
                thisClass=features(1:2,features(3,:)==k);
                temp = dataClass(thisClass',color);
                temp.mean=learning.learnMean(temp);
                temp.covariance=learning.learnCovariance(temp);
                temp.invcovariance=inv(temp.covariance);
                
                class = [class temp];
            end
        end
        
        function confusion = confusionForMICD(tests,cls)
            numberOfVariables = length(cls);
            numberOfPoints = length(tests(:,1));
            dist=[];
            confusion = zeros(1,numberOfVariables);
             for i = 1:numberOfPoints
                for j = 1:numberOfVariables
                     difference = tests(i,:) - cls(j).mean;
                    transVals = difference*cls(j).invcovariance*difference';

                    dist = [dist transVals];
                end
                
                [~, minimumClass] = min(dist);
                confusion(1,minimumClass) = confusion(1,minimumClass) +1; %conf mat histogram
                dist = [];
             end
             
        end
        
         function confusionMatrix = outputConfusion(cls, tst)
            testClass = Confusion.convertFeatureToClass(tst);
            confusionMatrix = [];
            for i = 1:length(testClass)
                confusionMatrix = [confusionMatrix; Confusion.confusionForMICD(testClass(i).cluster, cls)];
            end
         end
        function [xVals, yVals, testPoints, zeroGrid] = createMatrix(stepSize, class)

            mixedVals = [];
            buffer = 5;
            mixedVals = [mixedVals; class.cluster];
            
            
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
    end
    
end

