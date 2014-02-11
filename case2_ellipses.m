clear all;
close all;

MU1 = [5 10];
SIGMA1 = [8 4; 4 40];
MU2 = [15 10];
SIGMA2 = [8 0; 0 8];
MU3 = [10 5];
SIGMA3 = [10 -5; -5 20];
% X1 = mvnrnd(MU1,SIGMA1,200);
% X2 = mvnrnd(MU2,SIGMA2,200);
% X3 = mvnrnd(MU3, SIGMA3, 200);

R3 = chol(SIGMA1);
R4 = chol(SIGMA2);
R5 = chol(SIGMA3);

X1 = repmat(MU1,100,1) + randn(100,2)*R3;
X2 = repmat(MU2,200,1) + randn(200,2)*R4;
X3 = repmat(MU3,150,1) + randn(150,2)*R5;

SIGMA1 = cov(X1);
SIGMA2 = cov(X2);
SIGMA3 = cov(X3)

figure;
title('Clustering: Case 2');
hold on;

scatter(X1(:,1), X1(:,2), 10, 'b');
scatter(X2(:,1), X2(:,2), 10, 'r');
scatter(X3(:,1), X3(:,2), 10, 'g');

legend('Class C', 'Class D', 'Class E');

[c_vectors, c_values] = eigs(SIGMA1);
[d_vectors, d_values] = eigs(SIGMA2);
[e_vectors, e_values] = eigs(SIGMA3);

c_theta = atan2(c_vectors(2,1), c_vectors(1,1));
plot_ellipse(MU1(1), MU1(2), c_theta, sqrt(c_values(1,1)), sqrt(c_values(2,2)));

d_theta = atan2(d_vectors(2,1), d_vectors(1,1));
plot_ellipse(MU2(1), MU2(2), d_theta, sqrt(d_values(1,1)),sqrt(d_values(2,2)));

e_theta = atan2(e_vectors(2,1), e_vectors(1,1));
plot_ellipse(MU3(1), MU3(2), e_theta, sqrt(e_values(1,1)),sqrt(e_values(2,2)));
