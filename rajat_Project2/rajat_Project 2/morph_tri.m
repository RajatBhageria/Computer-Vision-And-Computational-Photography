function [morphed_im] = morph_tri(im2, im1, im2_pts, im1_pts, warp_frac, dissolve_frac)
%MORPH_TRI Image morphing via Triangulation
%	Input im1: target image
%	Input im2: source image
%	Input im1_pts: correspondences coordiantes in the target image
%	Input im2_pts: correspondences coordiantes in the source image
%	Input warp_frac: a vector contains warcoordinatesInTriangleng parameters
%	Input dissolve_frac: a vector contains cross dissolve parameters
%	Output morphed_im: a set of morphed images obtained from different warp and dissolve parameters
% Helpful functions: delaunay, tsearchn

[n,m,~] = size(im2);
[x,y] = meshgrid(1:m, 1:n);
imageCoordinates=[x(:),y(:)]; %all the coordinatesInTrianglexels in the image

numFrames = size(warp_frac,2);
morphed_im=cell(numFrames,1); %end result 

for frame = 1:numFrames
    weight = warp_frac(frame);
    
    %Find average shape! 
    avg = (1-weight)*im2_pts + weight*im1_pts;
    
    %Find triangulation of average shape
    TRI = delaunay(avg);
    
    %see what triangle each coordinatesInTrianglexel is in the result image
    t = tsearchn(avg,TRI,imageCoordinates);

    %loop over num triangles 
    [numTriangles,~] = size(TRI);
    for i = 1:numTriangles
        %find the vectors comprising traingle i 
        triangle = TRI(i,:);
        %find the x,y points on the average image of the triangle
        avgPoints = avg(triangle,:)';  
        %append (1,1,1) to bottom of matrix to find barycentric coordinates of triangle 
        matrix = [avgPoints;[1,1,1]];
        
        %find the coordinatesInTrianglexels in the average image that are in triangle i 
        inTriangle = find(t==i);
        
        %find the number of coordinatesInTrianglexels in the triangle 
        numcoordinatesInTriangles = size(inTriangle,1); 
        
        %make a matrix with x,y cooridinates of the coordinatesInTrianglexels in triangle i
        %with ones attached as well 
        verticesInsideTriangle = [x(inTriangle),y(inTriangle),ones(numcoordinatesInTriangles,1)]';
        
        %these are the barycentric coordinates of all the coordinatesInTrianglexels inside the
        %triangle
        barycentric = matrix \ verticesInsideTriangle;
        
        %use barycentric to find the new x,y values of the the first image
        img1Points = im1_pts(triangle,:)';  
        img1Matrix = [img1Points;[1,1,1]];
        coordinatesInIm1 = img1Matrix*barycentric; 
        
        %standardize z axis of Im1 coordinates by dividing x and y by z 
        coordinatesInIm1(1,:) =  coordinatesInIm1(1,:)./ coordinatesInIm1(3,:);
        coordinatesInIm1(2,:) =  coordinatesInIm1(2,:)./ coordinatesInIm1(3,:);
        coordinatesInIm1 = round(coordinatesInIm1);
        
        %use barycentric to find the new x,y values of the the second image
        img2Points = im2_pts(triangle,:)';  
        img2Matrix = [img2Points;[1,1,1]];
        coordinatesInIm2 = img2Matrix*barycentric;
        
        %standardize z axis of Im1 coordinates by dividing x and y by z 
        coordinatesInIm2(1,:) =  coordinatesInIm2(1,:)./ coordinatesInIm2(3,:);
        coordinatesInIm2(2,:) =  coordinatesInIm2(2,:)./ coordinatesInIm2(3,:);
        coordinatesInIm2 = round(coordinatesInIm2);
        
        %take care of any coordinates less than 1 
        coordinatesInIm1(coordinatesInIm1<1) = 1;
        coordinatesInIm2(coordinatesInIm2<1) = 1;
        
        %for each of the pixels 
        for pixels = 1:size(verticesInsideTriangle,2)
            
            %do image warping 
            coordinatesInTriangle = verticesInsideTriangle(1:2, pixels); 
            positionsOfPixelsIm1 = coordinatesInIm1(1:2, pixels); %take the x and ys (leave out the 1s in the third row)
            positionsOfPixelsIm2 = coordinatesInIm2(1:2, pixels); %take the x and ys (leave out the 1s in the third row)
            
            %replace the x and ys in im1 and im2 with positionsOfPixelsIm1 and positionsOfPixelsIm2 
            im1warped = im1(positionsOfPixelsIm1(1), positionsOfPixelsIm1(2), :); 
            im2warped = im2(positionsOfPixelsIm2(1), positionsOfPixelsIm2(2), :);
            
            %do the cross dissolve 
            dissolveFrac = dissolve_frac(frame);
            crossDissolved = im2warped .* (1-dissolveFrac) + im1warped.*dissolveFrac;
            
            %replaced the old pixels with all the new cross dissolved pixels
            morphed_im{frame}(coordinatesInTriangle(1), coordinatesInTriangle(2), :) = crossDissolved; 
        end
        
    end
end

end