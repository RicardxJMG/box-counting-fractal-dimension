function mesh = draw_boxes(image, box_length)
    % Description:
    % This function overlap several boxes of length 'box_length' on the image input
    % Also, the boxes only are drawing when intersect a non white space of the image. 
    % 
    % --------------------------------------------------------------------------------
    % Input:
    % -  image: A tridimensional matrix which represent a rgb image format.
    % -  box_length: A positive integer number, indicates the length of every box.
    % ........................................----------------------------------------
    % Output:
    % -  mesh: Modify image with overlapping boxes.


    [n, m, ~] = size(image);
    mesh = image;
    color_line  = [0, 102, 0];

    % Drawing horizontal lines
    for i = 1:box_length:n
        i_end_box = min(i + box_length - 1, n);
        for j_start = 1:box_length:m
            j_end = min(j_start + box_length - 1, m);
            
            box = image(i:i_end_box, j_start:j_end, :);
            is_non_white = any(box(:) ~= 255);
            
            if is_non_white              
                for r = 1:3
                    mesh(i, j_start:j_end, r) = color_line(r);
                    mesh(i_end_box, j_start:j_end,r) = color_line(r);
                end
            end
        end
    end
    
    % Drawing vertical lines
    for j = 1:box_length:m
        j_end_box = min(j + box_length - 1, m);
        for i_start = 1:box_length:n
            color = color_line;
            i_end = min(i_start + box_length - 1, n);
            
            box = image(i_start:i_end, j:j_end_box, :);
            is_non_white = any(box(:) ~= 255);
            if is_non_white
                for r =1:3
                    mesh(i_start:i_end, j, r) = color(r);
                    mesh(i_start:i_end, j_end_box,r) = color(r);
                end
            end
        end
    end
end