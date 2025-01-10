clear;clc;

image_name = ".\figures\sierp_order8.png";
box_length = 500;
image = imread(image_name);






[matrix_count, total_boxes] = box_counting(image, box_length);
%%
k = 5; % 1/2^(k+1);
cell_box_information = cell(k,3);

for dec = 1:k
    
end








                       
a = 0; b=1;
[n1,m1,~] = size(image);
n0 = 0; m0=1;
real_box_length = @(x)  (n1-n0)/(b-a)*(x-a) + a;
real_box_length(1/2)





