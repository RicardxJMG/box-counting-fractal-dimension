function mesh = draw_mesh(image, box_length)

    [n,m,p] = size(image);
    mesh = image;
    for i = 1:box_length:n
        for j = 1:m
            if sum(image(i,j,:)) == 765
                mesh(i,j,1) = 0;
                mesh(i,j,2) = 255;
                mesh(i,j,3) = 0;
            else
                mesh(i,j,1) = 0;
                mesh(i,j,2) = 125;
                mesh(i,j,3) = 0;
            end
        end
    end 
    
    for i = 1:n
        for j = 1:box_length:m
            if sum(image(i,j,:)) == 765
                mesh(i,j,1) = 0;
                mesh(i,j,2) = 255;
                mesh(i,j,3) = 0;
            else
                mesh(i,j,1) = 0;
                mesh(i,j,2) = 125;
                mesh(i,j,3) = 0;
            end
        end
    end

end