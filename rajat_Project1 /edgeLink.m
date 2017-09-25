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

k_low = 0.035; 
k_high = 0.07; 

% for weak edge
threshold_low = k_low * M; 
% for strong edge
threshold_high = k_high * M; 


end