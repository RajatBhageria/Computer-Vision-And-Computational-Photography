% File Name: cumMinEngHor.m
% Author: Rajat Bhageria 
% Date: Oct 30 2017 

function [My, Tby] = cumMinEngHor(e)
% Input:
%   e is the energy map.

% Output:
%   My is the cumulative minimum energy map along horizontal direction.
%   Tby is the backtrack table along horizontal direction.

% Write Your Code Here
[n,m] = size(e);

My = zeros(n,m);
Tby = zeros(n,m);

%% Set first row of My to first row of e
My(:,1) = e(:,1);

%% Fill My, the value matrix, row by row 
for col = 2:m
    for row = 1:n
        %set the values of the 3 pixels above to be very high 
        leftUp = 10000; 
        left = 10000;
        leftDown = 10000;
        
        % find the Values of the pixel to left up of current pixel
        if (col-1 > 0 && row-1>0)
            leftUp = My(row-1,col-1);
        end
        
        % find the Values of the pixel to left of current pixel
        if (col-1 > 0)
            left = My(row,col-1);
        end
        
        % find the Values of the pixel left down of current pixel
        if (col-1 > 0 && row+1<=n)
            leftDown = My(row+1,col-1);
        end 
        
        % find the minimum of the three values above in My 
        lowest = min([leftUp;left;leftDown]);
        currentEnergy = e(row,col); 
        
        % Set the current value matrix item to current energy + the value
        % to get there 
        My(row,col) = lowest + currentEnergy;
        
        % Set Tbx 
        if (lowest == left)
            Tby(row,col) = 0;
        elseif (lowest == leftDown)
            Tby(row,col) = -1;
        elseif (lowest == leftUp) 
            Tby(row,col) = 1;
        end 
           
    end 
end 

end