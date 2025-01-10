function [matrix_count, total_boxes] = box_counting(image, box_length)
    
    if length(size(image)) < 3
        image = cat(3, image, image, image);
    end
    
    [n, m, ~] = size(image);
    x_total_boxes = ceil(n/box_length);
    y_total_boxes = ceil(m/box_length);
    

    non_white_box = zeros(x_total_boxes,y_total_boxes);
   
    negative_image = abs(255-image); %transform the image in negative colors
    
    x_limits = [(1:x_total_boxes-1)*box_length,n];
    y_limits = [(1:y_total_boxes-1)*box_length, m];
    
    for i = 1:x_total_boxes
        x_box_start = (i-1)*box_length + 1;
        x_box_end = x_limits(i);
        for j = 1:y_total_boxes   
            y_box_start = (j-1)*box_length + 1;
            y_box_end = y_limits(j);
            tmp_box  = negative_image(x_box_start:x_box_end, ...
                                      y_box_start:y_box_end,:);
             
            non_white_box(i,j) = nnz(tmp_box) > 1;
        end
    end

    matrix_count = non_white_box;
    total_boxes = sum(matrix_count(:));


%     function fix_image = fix_image()
%        for left_border = 1:n
%             if sum(negative_image(i,:)>0) ~=0
%                 break
%             end
%        end
%        for right_border = n:-1:1
%             if sum(negative_image(i,:)>0) ~=0
%                 break
%             end
%        end
%        for top_border = 1:n
%             if sum(negative_image(i,:)>0) ~=0
%                 break
%             end
%        end
%        for bottom_border = n:-1:1
%             if sum(negative_image(i,:)>0) ~=0
%                 break
%             end
%        end
% 
%        negative_image = negative_image(top_border:, )
% 
%        
%         
%         
% 
%     end

end
