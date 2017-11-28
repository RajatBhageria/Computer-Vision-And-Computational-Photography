%load the source and the target images 
sourceImg = imread('coffee.jpeg'); 
targetImg = imread('computer.jpeg');

%find the mask of the image 
mask = maskImage (sourceImg); 

%set any offsets
offsetX = -20; 
offsetY = 0; 

%%final image
resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY);
figure; imshow(resultImg); 