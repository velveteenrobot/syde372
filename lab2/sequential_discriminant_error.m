function [disc, MED_plots, disc_plot, A_confusion, B_confusion] = sequential_discriminant_error(step, A, B, J_max, plot_bool)

    %Set J_max = -1 in order for it to have no limit on number of
    %discriminants
   
    disc_plot = 0;
    no_limit = 0;
    if J_max == -1
        no_limit = 1;
    end
    
    A_data = A; 
    B_data = B; 
    MED_plots = [];
    J = 1;
    limit_reached = 0;
    vals = [];
    vals = [A_data; B_data];
    
    while (limit_reached ~= 1 && ~isempty(A_data) && ~isempty(B_data))
        
        num_A_as_B = 0;
        num_B_as_A = 0;
        
        mins = min(vals);
        maxs = max(vals);

        x_vals = 0:step:600;
        y_vals = 0:step:450;

        [x,y] = meshgrid(x_vals, y_vals);
        c = cat(2,x',y');
        points = reshape(c,[],2);


        A_prototype = []; 
        B_prototype = [];
        disc = zeros(length(y_vals), length(x_vals));
        %disc = [];
        iter = 0;

        while(~isempty(A_data) && ~isempty(B_data))
            
            A_confusion = [0 0]; B_confusion = [0 0]; 

            while(~isempty(A_confusion) && ~isempty(B_confusion))
                
                iter = iter + 1;
                A_prototype = A_data(randi(length(A_data(:,1)),1),:); 
                B_prototype = B_data(randi(length(B_data(:,1)),1),:);

                dists = [];

                A_conf = []; 
                B_conf = [];
                
                
                for k=1:length(A_data(:,1))

                    p1 = A_data(k,:);
                    p2 = A_prototype;

                    dist_A_1 = sqrt(sum((p1 - p2) .^ 2));

                    p3 = B_prototype;

                    dist_A_2 = sqrt(sum((p1 - p3) .^ 2));

                    dists = [dist_A_1 dist_A_2];

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
                
                if (~isempty(A_conf) && ~isempty(B_conf))
                    continue
                end
                
                
                [ctr, MED_plot] = MED_points('--b', x_vals, y_vals, points,...
                    A_prototype, B_prototype, 0);
                
                if (ctr == 0)
                    continue
                end
                
                num_A = 0;
                for i=1:size(A_data, 1)
                   x = A_data(i,1);
                   y = A_data(i,2);
                   if ctr(y,x) ~= 1
                       num_A = num_A + 1;
                   end

                end 

                num_B = 0;
                for i=1:size(B_data,1)
                   x = B_data(i,1);
                   y = B_data(i,2);
                   if ctr(y,x) ~= 1
                       num_B = num_B + 1;
                   end

                end 
                
                if (num_A ~= 0 && num_B ~= 0)
                    continue
                end
                
                

                A_confusion = A_conf;
                B_confusion = B_conf;


            end

            hold on;
            %[ctr, MED_plot] = MED_points('--b', x_vals, y_vals, points,...
            %    A_prototype, B_prototype, plot_bool);
            
            if plot_bool == 1
            
                [c, MED_plot] = contour(x_vals,y_vals, ctr, 1, '--b');
            end
           
            MED_plots = [MED_plots MED_plot]; 
            
            %A_results = MED_all_samples(A_data, [A_prototype; B_prototype]);
            %B_results = MED_all_samples(B_data, [B_prototype; A_prototype]);
           
            
            vals2 = [];
           
            
            if(isempty(A_confusion) && isempty(B_confusion)),
                vals2 = ctr;
                A_data = A_confusion; 
                B_data = B_confusion;
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

            % - Finds all locations in current contour that are 0
            % - Finds all location in new contour that match our modifier (class)
            % - Multiplies these together to create a composite contour of
            %	where our new contour can "fit" in our current contour
            % - "copies" composite map into our current map.
            
            disc = ((disc==0).*(vals2)) + disc;
            
            %temp = [A_prototype B_prototype size(B_confusion,1) size(A_confusion,1)];
            %disc = [disc; temp];
            
            
            if no_limit ~= 1
                if J >= J_max
                    limit_reached = 1;
                    break;
                end
             
                J = J + 1;
            end
        end
   
    end
    if plot_bool == 1
        
        [c, h] = contour(x_vals, y_vals, disc, 3, '--r');
        disc_plot = h;
    end
end