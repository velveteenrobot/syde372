%% generate 2xn matrix of features
load feat.mat;

data = zeros([2,160]);
data = f32(1:2, 1:end);
%% genereate prototypes, plot againts data

aplot(f32);
hold on;
prototypes = kmean(data, 10, 10000);
scatter(prototypes(1,:), prototypes(2,:), 'filled');
title('k-Means Clustering for k = 10');
legend('Estimated Class Prototypes');
hold off

%% fuzzy clustering

clear all;
close all;
load feat.mat;
c8 = Confusion.convertFeatureToClass(f8); % create classes for the n=8 data;

b = 2;
K = 10;

options = [b, 100, 1e-5, 0];
[centroids,U,obj_fn] = fcm(f32(1:2,:)',K,options);

figure;

plot(f32(1,:),f32(2,:),'ok');
maxU = max(U);

% index1 = find(U(1,:)== maxU);
% index2 = find(U(2,:)== maxU);
% index3 = find(U(3,:)== maxU);
% index4 = find(U(4,:)== maxU);
% index5 = find(U(5,:)== maxU);
% index6 = find(U(6,:)== maxU);
% index7 = find(U(7,:)== maxU);
% index8 = find(U(8,:)== maxU);
% index9 = find(U(9,:)== maxU);
% index10 = find(U(10,:)== maxU);
% 
% line(f32(1,index1),f32(2,index1),'linestyle','none',...
%      'marker','*','color','g');
% line(f32(1,index2),f32(2,index2),'linestyle','none',...
%      'marker', '*','color','r');

colors = [];
for i = 1:10
    colors = [colors; rand(1,3)];
end

colors

for i = 1 : 10
    idx = find(U(i,:)== maxU);
    line(centroids(i,1),centroids(i,2),'linestyle','none',...
     'marker','*','color',colors(i,:));
end

title('Fuzzy K-means Prototypesfor K = 10, b = 2');
 


figure;
for i = 1 : 10
    idx = find(U(i,:)== maxU);
    line(f32(1,idx),f32(2,idx),'linestyle','none',...
     'marker','*','color',colors(i,:));
end 
 
title('Fuzzy K-means for K = 10, b = 2');
