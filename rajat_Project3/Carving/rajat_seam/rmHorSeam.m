% File Name: rmHorSeam.m
% Author: Rajat Bhageria 
% Date: Oct 30 2017 

function [Iy, E] = rmHorSeam(I, My, Tby)
% Input:
%   I is the image. Note that I could be color or grayscale image.
%   My is the cumulative minimum energy map along horizontal direction.
%   Tby is the backtrack table along horizontal direction.

% Output:
%   Iy is the image removed one row.
%   E is the cost of seam removal

% Write Your Code Here
[n,m,p] = size(I); 

Iy = zeros(n,m,p);

E = 0; 

% find the starting point to start the vertical seam removal 
startingVal = min(My(:,m));
[rowStart,~] = find(My(:,m)==startingVal);
rowStart = rowStart(1,1);

for col=m:-1:1
  for row = 1:n
      %move all the pIyels below of the seam to the new image 
      if (row < rowStart) 
          Iy(row,col,:) = I(row,col,:);
          
      %move all the pIyels above the seam to the new image 
      elseif (row > rowStart) 
          Iy(row-1,col,:) = I(row,col,:);
      end 
  end
   
  %Calculate the cost of the seam
  currentCost = My(rowStart,col); 
  E = E + currentCost; 
  
  %see which column to have the seam cut across next 
  pathUp = Tby(rowStart,col);
    
  %set the column to start at based on Tby
  if (pathUp == -1)
      rowStart = rowStart+1;
  elseif (pathUp == 1) 
      rowStart = rowStart-1;
  elseif (pathUp == 0)
      rowStart = rowStart; 
  end
  
  Iy = Iy(1:n-1,:,:);
  Iy = uint8(Iy);
end