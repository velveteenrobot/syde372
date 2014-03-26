classdef dataClass
    properties
        a
        b
        mean
        variance
        covariance
        color
        cluster
        invcovariance
    end
    methods
        function obj = dataClass(data, colour)
            a = 0;
            b = 0;
            mean = [];
            variance = [];
            covariance = [];
            obj.color = colour;
            obj.cluster = data;
        end
    end 
end
