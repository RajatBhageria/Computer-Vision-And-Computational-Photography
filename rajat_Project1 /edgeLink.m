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

k_low = 10; 
k_high = 20; 

[H,W] = size(Mag);

%% Hysteresis 
% for weak edge
threshold_low = M > k_low
% for strong edge
threshold_high = M > k_high

%E = zeros(H, W);


end