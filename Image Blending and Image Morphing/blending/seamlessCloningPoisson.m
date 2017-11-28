function resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY)
    %convert the source image and the target images to doubles. 
%    sourceImg = im2double(sourceImg);
%    targetImg = im2double(targetImg);

    [targetH, targetW,~] = size(targetImg); 

    %find the indexes of the region omega we're blending from the source
    %image to the target image 
    indexes  = getIndexes(mask, targetH, targetW, offsetX, offsetY);

    %find the coefficient matrix A
    coeffA = getCoefficientMatrix(indexes); 

    %find the b vector for each of the different channels 
    redb = getSolutionVect(indexes,sourceImg(:,:,1),targetImg(:,:,1),offsetX, offsetY); 
    greenb = getSolutionVect(indexes,sourceImg(:,:,2),targetImg(:,:,2),offsetX, offsetY); 
    blueb = getSolutionVect(indexes,sourceImg(:,:,3),targetImg(:,:,3),offsetX, offsetY); 
    
    %find f, the solution x vector 
    red = coeffA \ redb;
    green = coeffA \ greenb;
    blue = coeffA \ blueb;
    
    %remove intensities less than 0 or greater than 255
    red(red<0) = 0;
    red(red>255)=255;
    green(green<0) = 0;
    green(green>255)=255;    
    blue(blue<0) = 0;
    blue(blue>255)=255; 
    
    %find the result image and reconstruct it. 
    resultImg = reconstructImg(indexes, red, green, blue, targetImg);
   
end
