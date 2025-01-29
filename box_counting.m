function [matrix_count, total_boxes] = box_counting(image, box_length, previous_count)
    
    [n, m, ~] = size(image);
    negative_image = abs(255-image); %transform the image in negative color
    x_total_boxes = ceil(n/box_length);
    y_total_boxes = ceil(m/box_length);
        
    non_white_box = zeros(x_total_boxes,y_total_boxes);

    if isempty(previous_count) || length(previous_count)<2

        x_limits = [(1:x_total_boxes-1)*box_length, n];
        y_limits = [(1:y_total_boxes-1)*box_length, m];
        
        for i = 1:x_total_boxes
            x_box_start = (i-1)*box_length + 1;
            x_box_end = x_limits(i);
            for j = 1:y_total_boxes
                y_box_start = (j-1)*box_length + 1;
                y_box_end = y_limits(j);
                tmp_image  = negative_image(x_box_start:x_box_end, ...
                    y_box_start:y_box_end,:);         
                non_white_box(i,j) = nnz(tmp_image) > 0;
            end
        end
        % else 
        % OPTIMIZATION WILL ADD HERE

    end


    matrix_count = non_white_box;
    total_boxes = sum(matrix_count(:));

end