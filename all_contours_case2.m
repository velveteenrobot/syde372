clear all;
close all;

MU1 = [5 10];
SIGMA1 = [8 4; 4 40];
MU2 = [15 10];
SIGMA2 = [8 0; 0 8];
MU3 = [10 5];
SIGMA3 = [10 -5; -5 20];
X1 = mvnrnd(MU1,SIGMA1,200);
X2 = mvnrnd(MU2,SIGMA2,200);
X3 = mvnrnd(MU3, SIGMA3, 200);

SIGMA1 = cov(X1);
SIGMA2 = cov(X2);
SIGMA3 = cov(X3);

range1 = [-5:0.1:20]
range2 = [-5:0.1:20]

figure;
hold on;

scatter(X1(:,1), X1(:,2), 10, 'b');
scatter(X2(:,1), X2(:,2), 10, 'r');
scatter(X3(:,1), X3(:,2), 10, 'g');

[c_vectors, c_values] = eigs(SIGMA1);
[d_vectors, d_values] = eigs(SIGMA2);
[e_vectors, e_values] = eigs(SIGMA3);

c_theta = atan2(c_vectors(2,1), c_vectors(1,1));
plot_ellipse(MU1(1), MU1(2), c_theta, sqrt(c_values(1,1)), sqrt(c_values(2,2)));

d_theta = atan2(d_vectors(2,1), d_vectors(1,1));
plot_ellipse(MU2(1), MU2(2), d_theta, sqrt(d_values(1,1)),sqrt(d_values(2,2)));

e_theta = atan2(e_vectors(2,1), e_vectors(1,1));
plot_ellipse(MU3(1), MU3(2), e_theta, sqrt(e_values(1,1)),sqrt(e_values(2,2)));

map_1 = MAP([MU1; MU2; MU3], range1, range2, cat(3, SIGMA1, SIGMA2, SIGMA3), [2/9 4/9 1/3]);
contour(range1, range2, map_1', 2, '--r');
hold on;
micd_1 = MICD([MU1; MU2; MU3], range1, range2, cat(3, SIGMA1, SIGMA2, SIGMA3));
contour(range1, range2, micd_1', 2, '--b');
hold on;
med_1 = MED([MU1; MU2; MU3], range1, range2);
contour(range1, range2, med_1', 2, '--g');
hold on;