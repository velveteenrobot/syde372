clear all;
close all;

MU1 = [5 10];
SIGMA1 = [8 0; 0 4];
MU2 = [10 15];
SIGMA2 = [8 0; 0 4];

R1 = chol(SIGMA1);
R2= chol(SIGMA2);

X1 = repmat(MU1,200,1) + randn(200,2)*R1;
X2 = repmat(MU2,200,1) + randn(200,2)*R2;

SIGMA1 = cov(X1);
SIGMA2 = cov(X2);

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

map_1 = MAP([MU1; MU2], range1, range2, cat(3,SIGMA1,SIGMA2), [0.5 0.5]);
contour(range1, range2, map_1', [1 1], '--r');
hold on;

case1_classes = {X1, X2};
confusion = zeros(size(case1_classes, 2));

for i=1:size(case1_classes, 2)
    current_class = cell2mat(case1_classes(i));
    for j=1:size(current_class, 1)

       predicted = MAP([MU1; MU2], current_class(j,1), current_class(j,2), cat(3, SIGMA1, SIGMA2), [0.5 0.5]);
   
       confusion(i,predicted) = confusion(i,predicted) + 1;
    end
end 

confusion

error = (sum(confusion(:)) - trace(confusion)) / sum(confusion(:))