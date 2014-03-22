mu1 = [5,10]; %data
mu2 = [10,15];
sigma = [8 0; 0 4];
x= 0:.5:25; %x
y= 0:.5:25; %y

[X1, Y1] = meshgrid(x,y);
[X2, Y2] = meshgrid(x,y);
Z1=mvnpdf([X1(:) Y1(:)],mu1,sigma);
Z2=mvnpdf([X2(:) Y2(:)],mu2,sigma);
Z1= reshape(Z1,size(X1));
Z2= reshape(Z2,size(X2));
surf(X1,Y1,Z1);
hold on;
surf(X2,Y2,Z2);