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
 
 