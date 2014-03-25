function [cont, MED_plot] = MED_points(colour, x_vals, y_vals, points, prototype_1, prototype_2, plot_bool)

    MED_plot = 0;
    dists = [];
    
    dist1 = sum((bsxfun(@minus,points,prototype_1)).^2, 2);
    
    dist2 = sum((bsxfun(@minus,points,prototype_2)).^2, 2);
    
    dists = [dist1(:) dist2(:)];
    
    

    [~,mins] = min(dists, [], 2);
    cont = reshape(mins, length(x_vals), length(y_vals));
    cont = cont'; 
    if plot_bool == 1
        [c, h] = contour(x_vals,y_vals, cont, 1, colour);
        MED_plot = h;
    end
    
  
end