MU1 = [5 10];
SIGMA1 = [8 0; 0 4];
MU2 = [10 15];
SIGMA2 = [8 0; 0 4]; 

R1 = chol(SIGMA1);
R2= chol(SIGMA2);


z=[repmat(MU1,200,1) + randn(200,2)*R1,repmat(MU2,200,1) + randn(200,2)*R2];

z1 = repmat(MU1,200,1) + randn(200,2)*R1;
z2 = repmat(MU2,200,1) + randn(200,2)*R2;


figure
scatter(z1(:,1),z1(:,2),10);
hold
scatter(z2(:,1),z2(:,2),10);
