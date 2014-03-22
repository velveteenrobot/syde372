%lab2 

close all;
clear all;
load('lab2_1.mat')

[x, dist] = parzen1(a, 0.1, 0.001);

figure;
hold on;
[f,w] = hist(a,50);
dx = diff(w(1:2));
%bar(w,f/sum(f*dx));hold on
x_axis = min(w):(max(w)-min(w))/(length(dist) - 1):max(w);
normthing = normpdf(x_axis, 5, 1)
plot(x_axis, normthing)
plot(x_axis,dist)
%plot(a)



%figure;
%plot