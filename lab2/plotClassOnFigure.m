function plotClassOnFigure(Class)

            hold on;
            scatter(Class.cluster(:,1), Class.cluster(:,2), 5, ...
                Class.color, 'filled');
        end
