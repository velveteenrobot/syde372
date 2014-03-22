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