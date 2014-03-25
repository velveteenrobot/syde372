%lab2 

close all;
clear all;

%% 2.4 Non-parametric estimation

load('lab2_1.mat')

[x, dist] = parzen1(a, 0.1, 0.1);

figure;
hold on;

% true density
[f,w] = hist(a,length(a));
dx = diff(w(1:2));
bar(w,f/sum(f*dx), 'y');
x_axis = min(w):(max(w)-min(w))/(length(dist) - 1):max(w);

%gaussian with given mu, sigma
normthing = normpdf(x_axis, 5, 1)
plot(x_axis, normthing, 'Color', [1 0 0], 'LineWidth', 2)

%pdf from parzen1
plot(x_axis,dist, 'LineWidth', 2)


%% 4 Sequential Discriminants

step = 1;

load('lab2_3.mat');

figure;
hold on;

class_A = scatter(a(:,1), a(:,2), 5, ...
                'r', 'filled');

class_B = scatter(b(:,1), b(:,2), 5, ...
                'g', 'filled');
hold on;
plot_bool = 1;
[contour, MED_plots, disc_plot] = sequential_discriminant(step, a, b);
legend([class_A class_B disc_plot MED_plots(1)],{'Class A', 'Class B', 'Decision Boundary', 'Discriminants'});
plot_bool = 0;

%Plotting Error
error_rates = zeros(20, 5);
figure;


for i=1:5   %max discrim set from 1 to 5
    i
    for j=1:20  % n = 20
        j
        [contour, MED_plots, disc_plot, A_confusion, B_confusion] = sequential_discriminant_error(step, a, b, i, plot_bool);
        confusion = get_confusion_matrix(a, b, A_confusion, B_confusion);
        error_rates(j,i) = (sum(confusion(:)) - trace(confusion)) / sum(confusion(:));
    end
end



%plotting min, mean, max, and stddev in order in seperate plots
scatter([1 2 3 4 5], max(error_rates), 'fill');
hold on;
scatter([1 2 3 4 5], mean(error_rates), 'fill', 'g');
scatter([1 2 3 4 5], min(error_rates), 'fill', 'r');
title('Error Rate vs Max Number of Discriminants');
legend('Max Error Rate', 'Average Error Rate', 'Min Error Rate');
xlabel('Max Number of Discriminants');
ylabel('Error Rate');

figure;
scatter([1 2 3 4 5], std(error_rates), 'fill');
title('Std Dev of Error Rate vs Max Number of Discriminants');
xlabel('J - Max Number of Discriminants');
ylabel('Std Dev of Error Rate');
