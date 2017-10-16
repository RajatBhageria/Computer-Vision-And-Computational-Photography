function [morphed_im] = morph_tri(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac)
%MORPH_TRI Image morphing via Triangulation
%	Input im1: target image
%	Input im2: source image
%	Input im1_pts: correspondences coordiantes in the target image
%	Input im2_pts: correspondences coordiantes in the source image
%	Input warp_frac: a vector contains warping parameters
%	Input dissolve_frac: a vector contains cross dissolve parameters
% 
%	Output morphed_im: a set of morphed images obtained from different warp and dissolve parameters
% Helpful functions: delaunay, tsear`chn

[n,m] = size(im2);
[x,y]=meshgrid(1:n, 1:m);
imageCoordinates=[x(:),y(:)]; %all the pixels in the image

morphed_im=[]; %end result 

for frame = 1:size(warp_frac,1)
    time = warp_frac(frame);
    
    %Find average shape! 
    avg = (1-time)*im1_pts + time*im2_pts;
    
    %Find triangulation of average shape
    TRI = delaunay(avg);
    
    %see what triangle each pixel is in the result image 
    t = tsearchn(avg,TRI,imageCoordinates);
    
    im1Warped = []; %before cross dissolve
    im2Warped = []; %before cross dissolve 

    %loop over num triangles 
    [numTriangles,~] = size(TRI);
    for i = 1:numTriangles
        %find the vectors comprising traingle i 
        triangle = TRI(i,:);
        %find the x,y points on the average image of the triangle
        avgPoints = avg(triangle,:)';  
        %append (1,1,1) to bottom of matrix to find barycentric coordinates
        %of triangle 
        matrix = [avgPoints;[1,1,1]];
        
        %find the pixels in the source image that are in triangle i 
        inTriangle = find(t==i);
        %make a matrix with x,y cooridinates of the pixels in triangle i
        %with ones attached as well 
        verticesInsideTriangle = [x(inTriangle),y(inTriangle),ones(size(inTriangle,1),1)]';
        
        %these are the barycentric coordinates of all the pixels inside the
        %triangle
        barycentric = matrix \ verticesInsideTriangle;
        
        %use barycentric to find the new x,y values of the the first image
        img1Points = im1_pts(triangle,:)';  
        img1Matrix = [img1Points;[1,1,1]];
        coordinatesInIm1 = img1Matrix*barycentric;
        coordinatesInIm1 = round(coordinatesInIm1);
        xs1 = coordinatesInIm1(1,:)';
        ys1 = coordinatesInIm1(2,:)';
        
        %use barycentric to find the new x,y values of the the second image
        img2Points = im2_pts(triangle,:)';  
        img2Matrix = [img2Points;[1,1,1]];
        coordinatesInIm2 = img2Matrix*barycentric;
        coordinatesInIm2 = round(coordinatesInIm2);
        xs2 = coordinatesInIm2(1,:)';
        ys2 = coordinatesInIm2(2,:)';
        
        %put the coordinates in for the two new warped images 
        im1Warped(xs1,ys1,1:3) = im1(x(inTriangle),y(inTriangle),1:3);
        im2Warped(xs2,ys2,1:3) = im2(x(inTriangle),y(inTriangle),1:3);
    end
    
    %do the cross dissolve 
    dissolveFrac = dissolve_frac(frame);
    finalImage = (1-dissolveFrac)*im1Warped + dissolveFrac * im2Warped;
    
    morphed_im = [morphed_im;finalImage];
end

end