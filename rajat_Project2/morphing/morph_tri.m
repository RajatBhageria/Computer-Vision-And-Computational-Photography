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

morphed_im=[];
[n,m] = size(im2);
[x,y]=meshgrid(1:n, 1:m);
imageCoordinates=[x(:),y(:)];

for t = 1:size(warp_frac,1)
    time = warp_frac(t);
    
    %Find average shape! 
    avg = (1-time)*im1_pts + time*im2_pts;
    
    %Find triangulation of average shape
    TRI = delaunay(avg);
    
    %see what triangle each pixel is in
    t = tsearchn(im2_pts,TRI,imageCoordinates);

    %loop over num triangles 
    [numTriangles,~] = size(tri);
    for i = 1:numTriangles
        %find the vectors comprising traingle i 
        triangle = TRI(i,:);
        %find the x,y points on the source image of the triangle
        sourcePoints = im2_pts(triangle,:)';  
        %append (1,1,1) to bottom of matrix to find barycentric coordinates
        %of triangle 
        matrix = [sourcePoints;[1,1,1]];
        
        %find the pixels in the source image that are in triangle i 
        inTriangle = find(t==i);
        %make a matrix with x,y cooridinates of the pixels in triangle i
        %with ones attached as well 
        verticesInsideTriangle = [x(inTriangle),y(inTriangle),ones(size(inTriangle,1),1)]';
        
        %these are the barycentric coordinates of all the pixels inside the
        %triangle 
        barycentric = matrix \ verticesInsideTriangle;
        
        %now you use barycentric to find the x,y values of the our initial
        %frame! 
       
    end
    
    %final result from warping 
    im1Warped = ;
    im2Warped = ; 
    
    %do the cross dissolve 
    dissolveFrac = dissolve_frac(time);
    finalImage = (1-dissolveFrac)*im1Warped + dissolveFrac * im2Warped;
    
    morphed_im = [morphed_im;finalImage];
end



end


