MU3 = [5 10];
SIGMA3 = [8 4; 4 40];
MU4 = [15 10];
SIGMA4 = [8 0; 0 8];
MU5 = [10 5];
SIGMA5 = [10 -5; -5 20];
X = [mvnrnd(MU3,SIGMA3,100);mvnrnd(MU4,SIGMA4,200); mvnrnd(MU5,SIGMA5,150)];
figure;
scatter(X(:,1),X(:,2),10);
options = statset('Display','final');
obj = gmdistribution.fit(X,2,'Options',options);
hold on
h = ezcontour(@(x,y)pdf(obj,[x y]),[-10 25],[-10 25]);
hold off