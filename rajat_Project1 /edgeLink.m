function E = edgeLink(M, Mag, Ori)
%%  Description
%       use hysteresis to link edges
%%  Input: 
%        M = (H, W), logic matrix, output from non-max suppression
%        Mag = (H, W), double matrix, the magnitude of gradient
%    		 Ori = (H, W), double matrix, the orientation of gradient
%
%%  Output:
%        E = (H, W), logic matrix, the edge detection result.
%
%% ****YOU CODE STARTS HERE**** 

[H,W] = size(Mag);

%% Get all the magnitudes of all the non-zeros 
J = M .* Mag;

%% Set the thresholds
k_low = 2; 
k_high = 2.5 * k_low; 

%% Do the thresholding 
%Set all the values in J equal to 1 if they meet high threshold 
%Set all the values in J equal to 0 if they don't meet low threshold 
%Set all the values in J equal to 0.5 if they are between low and high
%threshold
high = J >= k_high;
halves = ((J >= k_low) & (J < k_high)).*.5;
high_low = high + halves;

%% Descretize the angles into 4 bins 
angle = Ori; 
angle(angle<0) = pi+angle(angle<0);
angle(angle>7*pi/8) = pi-angle(angle>7*pi/8);
angle(angle>=0&angle<pi/8) = 0;
angle(angle>=pi/8&angle<3*pi/8) = pi/4;
angle(angle>=3*pi/8&angle<5*pi/8) = pi/2;
angle(angle>=5*pi/8&angle<=7*pi/8) = 3*pi/4;

%% Counter for testing
%Counter just for testing! Not used anywhere. 
counter = 0; 

%% Main loop over the image 
%loop over all the rows and columns and do recursion 
%whenever you find a pixel that meets high threshold 
for row = (1:H)
    for col = (1:W)
        if (high_low(row,col) == 1)
            hysteresis(row,col); %do recursion
        end
    end
end 

%% Hysteresis Helper Function for Recursion 
%@param row index of row
%@param col index of column
function [] = hysteresis(row, col)
    
    %edges are perpendicular to the gradient 
    edge = angle(row,col) + pi/2;
   
    switch edge 
        %Check pixel at pi/2 and -pi/2
        case pi/2
            if inBounds(row-1, col)
                if (high_low(row-1, col)==0.5)
                    high_low(row-1, col)=1;
                    counter = counter + 1; 
                    hysteresis(row-1,col);
                end
            end 
            
            if inBounds(row+1, col)
                if (high_low(row+1, col)==0.5)
                    high_low(row+1, col)=1;
                    counter = counter + 1; 
                    hysteresis(row+1,col);
                end
            end
        
        %check pixel at 3*pi/4 and 7*pi/4
        case 3*pi/4
            if inBounds(row-1,col-1)
                if (high_low(row-1, col-1)==0.5)
                    high_low(row-1, col-1)=1;
                    counter = counter + 1; 
                    hysteresis(row-1,col-1);
                end
            end
            if inBounds(row+1, col+1)
                if (high_low(row+1, col+1)==0.5)
                    high_low(row+1, col+1)=1;
                    counter = counter + 1; 
                    hysteresis(row+1,col+1);
                end
            end
            
        %check pixels at pi and -pi
        case pi
            if inBounds(row, col-1)
                if (high_low(row, col-1)==0.5)
                    high_low(row, col-1)=1;
                    counter = counter + 1; 
                    hysteresis(row,col-1);
                end
            end
            if inBounds(row, col+1)
                if (high_low(row, col+1)==0.5)
                    high_low(row, col+1)=1;
                    counter = counter + 1; 
                    hysteresis(row,col+1);
                end
            end
            
        %check pixels at 5*pi/4 and pi/4
        case 5*pi/4
            if inBounds(row+1, col-1)
                if (high_low(row+1, col-1)==0.5)
                    high_low(row+1, col-1)=1;
                    counter = counter + 1; 
                    hysteresis(row+1,col-1);
                end
            end
            if inBounds(row-1, col+1)
                if (high_low(row-1, col+1)==0.5)
                    high_low(row-1, col+1)=1;
                    counter = counter + 1; 
                    hysteresis(row-1,col+1);
                end
            end
    end
end

%% Check if particular rows and columns are within bounds
%@param row index of row
%@param col index of column
%@return out boolean of whether row and column is inBounds
function out = inBounds(row,col)
    out = (row > 0) | (col > 0) | (row < H) | (col < W);
end

%% Remove pixels between low and high threshold (the 0.5's) 
%get rid of all the pixels that pass the low threshold but not 
%the high threshold 
E = high_low==1;

disp(counter);

end