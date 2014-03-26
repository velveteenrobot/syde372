classdef learning
    
    
    methods (Static)
        function mu = learnMean(class)
            % Learns the mean of a data set
            mu = ((1/length(class.cluster))*sum(class.cluster));
        end

        function var = learnVariance(class)
            % Learns the variance of a data set
            if (isempty(class.variance) == 1)
                defs = 0;
                data = class.cluster;
                for k=1:length(data),
                    defs = defs + (data(k,:)-class.mean)*(data(k,:)-class.mean)';
                end

                var = ((1/(length(class.cluster)*length(data)))*defs);
            else
                var = dvar;
            end
        end

        function [cov, data] = learnCovariance(class)
           
            defs = [0 0; 0 0];
            data = class.cluster;

            for k=1:length(data),
                defs = defs + (data(k,:)-class.mean)'*(data(k,:)-class.mean);
            end

            cov = ((1/(length(data)))*defs);
        end

    end
    
end

