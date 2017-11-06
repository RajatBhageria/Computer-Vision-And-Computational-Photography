% File Name: carv.m
% Author: Rajat Bhageria 
% Date: Oct 30 2017 

function [Ic, T] = carv(I, nr, nc)
TI = cell(nr + 1, nc + 1); 
T = zeros(nr + 1, nc + 1); 
order = zeros(nr+1,nc+1); 

% instantiate TI(1,1) with the original image 
TI{1,1} = I;

%instantiate cost of 1,1 as 0. Not necessary but for clarity. 
T(1,1) = 0;

%Initialize the first row and the first column 
%this one is only vertical seams and no horizontal 
for row = 2: nr+1 %start at i=2 since T(1,1) = 0. 
    newImg = TI{row-1,1};
    e = genEngMap(newImg);
    [Mx, Tbx] = cumMinEngVer(e);
    [Ix, E_vert] = rmVerSeam(newImg, Mx, Tbx);
    TI{row,1}  = Ix; 
    T(row,1) = T(row-1,1) + E_vert;  
    order(row,1) = 1; %vertical is 1 
end 

%initialize the first row with only horz seams 
for col = 2: nc+1 %start at i=2 since T(1,1) = 0. 
    newImg = TI{1,col-1};
    e = genEngMap(newImg);
    [My, Tby] = cumMinEngHor(e);
    [Iy, E_horz] = rmHorSeam(newImg, My, Tby);
    TI{1, col} = Iy; 
    T(1, col) = T(1, col-1) + E_horz; 
    order(1,col) = 0; 
end

%loop over all the internal elements in T outside the first row and 
% the first column 
for row = 2: nr+1
    for col = 2: nc +1 
        
        %find the prev vert and horz cost 
        I_vert = TI{row-1,col}; 
        I_horz = TI{row,col-1};
        
        %instantiate all the energy maps 
        eVer = genEngMap(I_vert);
        eHor = genEngMap(I_horz);
        
        % Get the value map, Mx and My
        [Mx, Tbx] = cumMinEngVer(eVer);
        [My, Tby] = cumMinEngHor(eHor);

        %Get the new image and the costs associated with each seam
        [Ix, E_vert] = rmVerSeam(I_vert, Mx, Tbx);
        [Iy, E_horz] = rmHorSeam(I_horz, My, Tby);
            
        %find the costs of horz and vert seams 
        vertCost = E_vert + T(row-1, col); 
        horzCost = E_horz + T(row,col-1);
        
        %find min and assign to TI(row,col) and T(row, col) 
        vertLess = vertCost < horzCost; 
        
        %check if the vertical cost < horz cost
        if (vertLess) 
            disp vertLess! 
            T(row, col) = vertCost; 
            TI{row,col} = Ix; 
            
            %set the order of 1s and 0s to make video 
            order(row,col) = 1;
            
        %check if the horz cost < vert cost
        else
            disp horzLess! 
            T(row,col) = horzCost; 
            TI{row,col} = Iy;
            
            %set the order of 1s and 0s to make video 
            order(row,col) = 0;
        end
    end 
end 

%return the final image 
Ic = TI{nr+1,nc+1}; 

%create the video and return 
createVideo(I, TI, order); 

end 