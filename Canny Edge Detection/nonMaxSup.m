function M = nonMaxSup(Mag, Ori)
%%  Description
%       compute the local minimal along the gradient.
%%  Input: 
%         Mag = (H, W), double matrix, the magnitude of derivative 
%         Ori = (H, W), double matrix, the orientation of derivative
%%  Output:
%         M = (H, W), logic matrix, the edge map
%
%% ****YOU CODE STARTS HERE**** 
[H,W] = size(Mag);

%set up meshgrid
[x,y] = meshgrid(1:W,1:H);

%Get the pixel coordinates in the positive and negative directions 
x_positive = x + cos(Ori);
y_positive = y + sin(Ori);
x_negative = x - cos(Ori); 
y_negative = y - sin(Ori);

%Get the interpolated pixel intensities for virtual pixels 
VqPositive = interp2(x,y,Mag,x_positive,y_positive);
VqNegative = interp2(x,y,Mag,x_negative,y_negative);

%create the final M matrix by setting all the points where the pixel is 
%greater than the pixels in the positive and negative orientations 
%equal to 1. 
M = zeros(H,W); 
M((VqPositive <= Mag) & (VqNegative <= Mag)) = 1;

end