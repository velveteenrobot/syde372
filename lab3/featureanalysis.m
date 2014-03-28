clear;
clc;
load feat.mat;
class2 = Confusion.convertFeatureToClass(f2); % create classes for the n=2 data;
class8 = Confusion.convertFeatureToClass(f8); % create classes for the n=8 data;
class32 = Confusion.convertFeatureToClass(f32); % create classes for the n=32 data;

figure;


for i=1:length(class2)
	plotClassOnFigure(class2(i));
    
end
title('Scatter plot with n=2');

figure;

[xVals, yVals, testPts, cont] = Confusion.createMatrix(1, class8(1));

for i=1:length(class8)
	plotClassOnFigure(class8(i));
end
title('Scatter plot with n=8');

figure;


for i=1:length(class32)
	plotClassOnFigure(class32(i));
end
title('Scatter plot with n=32');

confusionMatrix2 = Confusion.outputConfusion(class2, f2t)
confusionMatrix8 = Confusion.outputConfusion(class8, f8t)
confusionMatrix32 = Confusion.outputConfusion(class32, f32t)