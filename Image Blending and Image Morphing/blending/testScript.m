%load the source and the target images 
sourceImg = imread('SourceImage.jpg'); 
targetImg = imread('TargetImage.jpg');
sourceImg = imresize(sourceImg, 0.35); 

%find the mask of the image 
mask = maskImage (sourceImg); 

%set any offsets
offsetX = 250; 
offsetY = 180; 

%%final image
resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY);
figure; imshow(resultImg); 