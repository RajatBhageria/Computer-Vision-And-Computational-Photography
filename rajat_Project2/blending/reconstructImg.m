function resultImg = reconstructImg(indexes, red, green, blue, targetImg)
%% Enter Your Code Here
redSolnb = getSolutionVect(indexes, red, targetImg, offsetX, offsetY); 
greenSolnb = getSolutionVect(indexes, green, targetImg, offsetX, offsetY); 
blueSolnb = getSolutionVect(indexes, blue, targetImg, offsetX, offsetY); 

coeffA = getCoefficientMatrix(indexes);

xRed = coeffA \ redSolnb; 
xGreen = coeffA \ greenSolnb; 
xBlue = coeffA \ blueSolnb; 

redReshape = reshape(xRed,size(targetImg));
greenReshape = reshape(xGreen,size(targetImg));
blueReshape = reshape(xBlue,size(targetImg));

resultImg = cat(3, redReshape, greenReshape, blueReshape);  

end