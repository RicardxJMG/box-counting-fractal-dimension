function [image,mesh] = mesh_image(fig_name, box_length)
    try
        image = imread(fig_name);
    catch
        warning('Image not found.')
        image = imread("figures\sierp_order10.png");
    end

    %grey_image = im2gray(image);
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