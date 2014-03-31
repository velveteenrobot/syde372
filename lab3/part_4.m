%From Sonnu's Stuff
clear all;
close all;
clc;
load feat.mat;
c8 = Confusion.convertFeatureToClass(f8); % create classes for the n=8 data;

figure;

ft1 = multf8(:,:,1); 
ft2 = multf8(:,:,2);

combined = [ft1(:), ft2(:)];

dim1 = length(multf8(:,1,1));
dim2 = length(multf8(1,:,1));
ctr = zeros(dim1, dim2);
x_vals = length(multf8(1,:,1));


size_class = length(c8);
dists = [];

x = 1; 
y = 1;

for i = 1: length(combined(:,1))
    for j = 1 : size_class
        dist_mean = combined(i,:) - c8(j).mean; 
        
        %Check if this math is right...

        dists = [ dists dist_mean*c8(j).invcovariance*dist_mean'];
    end
    
    [val, close_class] = min(dists);
    ctr(x,y) = close_class;
    dists = [];

    if(x == x_vals)
        x = 1;
        y = y +1;
    else
        x = x +1;
    end
end

cimage = ctr;

imagesc(cimage);

colorbar('YTickLabel',...
    {'Cloth', 'Cotton', 'Grass', 'Pigskin', 'Wood', 'Cork', 'Paper',... 
    'Stone', 'Raiffa', 'Face'});

title('Multim Image Classification');

figure;
imagesc(multim);
title('Multim Image');
colormap(gray);

%%
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
