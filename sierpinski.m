clear all; close all; 

global cell_iterations
cell_iterations = cell(12,2);

% number of iterations
order = 2;
% vertices of equilateral triangle of length 1. 
S_0 = [0 0;
    0.5 sqrt(3)/2;
    1 0];

% initialize the cell of vertices
cell_iterations{1,1} = 0;
cell_iterations{1,2} = S_0;
%%
Sierpinski(12,'')

%% plot the S_0,S_1 and S_2
figure;
axis off
axis equal
hold on

for i=8:8
    vertices_sierp_k = cell_iterations{i,2};
    for j = 1:3^(i-1)
            %x = vertices_sierp_k(:,1) + (1.2*(i-1)); 
            %y = vertices_sierp_k(:,2); uncomment for scatterplot
            x = vertices_sierp_k(3*(j-1)+1:3*j,1)'+ (1.2*(i-1));
            y = vertices_sierp_k(3*(j-1)+1:3*j,2)';
            fill(x, y,'black', 'LineStyle','none');
            % pause(1/(2*i))
            
   end
    text(1.2*(i-1)+0.45, -0.25, ['$S_{', num2str(i-1), '}$'], ...
                "Interpreter", "latex", "FontSize", 14)
end

f = gcf;
exportgraphics(f, "./figures/sierp_order" + num2str(8)+".png", Resolution=300)


hold off

%% Functions 

% The only orders allows goes to 1 to 10

function Sierpinski(order,y)
    global cell_iterations

    order_in_cell = any(cellfun(@(x) ~isempty(x) && isequal(x,order), cell_iterations(:,1)));
    
    if ~order_in_cell
    %   fprintf('\nOrden no encontrado\n')
        vertices_iteration(order)
    end

    vertices_sierp_k = cell_iterations{order+1, 2};

    if ~isempty(y)
        figure;
        axis([0 1 0 1])
        hold on
        for i = 1:3^(order)
            x = vertices_sierp_k(3*(i-1)+1:3*i,1)';
            y = vertices_sierp_k(3*(i-1)+1:3*i,2)';
            fill(x, y, 'black')   
        end
    end
end

function vertices_iteration(order)
    global cell_iterations
    tmp_cell_iterations = cell_iterations;
    % First, filter the empty elements of the cell

    numerical_column = cell2mat(cell_iterations(cellfun(@(x) ~isempty(x),cell_iterations(:,1)),1));
    min_order = max(numerical_column);

    if order > 12 
        error('Orden mayor al establecido')
        return
    end
    if order < min_order
        fprintf('\nVertices ya calculados\n')
        return
    end
        
    for m = min_order+1:order
            last_vertices = tmp_cell_iterations{m,2};
            
            % applying the ifs to the previous iteration
            new_vertex =  ifs(last_vertices(:,1), last_vertices(:,2)); 
            
            tmp_cell_iterations{m+1,1} = m;
            tmp_cell_iterations{m+1,2} = new_vertex;
    end
    cell_iterations =  tmp_cell_iterations;
end

function T = ifs(x,y) 
    A = [0.5 0; 0 0.5]; 
    coords = [x(:)'; y(:)'];

    C = A*coords; % contraction transformation
    ifs_1 = C;
    ifs_2 = C + [0.5 0]'; 
    ifs_3 = C + [0.25 sqrt(3)/4]';
    T = [ifs_1 ifs_2 ifs_3]';
end
