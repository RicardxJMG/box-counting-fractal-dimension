function varargout = minkowski_dimension(image_input,divider_factor,varargin)
    % Description:
    % This function estimates the fractal dimension of a 2D image, specifically curves in \R^2, also known as 'Minkowski dimension',
    % using the 'box counting dimension' algorithm. 
    %
    % --------------------------------------------------------------------------------
    % Input:
    % -  image_input: A tridimensional matrix which represent a rgb image format.
    % -  divider_factor: Division factor that determines the length reduction of the box length.
    %    By default, it is equal to 2.
    % -  Optional parameters:
    %       - 'plot_fit': Generates the log-log fit plot.
    %       - 'save_plot': Saves the log-log fit plot in PNG and PDF format (independent of 'plot_fit').
    %       - 'name_figure': Saves the log-log fit plot with a specific name.  
    %       - 'create_gif': Generates a GIF animation of the squares.  
    %       - 'gif_name': Name of the GIF animation (requires 'create_gif').  
    % --------------------------------------------------------------------------------
    % Output:
    % -  varargout{1}: The estimated fractal dimension.
    % -  varargout{2}: Information about each iteration of the counting process, stored in a cell array.
    %                  The cell contains: [iteration number, counting boxes, box length, matrix count, image of boxes]
    % --------------------------------------------------------------------------------
    % Observation: 
    % - First, read the observation section of the 'box_counting' function.
    % - If you uncomment that code, also uncomment line 62.


if nargin < 1 || length(size(image_input)) < 3
    error("Requieres at least the image input")
end

if nargin <2 || isempty(divider_factor)
    % Default divider
    divider_factor =2;
end

if length(size(image_input)) < 3
    image_input = cat(3, image_input,image_input,image_input);
end

[x_pixels, y_pixels, ~] = size(image_input);

if x_pixels < 2^6 || y_pixels < 2^6
    error("The image is too small")
end

if divider_factor <= 1
    error("The divisor is less or equal to 1")
end

box_data = {};
k = 1;
box_length = min(x_pixels,y_pixels);
prev_count = [];
tmp_total_boxes = 0;


while box_length > 2
    [matrix_count, total_boxes] = box_counting(image_input, box_length,prev_count);
    %if total_boxes>tmp_total_boxes
        box_data{k,1} = k;
        box_data{k,2} = total_boxes;
        box_data{k,3} = box_length;
        box_data{k,4} = matrix_count;
        box_data{k,5} = draw_boxes(image_input, box_length);
    %end

    % uncomment if you image size is power of two
    % prev_count = matrix_count;
    box_length = floor(box_length/divider_factor);
    k = k+1;
end

% Getting a list of counting boxes greater than 1
N = cell2mat(box_data(2:end,2));
% Getting a list of boxes length lesser than length pixels
delta = cell2mat(box_data(2:end,3));
% The fractal dimension is estimated as the slope of the graph of log() and
logN = log(N);
logdelta = log(1./delta);

d = polyfit(logdelta,logN, 1);
f = polyval(d, logdelta);

fd = f(1);

varargout{1} = fd; % Fractal dimension estimate
varargout{2} = box_data; % information of every iteration

plot_fit = false;
save_plot = false;
name_figure_value = '';
create_gif = false;
gif_name_value = '';


if nargin > 2
    parameter =1;
    
    while parameter <= length(varargin)
        parameter_name = varargin{parameter};
        
        switch lower(parameter_name)
            case 'plot_fit'
                plot_fit = true;
            case 'save_plot'
                save_plot = true;
            case 'create_gif'
                create_gif = true;
            case 'gif_name'
                gif_name_value = varargin{parameter+1};
                parameter = parameter+1;
            case 'name_figure'
                %name_figure = true;
                name_figure_value = varargin{parameter+1};
                parameter = parameter+1;
            otherwise
                error("Parameter " + parameter_name + " unknown.")
        end
        parameter = parameter +1;
    end
    
    if plot_fit || save_plot
        visible_plot = 'off';
        current_folder = pwd;
        folder_name = "fractal_algorithm_images";
        
        if plot_fit
            visible_plot = 'on';
        end
        
        fig = figure('Visible', visible_plot); hold on,
        plt2 = plot(logdelta, f, '--', 'LineWidth', 1.25, 'Color', [0.047 0 0.671]);
        plt1 = plot(logdelta, logN, 'd', 'MarkerSize', 8, 'MarkerEdgeColor', [1 0.69 0], ...
            'MarkerFaceColor', [1 0.918 0.675], 'LineWidth', 1.05);
        
        legend([plt1, plt2], {'Estimated', 'Line Fit'}, 'Interpreter', 'latex', ...
            'Location', 'northwest', 'FontSize', 10, 'Box', 'off');
        grid on;
        set(gca, 'GridAlpha', 0.1, 'FontSize', 10, 'FontName', 'Times');
        set(fig, 'Color', 'w');
        set(gca, 'LineWidth', 1);
        
        xticks(linspace(floor(min(logdelta)), ceil(max(logdelta)), 5)); % 5 valores en eje X
        yticks(linspace( floor(min(logN)), ceil(max(logN)), 5));
        
        xlabel('$\log(1/\delta)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontName', 'Times');
        ylabel('$\log (N_\delta)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontName', 'Times');
        
        if save_plot
            path_save = current_folder + "\" + folder_name;
            if isempty(name_figure_value)
                name_figure_value = "fit-curve-plot";
            end
            if ~exist(path_save, 'dir')
                mkdir(path_save)
            end
            saveas(fig,path_save + "\" + name_figure_value + ".png")
            saveas(fig,path_save + "\" + name_figure_value + ".pdf")
        end
        hold off
    end
    
    if create_gif
        current_folder = pwd;
        folder_name = "fractal_algorithm_images";
        path_save = current_folder + "\" + folder_name;
        loop_count = inf;
        delay_time = 1.25 - (2-divider_factor);
        
        for i = 1:length(box_data)
            fig = figure("Visible", "off");
            current_image = box_data{i,5};
            imshow(current_image,"Interpolation",'nearest');
            frame = getframe(gcf);
            img = frame2im(frame);
            [imind, cm] = rgb2ind(img, 256); 
            
            if i == 1
                if ~exist(path_save, 'dir')
                    mkdir(path_save)
                end
                if isempty(gif_name_value)
                    gif_name_value = "box_gif.gif";
                end
                filename = path_save + "\" + gif_name_value + ".gif";
                imwrite(imind, cm, filename, 'gif', 'LoopCount', loop_count, 'DelayTime', delay_time);
            else
                
                imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', delay_time);
            end
        end
        hold off, close(fig)
    end
end

end