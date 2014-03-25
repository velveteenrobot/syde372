function [disc, MED_plots, disc_plot] = sequential_discriminant(step, A, B)

    A_data = A; 
    B_data = B; 
    MED_plots = []

    vals = [];
    vals = [A_data; B_data];
  
    mins = min(vals);
    maxs = max(vals);

    x_vals = mins(:,1):step:maxs(:,1);
    y_vals = mins(:,2):step:maxs(:,2);

    [x,y] = meshgrid(x_vals, y_vals);
    c = cat(2,x',y');
    points = reshape(c,[],2);

    
    A_prototype = []; 
    B_prototype = [];
    disc = zeros(length(y_vals), length(x_vals));
    iter = 0;

    while(~isempty(A_data) && ~isempty(B_data))
        empty = 'Not empty'
        A_confusion = [0 0]; B_confusion = [0 0]; 

        while(~isempty(A_confusion) && ~isempty(B_confusion))
            
            iter = iter + 1;
            A_prototype = A_data(randi(length(A_data(:,1)),1),:); 
            B_prototype = B_data(randi(length(B_data(:,1)),1),:);
 
            dists = [];
            
            A_conf = []; B_conf = [];

            for k=1:length(A_data(:,1))
                
                p1 = A_data(k,:);
                p2 = A_prototype;
                
                dist_A_1 = sqrt(sum((p1 - p2) .^ 2));
                
                p3 = B_prototype;
                
                dist_A_2 = sqrt(sum((p1 - p3) .^ 2));
                
                dists = [dist_A_1 dist_A_2]
                
                [~, close_class] = min(dists);
                dists = [];

                if(close_class ~= 1)
                    A_conf = [A_conf; A_data(k,:)];
                end
            end
            
        
            
            for k=1:length(B_data(:,1))
                
                p1 = B_data(k,:);
                p2 = A_prototype;
                
                dist_B_1 = sqrt(sum((p1 - p2) .^ 2));
                
                p3 = B_prototype;
                
                dist_B_2 = sqrt(sum((p1 - p3) .^ 2));
                
                dists = [dist_B_1 dist_B_2];
                
                [~, close_class] = min(dists);
                dists = [];

                if(close_class ~= 2)
                    B_conf = [B_conf; B_data(k,:)];
                end
                
            end
            
            A_confusion = A_conf;
            B_confusion = B_conf;
           
            
        end

        hold on;
        [ctr, MED_plot] = MED_points('--b', x_vals, y_vals, points,...
            A_prototype, B_prototype, 1);
        MED_plots = [MED_plots MED_plot]; 

        vals2 = [];
        if(isempty(A_confusion) && isempty(B_confusion)),
            vals2 = ctr;
            A_data = A_confusion; B_data = B_confusion;
        elseif(isempty(A_confusion)),
            mod = 2;
            vals2 = (ctr == mod).*mod;
            B_data = B_confusion;
        elseif(isempty(B_confusion)),
            mod = 1;
            vals2 = (ctr == mod).*mod;
            A_data = A_confusion;
        else(~isempty(A_confusion) && ~isempty(B_confusion)), 
            error('failed.'); 
        end

        
        disc = ((disc==0).*(vals2)) + disc;
    end
    [c, h] = contour(x_vals, y_vals, disc, 3, '--r');
    disc_plot = h;
end