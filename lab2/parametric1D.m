% load data
data = load('lab2_1.mat');
xa = data.a;
xb = data.b;

% get min/max vals, create x axes
min1 = min(xa);
max1 = max(xa);
min2 = min(xb);
max2 = max(xb);

x1 = linspace(min1,max1);   % gaussain x vals
x2 = linspace(min2, max2);   % exp x vals
%% gaussian estimation

% a
temp1 = mle(xa);
y1actual = normpdf(x1, 5, 1);
y1estimate = normpdf(x1, 5.0763, 1.0618);

% b
temp2 = mle(xb);
y2actual = pdf('exp', x2, 1);
y2estimate = normpdf(x2, 0.9633, 0.9297);

% plots
figure
plot(x1, y1actual, x1, y1estimate)
title('Gaussian modelling of Gaussian distribution');
legend('actual normal dist.','estimated normal dist.')

figure
plot(x2, y2actual, x2, y2estimate)
title('Gaussian modelling of exponential distribution');
legend('actual exponential dist', 'estimated normal dist')

%% exponential estimation

% a
temp1 = mle(xa, 'distribution', 'exp');
y1actual = normpdf(x1, 5, 1);
y1estimate = pdf('exp', x1, 5.0763);

% b
temp2 = mle(xb, 'distribution', 'exp');
y2actual = pdf('exp', x2, 1);
y2estimate = pdf('exp', x2, 0.9633);

% plots
figure
plot(x1, y1actual, x1, y1estimate)
title('Exponential modelling of Gaussian distribution');
legend('actual normal dist.','estimated exp dist.')

figure
plot(x2, y2actual, x2, y2estimate)
title('Exponential modelling of exponential distribution');
legend('actual exp dist.','estimated exp dist.')

%% uniform estimation

% a
temp1 = mle(xa, 'distribution', 'unif');
y1actual = normpdf(x1, 5, 1);
y1estimate = pdf('unif', x1, 2.7406, 8.3079);

% b
temp2 = mle(xb, 'distribution', 'unif');
y2actual = pdf('exp', x2, 1);
y2estimate = pdf('unif', x2, 0.0143, 4.2802);

% plots
figure
plot(x1, y1actual, x1, y1estimate)
title('Uniform modelling of Gaussian distribution');
legend('actual normal dist.','estimated uniform dist.')

figure
plot(x2, y2actual, x2, y2estimate)
title('Uniform modelling of exponential distribution');
legend('actual exp dist.','estimated uniform dist.')


