function [matrix_count, total_boxes] = box_counting(image, box_length, previous_count)
    % Description:
    % This function evaluates the number of boxes from a mesh of length 'box_length' that intersect with a non-white 
    % pixel in the image. The optimization of this code, unfortunately, did not work for images of size = [n,m,~],
    % where n and m are not necessarily  power of 2. 
    % 
    % --------------------------------------------------------------------------------
    % Input:
    % -  image: A three-dimensional matrix representing an rgb image.
    % -  box_length: A positive integer number, indicating the length of each box. 
    % -  previous_count: A binary matrix representing a previous count. In particular, represent the "position"
    %                    where the box intersects the image.
    % 
    % --------------------------------------------------------------------------------
    % Output:
    % -  matrix_count: A binary matriz where 1 represents a box intersecting the image, otherwise 0. 
    % -  total_boxes: The sum of all values of 'matrix_count'.
    %
    % --------------------------------------------------------------------------------
    % Observation: 
    % - If you are working with images of size = [2^p,2^q,~] you can safely uncomment the 'else' part 
    %   of this code. It is important to read the minkowski_dimension function if you did this.
    
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

        % THIS OPTIMIZATION REQUIEREs NON EMPTY PREVIOUS COUNT
        % else     
%         % indexes of non zero values; both arrays must have same length
%         [rows, cols] = find(previous_count);
%         
%         for prev_index = 1:length(rows)
%             % index for the box of previous iteration
%             i_prev = rows(prev_index);
%             j_prev = cols(prev_index);
% 
%             % suppose four sub-boxes inside in the previous box
%             i_new = 2*(i_prev-1);
%             j_new = 2*(j_prev-1);
%             boxes_indexes = [
%                 i_new+1, j_new+1; % top left box
%                 i_new+1, j_new+2; % top right box
%                 i_new+2, j_new+1; % bottom left box
%                 i_new+2, j_new+2 % bottom right box
%             ];
%             %fprintf("Previous index: (%d,%d)\n", [i_prev, j_prev])
%             for i = 1:length(boxes_indexes)
%                 x_current_index = boxes_indexes(i,1);
%                 y_current_index = boxes_indexes(i,2);
%                 
%                 %fprintf("\n\t-> index: (%d,%d)\n", [x_current_index, y_current_index])
%                 if x_current_index <= x_total_boxes && y_current_index <= y_total_boxes
%                     box_length_start = (x_current_index-1)*box_length + 1;
%                     box_length_end = min(x_current_index*box_length, n);
%                     box_height_star = (y_current_index-1)*box_length +1;
%                     box_height_end = min(y_current_index*box_length,m);
%             
%                     tmp_image = negative_image(box_length_start:box_length_end, box_height_star:box_height_end,:);
%                     non_white = nnz(tmp_image)>0;
% %                     % str_img = "box ("+ num2str(x_current_index) + "," + num2str(y_current_index) + ")  Is empty = " + num2str(non_white);
% %                     % figure("Name",str_img), imshow(tmp_image)
% %                     % pause(0.2)
%                     non_white_box(x_current_index, y_current_index) = non_white_box(x_current_index, y_current_index) || non_white;
%                 end   
%             end
%         end 
    end


    matrix_count = non_white_box;
    total_boxes = sum(matrix_count(:));

end