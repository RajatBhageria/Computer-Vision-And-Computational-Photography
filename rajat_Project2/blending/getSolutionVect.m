function solVectorb = getSolutionVect(indexes, source, target, offsetX, offsetY)
%% Enter Your Code Here
%% Calculate the masked gradient angles and magnitude of source 
IxSource = conv2(source, [1,0,-1]); 
IySource = conv2(source, [1,0,-1]'); 

mask = maskImage(source); 

gradientMagSource = (IxSource^2 + IySource^2)^.5;
gradientAnglesSource = atan2(IySource, IxSource); 

maskedGradientMagSource = gradientMagSource * mask; 
maskedGradientAnglesSource = gradientAnglesSource * mask; 

%% Calculate the masked gradient angles and magnitude of target 
IxTarget = conv2(target, [1,0,-1]); 
IyTarget = conv2(target, [1,0,-1]'); 

inverseMask = ~mask;

gradientMagTarget = (IxTarget^2 + IyTarget^2)^.5;
gradientAnglesTarget = atan2(IyTarget, IxTarget); 

maskedGradientMagTarget = gradientMagTarget * inverseMask; 
maskedGradientAnglesTarget = gradientAnglesTarget * inverseMask; 

%% Copy the gradient mag and source of masked source to target 
finalGradientMag = maskedGradientMagSource + maskedGradientMagTarget; 
finalGradientAngles = maskedGradientAnglesSource + maskedGradientAnglesTarget; 

%% Compute the final gradient in x and y directions 
IxFinal = finalGradientMag *cos(finalGradientAngles); 
IyFinal = finalGradientMag *sin(finalGradientAngles); 

%% Find the vinal vector b 
bTop = conv2(IxFinal, [1,0,-1]'); 
bBottom = conv2(IyFinal, [1,0,-1]); 

%% Return the final b 
solVectorb = [bTop;bBottom];
end
