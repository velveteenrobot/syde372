clear all;
close all;

MU1 = [5 10];
SIGMA1 = [8 0; 0 4];
MU2 = [10 15];
SIGMA2 = [8 0; 0 4];
X1 = mvnrnd(MU1,SIGMA1,200);
X2 = mvnrnd(MU2,SIGMA2,200);

range1 = [-5:0.1:20]
range2 = [-5:0.1:20]

figure;
hold on;

scatter(X1(:,1), X1(:,2), 10, 'b');
scatter(X2(:,1), X2(:,2), 10, 'r');

[a_vectors, a_values] = eigs(SIGMA1)
[b_vectors, b_values] = eigs(SIGMA2)

a_theta = atan2(a_vectors(2,1), a_vectors(1,1));
plot_ellipse(MU1(1), MU1(2), a_theta, sqrt(a_values(1,1)), sqrt(a_values(2,2)));

b_theta = atan2(b_vectors(2,1), b_vectors(1,1));
plot_ellipse(MU2(1), MU2(2), b_theta, sqrt(b_values(1,1)),sqrt(b_values(2,2)));

med_1 = MED([MU1; MU2], range1, range2);
contour(range1, range2, med_1', [1 1], '--r');
hold on;