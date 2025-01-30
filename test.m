clear;clc;
fractal_name = "dragon";
image_name = ".\figures\" + fractal_name + ".jpg";
image_ = imread(image_name);
close all
imshow(image_)
%% 
[dimension,information] = minkowski_dimension(image_,2,'save_plot','name_figure',fractal_name + "_fitline");

%%
close all
minkowski_dimension(image_,1.25,'create_gif', 'gif_name', fractal_name + "gif");

%% 

% sierpinski = 1.6280 with divisor equal to 2
% dragon = 1.8356 with divisor 2
% koch = 1.30 with divisor 1.25
% Triflake 1.4257 with divisor 2



