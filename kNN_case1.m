clear all;
close all;

MU1 = [5 10];
SIGMA1 = [8 0; 0 4];
MU2 = [10 15];
SIGMA2 = [8 0; 0 4];
X1 = mvnrnd(MU1,SIGMA1,200);
X2 = mvnrnd(MU2,SIGMA2,200);

SIGMA1 = cov(X1);
SIGMA2 = cov(X2);

range1 = [-5:0.1:20]
range2 = [0:0.1:20]

figure;
title('kth Nearest Neighbour: Case 1');
hold on;

scatter(X1(:,1), X1(:,2), 10, 'b');
scatter(X2(:,1), X2(:,2), 10, 'r');

[a_vectors, a_values] = eigs(SIGMA1)
[b_vectors, b_values] = eigs(SIGMA2)

kNN_1 = kNN_FS(range1, range2, 1, X1, X2);
kNN_5 = kNN_FS(range1, range2, 5, X1, X2);
contour(range1, range2, kNN_1', [1 1], 'r');
contour(range1, range2, kNN_5', [1 1], 'b');
hold on;
legend('Class A', 'Class B', 'k = 1', 'k = 5');

a_theta = atan2(a_vectors(2,1), a_vectors(1,1));
plot_ellipse(MU1(1), MU1(2), a_theta, sqrt(a_values(1,1)), sqrt(a_values(2,2)));

b_theta = atan2(b_vectors(2,1), b_vectors(1,1));
plot_ellipse(MU2(1), MU2(2), b_theta, sqrt(b_values(1,1)),sqrt(b_values(2,2)));

case1_classes = {X1, X2};
confusion_1 = zeros(size(case1_classes, 2));
confusion_2 = zeros(size(case1_classes, 2));

for i=1:size(case1_classes, 2)
    current_class = cell2mat(case1_classes(i));
    for j=1:size(current_class, 1)

       predicted_1 = kNN_FS(current_class(j,1), current_class(j,2), 1, X1, X2);
       predicted_2 = kNN_FS(current_class(j,1), current_class(j,2), 5, X1, X2);
       confusion_1(i,predicted_1) = confusion_1(i,predicted_1) + 1;
       confusion_2(i,predicted_2) = confusion_2(i,predicted_2) + 1;
    end
end 

confusion_1
confusion_2

error_1 = (sum(confusion_1(:)) - trace(confusion_1)) / sum(confusion_1(:))
error_2 = (sum(confusion_2(:)) - trace(confusion_2)) / sum(confusion_2(:))