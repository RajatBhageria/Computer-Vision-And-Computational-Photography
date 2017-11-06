% File Name: cumMinEngVer.m
% Author: Rajat Bhageria 
% Date: Oct 30 2017 

function [Mx, Tbx] = cumMinEngVer(e)
% Input:
%   e is the energy map

% Output:
%   Mx is the cumulative minimum energy map along vertical direction.
%   Tbx is the backtrack table along vertical direction.

% Write Your Code Here

[n,m] = size(e);

Mx = zeros(n,m);
Tbx = zeros(n,m);

%% Set first row of Mx to first row of e
Mx(1,:) = e(1,:);
Tbx(1,:) = zeros(1,m);

%% Fill Mx, the value matrix, row by row 
for row = 2:n
    for col = 1:m
        %find the value for item row,col in Mx 
        
        %set the values of the 3 pixels above to be very high 
        aboveLeft = 10000; 
        above = 10000;
        aboveRight = 10000;
        
        % find the Values of the pixel to upper left of current pixel
        if (row-1 > 0 && col-1>0)
            aboveLeft = Mx(row-1,col-1);
        end
        
        % find the Values of the pixel to upper right of current pixel
        if (row-1 > 0)
            above = Mx(row-1,col);
        end
        
        % find the Values of the pixel right above the of current pixel
        if (row-1 > 0 && col+1<=m)
            aboveRight = Mx(row-1,col+1);
        end 
        
        % find the minimum of the three values above in Mx 
        lowest = min([aboveLeft;above;aboveRight]);
        currentEnergy = e(row,col); 
        
        % Set the current value matrix item to current energy + the value
        % to get there 
        Mx(row,col) = lowest + currentEnergy;
        
        % Set Tbx 
        if (lowest == above)
            Tbx(row,col) = 0;
        elseif (lowest == aboveLeft)
            Tbx(row,col) = -1;
        elseif (lowest == aboveRight) 
            Tbx(row,col) = 1;
        end 
           
    end 
end 

end