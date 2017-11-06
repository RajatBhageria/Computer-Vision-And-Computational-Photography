% File Name: rmVerSeam.m
% Author: Rajat Bhageria
% Date: Saturday Oct 29 

function [Ix, E] = rmVerSeam(I, Mx, Tbx)
% Input:
%   I is the image. Note that I could be color or grayscale image.
%   Mx is the cumulative minimum energy map along vertical direction.
%   Tbx is the backtrack table along vertical direction.

% Output:
%   Ix is the image removed one column.
%   E is the cost of seam removal

% Write Your Code Here

[n,m,p] = size(I); 

Ix = zeros(n,m,p); 
E = 0; 

% find the starting point to start the vertical seam removal 
startingVal = min(Mx(n,:));
[~,colStart] = find(Mx(n,:)==startingVal); 
colStart = colStart(1,1); 

%loop over all the rows and cols
for row=n:-1:1
  for col = 1:m
      %move all the pixels left of the seam to the new image 
      if (col < colStart) 
          Ix(row,col,:) = I(row,col,:);
          
      %move all the pixels right of the seam to the new image 
      elseif (col > colStart) 
          Ix(row,col-1,:) = I(row,col,:);
      end 
  end
   
  %Calculate the cost of the seam
  currentCost = Mx(row,colStart); 
  E = E + currentCost; 
  
  %see which column to have the seam cut across next 
  pathUp = Tbx(row,colStart);
    
  %set the column to start at based on Tbx
  if (pathUp == -1)
      colStart = colStart-1;
  elseif (pathUp == 1) 
      colStart = colStart+1;
  elseif (pathUp == 0)
      colStart = colStart; 
  end
  
  Ix = Ix(:,1:m-1,:);
  Ix = uint8(Ix); 
end 
