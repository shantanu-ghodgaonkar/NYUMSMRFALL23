% s12_13   Solution to Problem 12.13
% motion planning based on numerical navigation function
% on a two-dimensional occupancy gridmap

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all; close all;

%%%%%%%%%%%%%%%%
% user: choose %
%%%%%%%%%%%%%%%%

% two-dimensional occupancy gridmap: 1 = obstacle cell, 0 = free cell

M=[0 0 1 1 1 0 0; 
   1 0 1 0 0 0 0; 
   0 0 1 0 0 0 0; 
   0 0 0 0 1 0 0; 
   0 0 0 0 1 0 0;
   0 0 1 0 1 0 0;
   0 0 1 0 1 0 0]; 

% start and goal cells  

start_cell=[1 1];
goal_cell=[7 7];

% choose 1-adjacency or 2-adjacency

%adjacency_mask={[1 0] [0 1] [-1 0] [0 -1]}; % use this for 1-adjacency
adjacency_mask={[1 0] [1 1] [0 1] [-1 1] [-1 0] [-1 -1] [0 -1] [1 -1]}; % use this for 2-adjacency

%%%%%%%%%%%%%%%
% computation %
%%%%%%%%%%%%%%%

[n,m]=size(M); 
adjacency_mask_size=length(adjacency_mask);

% check if start and goal are admissible 

cell=start_cell;
if cell(1)<1 | cell(2)<1 | cell(1)>n | cell(2)>m | (M(cell(1),cell(2))==1) 
    error('start cell is outside map or is an obstacle');
end
cell=goal_cell;
if cell(1)<1 | cell(2)<1 | cell(1)>n | cell(2)>m | (M(cell(1),cell(2))==1) 
    error('goal cell is outside  map or is an obstacle');
end

% allocate the matrix U representing the navigation function
% U has the same size of M and is initialized 
% at 0 at the goal cell and at infinity elsewhere

U=inf*ones(n,m); 
U(goal_cell(1),goal_cell(2))=0; 

% initialize FIFO queue for wavefront expansion

queue=goal_cell;
size_queue=1; 

% build navigation function loop: wavefront expansion

while size_queue~=0 % while the queue is not empty
    % pop first element from the queue 
    if (size_queue>1)
        current_cell=queue(1,:);      % extract first element
        queue=queue(2:size_queue,:);  % delete first element
    else
        current_cell=queue(1,:);      % extract first element 
        queue=[];                     % delete first element
    end

    % update navigation function for neighbouring cells
    for i=1:adjacency_mask_size
        
        current_neighbour_cell=current_cell+adjacency_mask{i}; % pick current neighbour cell
        
        if ~(current_neighbour_cell(1)<1 | current_neighbour_cell(2)<1 | ...
          current_neighbour_cell(1)>n | current_neighbour_cell(2)>m) % if current neighbour cell is inside the map 
            if (M(current_neighbour_cell(1),current_neighbour_cell(2))~=1) % and if it is not an obstacle cell
                
                % compute candidate new value of U for the current neighbour cell
                % the Euclidean distance is chosen as cost-to-go between cells
                new_U_value=U(current_cell(1),current_cell(2))+norm(current_cell-current_neighbour_cell,2); 
               
                if new_U_value<U(current_neighbour_cell(1),current_neighbour_cell(2))   % if new U < current U
                    U(current_neighbour_cell(1),current_neighbour_cell(2))=new_U_value; % update U          
                    queue=[queue;current_neighbour_cell];     % push current neighbour cell in the queue

                end
            end
        end
        
    end
    
    % compute current queue length
    [size_queue,columns]=size(queue);
    
end

% now compute shortest path following steepest descent from goal_cell

path =[start_cell U(start_cell(1),start_cell(2))]; % the path is built in the form of a list of elements (cell,value)
current_cell=start_cell; % start from goal_cell

if U(start_cell(1),start_cell(2))==inf % the wavefront expansion could not reach the start cell
    display('Warning: no solution path exists; start and goal belong to disjoint components of Cfree');
else
    while norm(current_cell-goal_cell,2)~=0 % while goal cell is not reached

        %initialize local minimum U_value
        minimum_U_value=U(current_cell(1),current_cell(2));

        % find current neighbour cell with minimum U
        for i=1:adjacency_mask_size

            current_neighbour_cell=current_cell+adjacency_mask{i};  % pick current neighbour cell

             if ~(current_neighbour_cell(1)<1 | current_neighbour_cell(2)<1 |...
              current_neighbour_cell(1)>n | current_neighbour_cell(2)>m) % if current neighbour cell is inside the map 
                if (M(current_neighbour_cell(1),current_neighbour_cell(2))~=1) % and if it is not an obstacle cell

                    if minimum_U_value>U(current_neighbour_cell(1),current_neighbour_cell(2))
                        minimum_U_value=U(current_neighbour_cell(1),current_neighbour_cell(2)); % update minimum value
                        next_cell=current_neighbour_cell;
                    end
                end
            end

        end

        current_cell=next_cell;
        path=[path ; [next_cell U(next_cell(1),next_cell(2))] ];
    end
end

% plot the navigation function and the computed path %

figure(2); set(gca,'fontname','Times','fontsize',12,'fontweight','normal');box on;
hold on; axis equal; title('navigation function and solution path');xlabel('row');ylabel('column');
maxWindow;

h=bar3(M',1); colormap([1 1 1;0 0 0]);
set(gca,'XTick',1:n);set(gca,'YTick',1:m); 
axis([0 n+1 0 m+1 0 1])

for i = 1:length(h)
    zdata = get(h(i),'Zdata');
    set(h(i),'Cdata',zdata)
    set(h,'EdgeColor','k')
end

epsilon=0.2; %graphical offset 
for i=1:n
    for j=1:m
        if (U(i,j)<inf)
            string = num2str(U(i,j),4);
            % plot text
            h=text(i,j,epsilon,string,'fontname','Times','fontsize',12,'fontweight','normal','edgecolor','b');
            a = get(h,'extent'); % a = [left bottom width height] 
            %delete text
            delete(h);
            % replot text centered in a cell
            h=text(i,j-a(3)/2,epsilon,string,'fontname','Times','fontsize',12,'fontweight','normal');
        end
    end
end

line(path(:,1),path(:,2),0*path(:,3)+epsilon,'Color','k')
view(90,90)
