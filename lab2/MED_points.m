function [cont, MED_plot] = MED_points(colour, x_vals, y_vals, points, prototype_1, prototype_2)
    % Minimum Euclidian Distance classifier.
    % --
    % colour = colour of decision boundary
    % xVals = range of all x-values to be tested
    % yVals = range of all y-values to be tested
    % testPts = matrix of all points of evaluation. Contains all
    %           combinations of xVals and yVals. Improves performance.
    % cont = Contour map that gets populated with decision boundary.
    %        Will be a matrix based on classification of points.
    % varargin = set of class prototypes.

    dists = [];
    
    dist1 = sum((bsxfun(@minus,points,prototype_1)).^2, 2);
    
    dist2 = sum((bsxfun(@minus,points,prototype_2)).^2, 2);
    
    dists = [dist1(:) dist2(:)]
    
    

    [~,mins] = min(dists, [], 2);
    cont = reshape(mins, length(x_vals), length(y_vals));
    cont = cont'; %transpose for laughs

    [c, h] = contour(x_vals,y_vals, cont, 1, colour);
    MED_plot = h;
end