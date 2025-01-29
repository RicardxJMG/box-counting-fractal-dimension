clear;clc;

image_name = ".\figures\sierp_order8.png";
image_ = imread(image_name);


%% calculate fractal dimension
[dimension, information] = minkowski_dimension(image_, 'plot_fit', 'save_plot','name_figure', 'sierpinski_fd','create_gif');

%%
tst = information{4,4}
tst = cat(3,tst,tst,tst);

imshow(tst)


%%

% filename = "test_gif.gif";
% cell_box_information = cell(11,4);
% loop_count = inf;
% delay_time = 0.5;
% for k = 1:11
%     box_length = rescale(b/2^(k-1));
%     [matrix_count, total_boxes] = box_counting(image_, box_length);
%     cell_box_information{k,1} = k;
%     cell_box_information{k,2} = total_boxes;
%     cell_box_information{k,3} = box_length;
%     cell_box_information{k,4} = matrix_count;
%     
%     mesh_image_out = mesh_image(image_name, box_length);
%     
%     % Aqui inicia la creaci[on del gif
%     % Capturar el contenido de la figura como imagen
%     imshow(mesh_image_out,"Interpolation",'bilinear')
%     frame = getframe(gcf);
%     img = frame2im(frame); % Convertir el marco en imagen
%     [imind, cm] = rgb2ind(img, 256); % Convertir a formato indexado (GIF requiere 256 colores)
% 
%     % Escribir la imagen al archivo GIF
%     if k == 1
%         % Crear el archivo GIF
%         imwrite(imind, cm, filename, 'gif', 'LoopCount', loop_count, 'DelayTime', delay_time);
%     else
%         % Añadir fotogramas al archivo GIF
%          imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', delay_time);
%      end
% end
%
% 
% N = cell2mat(cell_box_information(2:end,2));
% delta = cell2mat(cell_box_information(2:end,3));
% 
% logN = log(N);
% logdelta = log(1./delta);
% 
% 
% d = polyfit(logdelta,logN, 1);
% f = polyval(d, logdelta);
% 
% 
% plot(logdelta, logN, 'o', logdelta, f, '-')

