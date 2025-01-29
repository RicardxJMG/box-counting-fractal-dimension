function varargout = minkowski_dimension(image_input, varargin)

    if nargin < 1
        error("Requieres at least the image input")
    end

    if length(size(image_input)) < 3
        image_input = cat(3, image_input,image_input,image_input);
    end

    [x_pixels, y_pixels, ~] = size(image_input);

    if x_pixels < 2^6 || y_pixels < 2^6
        error("The image is too small") 
    end

    cell_box_information = {};
    k = 1;   
    box_length = max(x_pixels,y_pixels); 
    prev_count = [];

    while box_length > 1
        [matrix_count, total_boxes] = box_counting(image_input, box_length,prev_count);
        cell_box_information{k,1} = k; 
        cell_box_information{k,2} = total_boxes;
        cell_box_information{k,3} = box_length;
        cell_box_information{k,4} = matrix_count;
        cell_box_information{k,5} = draw_mesh(image_input, box_length);
        
        % uncomment when the optimization is completed
        % prev_count = matrix_count; 
        box_length = ceil(box_length/2);  
        k = k+1;
    end
    
    % Getting a list of counting boxes greater than 1
    N = cell2mat(cell_box_information(2:end,2));
    % Getting a list of boxes length lesser than length pixels
    delta = cell2mat(cell_box_information(2:end,3));
    % The fractal dimension is estimated as the slope of the graph of log() and  
    logN = log(N);
    logdelta = log(1./delta); 
    
    d = polyfit(logdelta,logN, 1);
    f = polyval(d, logdelta);
    
    fd = f(1);

    varargout{1} = fd; % Fractal dimension estimate
    varargout{2} = cell_box_information; % information of every iteration
    
    plot_fit = false;
    save_plot = false;
    create_gif = false;
    name_figure_value = '';

    if nargin > 1
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
        end

        if create_gif
            for 1:length
        end

    end

    
end

