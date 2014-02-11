MU3 = [5 10];
SIGMA3 = [8 4; 4 40];
MU4 = [15 10];
SIGMA4 = [8 0; 0 8];
MU5 = [10 5];
SIGMA5 = [10 -5; -5 20]; 

R3 = chol(SIGMA3);
R4 = chol(SIGMA4);
R5 = chol(SIGMA5);

z3 = repmat(MU3,100,1) + randn(100,2)*R3;
z4 = repmat(MU4,200,1) + randn(200,2)*R4;
z5 = repmat(MU5,150,1) + randn(150,2)*R5;


figure;
title('Clustering: Case2')
hold on;
scatter(z3(:,1),z3(:,2),10);
hold off;
hold on;
scatter(z4(:,1),z4(:,2),10);
hold off;
hold on 
scatter(z5(:,1),z5(:,2),10);
hold off;
legend('Class C', 'Class D','Class E');


