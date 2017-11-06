function mask = maskImage(Img)
%% Enter Your Code Here
   img = imshow(Img); 
   hold on; 
   h = imfreehand; 
   mask = createMask(h,img); 
end

