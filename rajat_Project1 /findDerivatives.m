function [Mag, Magx, Magy, Ori] = findDerivatives(I_gray)
%%  Description
%       compute gradient from grayscale image 
%%  Input: 
%         I_gray = (H, W), double matrix, grayscale image matrix 
%
%%  Output:
%         Mag  = (H, W), double matrix, the magnitued of derivative%  
%         Magx = (H, W), double matrix, the magnitude of derivative in x-axis
%         Magy = (H, W), double matrix, the magnitude of derivative in y-axis
% 				Ori = (H, W), double matrix, the orientation of the derivative
%
%% ****YOU CODE STARTS HERE**** 

%% The Gaussian Function 
G = [2, 4, 5, 4, 2; 4, 9, 12, 9, 4;5, 12, 15, 12, 5;4, 9, 12, 9, 4;2, 4, 5, 4, 2];
G = 1/159.* G;

%% derivative function 
dx = [1,0,-1];
dy = [1;0;-1];

%% Calculate the gradient with smoothing of Gaussian 
Gx = conv2(G,dx,'same');
Gy = conv2(G,dy,'same');

%% Calculate the gradient of the images in x and y axis 
Magx = conv2(I_gray,Gx,'same');
Magy = conv2(I_gray,Gy,'same');

%% Calculate the magnitude of the gradient of the image 
Mag = sqrt(Magx.*Magx + Magy.*Magy); 

%% Calculate the orientation of the gradient of the image 
Ori = atan2(Magy,Magx)+3.1415;

end