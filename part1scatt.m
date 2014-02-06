MU1 = [5 10];
SIGMA1 = [8 0; 0 4];
MU2 = [10 15];
SIGMA2 = [8 0; 0 4];
X = [mvnrnd(MU1,SIGMA1,200);
mvnrnd(MU2,SIGMA2,200)];
figure
scatter(X(:,1),X(:,2),10);
options = statset('Display','final');
obj = gmdistribution.fit(X,2,'Options',options);
hold on
h = ezcontour(@(x,y)pdf(obj,[x y]),[0 25],[0 25]);
hold off